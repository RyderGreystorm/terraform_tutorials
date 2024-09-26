#VPC CODE BLOCK
resource "aws_vpc" "web-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "VPC for webapp"
  }
}

#Public subnets in our web-vpc
resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.web-vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.ZONE1
  tags = {
    Name = "Public subnet 1"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.web-vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.ZONE2
  tags = {
    Name = "Public subnet 2"
  }
}

resource "aws_subnet" "pub_sub3" {
  vpc_id                  = aws_vpc.web-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE3
  tags = {
    Name = "Public subnet 3"
  }
}

#Private subnets in our web-vpc
resource "aws_subnet" "priv_sub1" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.ZONE1
  tags = {
    Name = "Private subnet 1"
  }
}

resource "aws_subnet" "priv_sub2" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.ZONE2
  tags = {
    Name = "Private subnet 2"
  }
}

resource "aws_subnet" "priv_sub3" {
  vpc_id            = aws_vpc.web-vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = var.ZONE3
  tags = {
    Name = "Private subnet 3"
  }
}


#Internet Gateway for the VPC
resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.web-vpc.id

  tags = {
    Name = "Internet Gateway for web-vpc"
  }
}

#Connecting Public subnet with internet gateway through route table
#Route table in web-vpc
resource "aws_route_table" "web-vpc-RT" {
  vpc_id = aws_vpc.web-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }

  tags = {
    Name = "Internet-gw-RT"
  }
}

#Associate route table with public all 3 subnets

resource "aws_route_table_association" "pub-sub-1-assoc" {
  subnet_id      = aws_subnet.pub_sub1.id
  route_table_id = aws_route_table.web-vpc-RT.id
}

resource "aws_route_table_association" "pub-sub-2-assoc" {
  subnet_id      = aws_subnet.pub_sub2.id
  route_table_id = aws_route_table.web-vpc-RT.id
}

resource "aws_route_table_association" "pub-sub-3-assoc" {
  subnet_id      = aws_subnet.pub_sub3.id
  route_table_id = aws_route_table.web-vpc-RT.id
}
