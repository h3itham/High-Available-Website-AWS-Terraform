resource "aws_vpc" "Cluster-VPC" {
  cidr_block       = "192.168.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "Cluster-VPC"
  }
}
resource "aws_subnet" "public_us_east_1a" {
  vpc_id     = aws_vpc.Cluster-VPC.id
  cidr_block = "192.168.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Public Subnet us-east-1a"
  }
}
resource "aws_subnet" "public_us_east_1b" {
  vpc_id     = aws_vpc.Cluster-VPC.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Public Subnet us-east-1b"
  }
}
resource "aws_internet_gateway" "Cluster-IGW" {
  vpc_id = aws_vpc.Cluster-VPC.id
  tags = {
    Name = "Cluster-IGW"
  }
}
resource "aws_route_table" "Cluster-RT-PUB" {
    vpc_id = aws_vpc.Cluster-VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Cluster-IGW.id
    }
    tags = {
        Name = "Public Subnets Route Table for My VPC"
    }
}
resource "aws_route_table_association" "Cluster-RTA-us-east-1a" {
    subnet_id = aws_subnet.public_us_east_1a.id
    route_table_id = aws_route_table.Cluster-RT-PUB.id
}
resource "aws_route_table_association" "Cluster-RTA-us-east-1b" {
    subnet_id = aws_subnet.public_us_east_1b.id
    route_table_id = aws_route_table.Cluster-RT-PUB.id
}
