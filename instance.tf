/*
** Create security group
*/
resource "aws_security_group" "security_group_1" {
  name        = "IIM-sg-1"
  description = "IIM-sg-1"
  vpc_id      = aws_vpc.default.id

  // Allow inbound traffic for SSH
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH"
  }
  // Allow inbound traffic for HTTP
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow HTTP"
  }

  // Allow inbound traffic for HTTPS
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
** Create an EC2 instance
*/
resource "aws_instance" "IIM-ec2" {
  tags = {
    Name = "IIM-ec2"
  }
  ami                    = "ami-09dd5f12915cfb387"
  instance_type          = "t2.micro"
  key_name               = "Demo-IIM"
  vpc_security_group_ids = [aws_security_group.security_group_1.id]

  // Connect to subnet
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
}






/*
** Create security group
*/
resource "aws_security_group" "private_security_group_1" {
  name        = "IIM-private-sg-1"
  description = "IIM-private-sg-1"
  vpc_id      = aws_vpc.default.id

  // Allow inbound traffic for SSH
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Allow SSH"
  }
  // Allow inbound traffic for HTTP
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Allow HTTP"
  }

  // Allow inbound traffic for HTTPS
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
** Create an EC2 instance
*/
resource "aws_instance" "IIM-private-ec2" {
  tags = {
    Name = "IIM-private-ec2"
  }
  ami                    = "ami-09dd5f12915cfb387"
  instance_type          = "t2.micro"
  key_name               = "Demo-IIM"
  vpc_security_group_ids = [aws_security_group.private_security_group_1.id]

  // Connect to subnet
  subnet_id = aws_subnet.private.id
}

