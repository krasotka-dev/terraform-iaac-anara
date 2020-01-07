provider "aws"{
  region = "us-east-1"
}

module "instance" {
  source = "./module"
  ami = "ami-00068cd7555f543d5"
  instance_type = "t2.micro"
}
