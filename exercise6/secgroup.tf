resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "Allow ssh from admin and all traffic on port 80"
  vpc_id      = aws_vpc.web-vpc.id

  #ingress rules
  ingress {
    description = "Allow ssh from Admin"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MY_IP]
  }

  ingress {
    description = "Allow HTTP from Admin"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Egress rule
  egress {
    description = "Allow acess on all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-sg"
  }
}
