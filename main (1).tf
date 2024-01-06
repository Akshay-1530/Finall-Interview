provider "aws" {
  region = var.aws_region
}

#EC2

resource "aws_instance" "jenkins-module" {

    ami="ami-05fb0b8c1424f266b"
    instance_type = "t2.micro"
    key_name = "Ohio"
    vpc_security_group_ids = [aws_security_group.jenkins-sg-module2.id]
    user_data = file(jenkins-terra.sh)

    tags={
       name="myinstance"
}
}



#security group
resource "aws_security_group" "jenkins-sg-module2" {

    name = "jenkins-sg-module2"

ingress  {
    from_port=22
    to_port=22
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

ingress  {
    from_port=443
    to_port=443
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

ingress  {
    from_port=80
    to_port=80
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }

ingress  {
    from_port=8080
    to_port=8080
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }
egress  {
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks = ["0.0.0.0/0"]

    }
  
}