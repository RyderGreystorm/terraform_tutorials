provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "intro" {
  ami                    = "ami-0a0e5d9c7acc336f1"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "kopskey"
  vpc_security_group_ids = ["sg-04c5a4dc30d6cf4fc"]
  tags = {
    Name    = "kops_instance"
    Project = "K8s"
  }
}