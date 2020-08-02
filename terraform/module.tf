## VPC
module "vpc" {
  source                  = "./vpc"
  vpc_cidr_block          = "10.1.0.0/16"
  vpc_name                = "sampleVPC123"
  subnet_cidr_block_a_ALB = "10.1.1.0/24"
  subnet_cidr_block_c_ALB = "10.1.2.0/24"
  subnet_cidr_block_a_EC2 = "10.1.3.0/24"
  subnet_cidr_block_c_EC2 = "10.1.4.0/24"
 
}

module "ec2" {
  source                 = "./ec2"
  vpc_id                 = module.vpc.vpc_id
  subnet_public_a_EC2_id = module.vpc.subnet_public_a_EC2_id
  subnet_public_c_EC2_id = module.vpc.subnet_public_c_EC2_id

}

module "elb"{
  source                 = "./elb"
  vpc_id                 = module.vpc.vpc_id
  subnet_public_a_ALB_id = module.vpc.subnet_public_a_ALB_id
  subnet_public_c_ALB_id = module.vpc.subnet_public_c_ALB_id
  ec2_a_id               = module.ec2.ec2_a_id
  ec2_c_id               = module.ec2.ec2_c_id

}



