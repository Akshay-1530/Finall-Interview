
# Resource 
provider "aws" {
  region = "us-east-1"

}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Core-vpc"
  }
}

# Internet Gatway block

resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public"
  }
}

# Route-Table Block
resource "aws_route_table" "myrt1" {
  vpc_id = aws_vpc.main.id

  route = []

  tags = {
    Name = "route-table"
  }
}


#Route Block

resource "aws_route" "route1" {
  route_table_id         = aws_route_table.myrt1.id
  destination_cidr_block = "0.0.0.0/0"
   gateway_id             = aws_internet_gateway.gw1.id
  depends_on             = [aws_route_table.myrt1]

}


# Route-table-association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.myrt1.id
}


# Security group

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    #for incoming 
    description = "incoming from anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Block

resource "aws_instance" "myserver1" {
  ami           = "ami-079db87dc4c10ac91"
  instance_type = "t2.micro"

  tags = {
    name = "myec2-instance"
  }

}
