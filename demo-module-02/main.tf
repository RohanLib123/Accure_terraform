module "test-vpc" {
  source = "./modules/test-vpc"

  vpc_cidr_block = var.vpc_cidr_block
}

module "test-subnet" {
  source = "./modules/test-subnet"

  vpc_id            = module.test-vpc.vpc_id
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone

}

module "test-route-table" {
  source = "./modules/test-route-table"

  vpc_id         = module.test-vpc.vpc_id
  vpc_cidr_block = var.vpc_cidr_block
  subnet_id      = module.test-subnet.subnet_id
  #igw_id = module.test-internet-gateway.igw_id

}

module "test-internet-gateway" {
  source = "./modules/test-internet-gateway"
  vpc_id = module.test-vpc.vpc_id

}
