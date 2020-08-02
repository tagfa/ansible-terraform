##########################################################
# Security Group for ALB
##########################################################
variable "vpc_id" {}

resource "aws_security_group" "this" {
    name          = "alb_sg"
    vpc_id        = var.vpc_id
    ingress{
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
   egress{
       from_port  = 0
       to_port    = 0
       protocol   = "-1"
       cidr_blocks=["0.0.0.0/0"]
   }
}


##########################################################
# ALB
##########################################################
variable "subnet_public_a_ALB_id"{}
variable "subnet_public_c_ALB_id"{}

resource "aws_lb" "this" {
  name               = "webserver-alb"
  internal           = false 
  load_balancer_type = "application"

  security_groups    = [
    aws_security_group.this.id
  ]

  subnets            = [
      var.subnet_public_a_ALB_id,
      var.subnet_public_c_ALB_id,
  ]
}


##########################################################
# ALB Listener
##########################################################
variable "ec2_a_id"{}
variable "ec2_c_id"{}

# target group
resource "aws_lb_target_group" "this" {
  name        = "webserver-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
        path        = "/index.html"
  }
}

# attach instance to target group
resource "aws_lb_target_group_attachment" "ec2_a" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_a_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ec2_c" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_c_id
  port             = 80
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

}
