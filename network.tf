/*
** Create a VPC
*/
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "IIM-vpc"
  }
}

/*
** Create a public subnet
*/
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "IIM-subnet-1"
  }
}

/*
** Create an Internet gateway
*/
resource "aws_internet_gateway" "public" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "IIM-ig"
  }
}



/*
** Create a public route table
*/
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public.id
  }
  tags = {
    Name = "IIM-Public"
  }
}


/**
 * Associate the public route table with the public subnet
 */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

