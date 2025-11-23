resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

    tags = {
        Name = "main-vpc"
    }
}

resource "aws_subnet" "private" {
    count                  = length(var.private_subnet_cidr)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.private_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
    tags = {
        Name = "private-subnet-${count.index + 1}"
    }
}

# Public Subnet and Internet Gateway
# here we create a public subnet and an internet gateway for public access

resource "aws_subnet" "public" {
    count                  = length(var.availability_zones)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-${count.index + 1}"
    }
}

# Internet Gateway and Route Table for Public Subnet

resource "aws_internet_gateway" "public_igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "public-internet-gateway"
    }
  
}

# Route Table for Public Subnet
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.public_igw.id
    }

    tags = {
        Name = "public-route-table"
    }
}

# now we need to add a route table association for the public subnet
resource "aws_route_table_association" "public_assoc" { 
    count          = length(var.availability_zones)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

# NAT Gateway for Private Subnet

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private_nat.id
    }
    tags = {
        Name = "private-route-table"
    }
}

resource "aws_route_table_association" "private_assoc" {
    count          = length(var.private_subnet_cidr)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}