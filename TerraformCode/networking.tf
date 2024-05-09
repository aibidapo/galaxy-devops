# Create VPC
resource "aws_vpc" "galaxy-vpc" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "galaxy-vpc"
  }
}

# Create subnet
resource "aws_subnet" "galaxy-public-subnet-01" {
  vpc_id                  = aws_vpc.galaxy-vpc.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "galaxy-public-subnet-01"
  }
}

resource "aws_subnet" "galaxy-public-subnet-02" {
  vpc_id                  = aws_vpc.galaxy-vpc.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"
  tags = {
    Name = "galaxy-public-subnet-02"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "galaxy-igw" {
  vpc_id = aws_vpc.galaxy-vpc.id

  tags = {
    Name = "galaxy-igw"
  }

}

# Create route table
resource "aws_route_table" "galaxy-public-rt" {
  vpc_id = aws_vpc.galaxy-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.galaxy-igw.id
  }

  tags = {
    Name = "galaxy-public-rt"
  }
}

# Associate subnet with route table
resource "aws_route_table_association" "galaxy-rta-public-subnet-01" {

  subnet_id      = aws_subnet.galaxy-public-subnet-01.id
  route_table_id = aws_route_table.galaxy-public-rt.id
}

resource "aws_route_table_association" "galaxy-rta-public-subnet-02" {

  subnet_id      = aws_subnet.galaxy-public-subnet-02.id
  route_table_id = aws_route_table.galaxy-public-rt.id
}



resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.galaxy-vpc.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = iport
    content {
      from_port   = iport.value
      to_port     = iport.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-sg"
  }
}



