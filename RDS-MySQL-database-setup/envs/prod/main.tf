module "global_provider" {
  source = "../../global"
  aws_region = var.aws_region
}

provider "aws" {
  region = var.aws_region
}

module "ec2_sg" {
  source = "../../modules/security_group"
  name = "ec2-client-sg-${var.aws_region}"
  vpc_id = var.vpc_id
  ingress_rules = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = var.db_admin_cidrs, description = "SSH from admin CIDRs" }
  ]
  egress_rules = [ { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] } ]
  tags = var.tags
}

module "rds_sg" {
  source = "../../modules/security_group"
  name = "rds-sg-${var.aws_region}"
  vpc_id = var.vpc_id
  ingress_rules = [
    { from_port = 3306, to_port = 3306, protocol = "tcp", source_sg_id = module.ec2_sg.security_group_id, description = "Allow MySQL from EC2 client" }
  ]
  egress_rules = [ { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] } ]
  tags = var.tags
}

variable "secret_name" {
  type = string
}

module "rds" {
  source = "../../modules/rds_mysql"
  environment = "prod"
  db_name = var.db_name
  username = var.db_username
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  db_subnet_ids = var.db_subnet_ids
  tags = var.tags
  secret_name         = var.secret_name 
  password_secret_arn = "" 
}

module "ec2_iam" {
  source = "../../modules/ec2_client"
  secret_arn = module.rds.secret_arn
  ami_id = var.ec2_ami
  subnet_id = var.ec2_subnet_id
  security_group_ids = var.security_group_ids
}

data "template_file" "user_data" {
  template = file("../../modules/ec2_client/user-data.sh")
  vars = {
    SECRET_ARN = module.rds.secret_arn
    DB_HOST    = module.rds.endpoint
    DB_PORT    = module.rds.port
    DB_USER    = var.db_username
  }
}

module "ec2_client" {
  source = "../../modules/ec2_client"
  ami_id = var.ec2_ami
  subnet_id = var.ec2_subnet_id
  security_group_ids = [module.ec2_sg.security_group_id]
  key_name = var.ec2_key_name
  iam_instance_profile_arn = module.ec2_iam.instance_profile_arn
  user_data = data.template_file.user_data.rendered
  tags = var.tags
}

output "rds_endpoint" { value = module.rds.endpoint }
output "rds_secret_arn" { value = module.rds.secret_arn }
output "ec2_client_public_ip" { value = module.ec2_client.public_ip }