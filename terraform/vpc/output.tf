output "vpc_id" {
    value = "${aws_vpc.this.id}"
}

output "subnet_public_a_EC2_id" {
  value = "${aws_subnet.public_a_EC2.id}"
}

output "subnet_public_c_EC2_id" {
  value = "${aws_subnet.public_c_EC2.id}"
}

output "subnet_public_a_ALB_id" {
  value = "${aws_subnet.public_a_ALB.id}"
}

output "subnet_public_c_ALB_id" {
  value = "${aws_subnet.public_c_ALB.id}"
}

