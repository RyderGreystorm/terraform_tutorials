resource "aws_instance" "test-instance" {
  ami                    = var.AMIS[var.REGION1]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = var.keyName
  vpc_security_group_ids = ["sg-04c5a4dc30d6cf4fc"]
  tags = {
    project = "TEST_PROJECT"
  }
}
