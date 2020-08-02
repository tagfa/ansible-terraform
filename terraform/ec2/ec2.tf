##########################################################
# Security Group
##########################################################
variable "vpc_id" {}
resource "aws_security_group" "this" {
  name   = "tf-web-sg"
  vpc_id = var.vpc_id
  
  # ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

description = "tf-web-sg"
}


##########################################################
# EC2
##########################################################
variable "subnet_public_a_EC2_id" {}
variable "subnet_public_c_EC2_id" {}

resource "aws_instance" "ec2_a" {
  ami                     = "ami-0cc75a8978fbbc969"
  instance_type           = "t3.micro"
  disable_api_termination = false
  key_name                = "sample02"
  vpc_security_group_ids  = ["${aws_security_group.this.id}"]
  subnet_id               = var.subnet_public_a_EC2_id
  associate_public_ip_address = "true"
  tags = {
    Name = "sampleEC2123_a",
    Type = "tf_web"
  }
}

resource "aws_instance" "ec2_c" {
  ami                     = "ami-0cc75a8978fbbc969"
  instance_type           = "t3.micro"
  disable_api_termination = false
  key_name                = "sample02"
  vpc_security_group_ids  = ["${aws_security_group.this.id}"]
  subnet_id               = var.subnet_public_c_EC2_id
  associate_public_ip_address = "true"
  tags = {
    Name = "sampleEC2123_c",
    Type = "tf_web"
  }
}
