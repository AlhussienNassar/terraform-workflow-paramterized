# Creating VPC
resource "aws_vpc" "demovpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "Demo VPC"
  }
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "demogateway" {
  vpc_id = aws_vpc.demovpc.id
}

# Grant the internet access to VPC by updating its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.demovpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.demogateway.id
}

# Creating 1st subnet 
resource "aws_subnet" "demosubnet1" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block             = var.subnet1_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "Demo subnet 1"
  }
}

# Creating 2nd subnet 
resource "aws_subnet" "demosubnet2" {
  vpc_id                  = aws_vpc.demovpc.id
  cidr_block             = var.subnet2_cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "Demo subnet 2"
  }
}
