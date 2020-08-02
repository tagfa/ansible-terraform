##########################################################
# VPN
##########################################################
variable "vpc_cidr_block" {}
variable "vpc_name" {}

resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"
    enable_dns_support = "true"
    tags = {
      Name = var.vpc_name
    }
}

##########################################################
# VPC Subnet
##########################################################
variable "subnet_cidr_block_a_ALB" {}
variable "subnet_cidr_block_c_ALB" {}
variable "subnet_cidr_block_a_EC2" {}
variable "subnet_cidr_block_c_EC2" {}


# For ALB 
resource "aws_subnet" "public_a_ALB" {
  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = var.subnet_cidr_block_a_ALB
  availability_zone = "ap-northeast-1a"
  tags = {
      Name = "subnet_ALB_a"
  }
}

resource "aws_subnet" "public_c_ALB" {
  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = var.subnet_cidr_block_c_ALB
  availability_zone = "ap-northeast-1c"
  tags = {
      Name = "subnet_ALB_c"
  }
}

# For EC2
resource "aws_subnet" "public_a_EC2" {
  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = var.subnet_cidr_block_a_EC2
  availability_zone = "ap-northeast-1a"
  tags = {
      Name = "subnet_EC2_a"
  }
}

resource "aws_subnet" "public_c_EC2" {
  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = var.subnet_cidr_block_c_EC2
  availability_zone = "ap-northeast-1c"
  tags = {
      Name = "subnet_EC2_c"
  }
}

##########################################################
# Internet Gataway
##########################################################
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"
}


##########################################################
# Route Table
##########################################################
resource "aws_route_table" "this" {
    vpc_id = "${aws_vpc.this.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.this.id}"
    }
}

resource "aws_route_table_association" "public_a_ALB" {
    subnet_id = "${aws_subnet.public_a_ALB.id}"
    route_table_id = "${aws_route_table.this.id}"
}

resource "aws_route_table_association" "public_c_ALB" {
    subnet_id = "${aws_subnet.public_c_ALB.id}"
    route_table_id = "${aws_route_table.this.id}"
}

resource "aws_route_table_association" "public_a_EC2" {
    subnet_id = "${aws_subnet.public_a_EC2.id}"
    route_table_id = "${aws_route_table.this.id}"
}

resource "aws_route_table_association" "public_c_EC2" {
    subnet_id = "${aws_subnet.public_c_EC2.id}"
    route_table_id = "${aws_route_table.this.id}"
}

