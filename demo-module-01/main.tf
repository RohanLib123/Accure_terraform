module "demo-instance" {
  source = "./modules/ec2-instance"
  
  ami_id = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.availability_zone
  subnet_id = module.demo-vpc.subnet_id
  key_name = var.key_name
  cpu_core_count = var.cpu_core_count
  cpu_threads_per_core = var.cpu_threads_per_core
  security_group_id = module.demo-sg.security_group_id
}

module "demo-igw" {
  source = "./modules/internet-gateway"
  vpc_id = module.demo-vpc.vpc_id
}

module "demo-route-table" {
  source = "./modules/route-table"
  subnet_id = module.demo-vpc.subnet_id
  vpc_id = module.demo-vpc.vpc_id
  internet_gateway_id = module.demo-igw.internet_gateway_id
}

module "demo-sg" {
  source = "./modules/security-groups"
  vpc_id = module.demo-vpc.vpc_id
}

module "demo-vpc" {
  source = "./modules/vpc-and-subnet"
  
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  availability_zone = var.availability_zone
}