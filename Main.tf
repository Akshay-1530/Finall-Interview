provider "aws" {

  region = "us-east-2"
}

#ec2

resource "aws_instance" "ec2-s3-module" {

  ami                    = "ami-05fb0b8c1424f266b"
  instance_type          = "t2.micro"
  key_name               = "Ohio"
  vpc_security_group_ids = [aws_security_group.aws-sg-s3-2024.id]

  tags = {
    name = "my_instance"
  }

}

#s3 creation

resource "aws_s3_bucket" "s3-module-practice-2024" {
  
  bucket = "s3-module-practice-2024"
  
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  
}

#security group
resource "aws_security_group" "aws-sg-s3-2024" {

  name = "aws-sg-s3-2024"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

