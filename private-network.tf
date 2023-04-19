
/**
 * Create a private subnet
 */
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.default.id
  cidr_block = "10.0.20.0/24"
  tags = {
    Name = "IIM-private-subnet-1"
  }
}

resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "IIM-eip"
  }  
}

/**
** Create a public NAT gateway
*/
resource "aws_nat_gateway" "default" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "IIM-nat"
  }
}

/*
** Create a private route table
*/
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.default.id
  }

  tags = {
    Name = "IIM-Private"
  }
}

/**
 * Associate the private route table with the private subnet
 */
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}