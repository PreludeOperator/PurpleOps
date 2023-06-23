resource "aws_vpc" "PurpleOps-VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "PurpleOps-VPC"
  }
}

resource "aws_subnet" "BlueOps-Subnet" {
  vpc_id                  = aws_vpc.PurpleOps-VPC.id
  cidr_block              = "10.0.0.0/24"

  tags = {
    Name = "BlueOps-Subnet"
  }
}

resource "aws_subnet" "RedOps-Subnet" {
  vpc_id                  = aws_vpc.PurpleOps-VPC.id
  cidr_block              = "10.0.10.0/24"

  tags = {
    Name = "RedOps-Subnet"
  }
}

resource "aws_internet_gateway" "PurpleOps-IG" {
  vpc_id = aws_vpc.PurpleOps-VPC.id

  tags = {
    Name = "PurpleOps-IG"
  }
}

resource "aws_route_table" "PurpleOps-RT" {
  vpc_id = aws_vpc.PurpleOps-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PurpleOps-IG.id
  }

  tags = {
    Name = "PurpleOps-RT"
  }
}

resource "aws_route_table_association" "PurpleOps-RT-Link-1" {
  route_table_id = aws_route_table.PurpleOps-RT.id
  subnet_id      = aws_subnet.RedOps-Subnet.id
}

resource "aws_route_table_association" "PurpleOps-RT-Link-2" {
  route_table_id = aws_route_table.PurpleOps-RT.id
  subnet_id      = aws_subnet.BlueOps-Subnet.id
}