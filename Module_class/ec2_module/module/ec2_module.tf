resource "aws_instance" "web" {
  ami = var.ami
  instance_type = var.instance_type
}
variable "instance_type" {}
variable "ami" {}
