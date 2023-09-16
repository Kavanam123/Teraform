terraform {
  required_providers {
    aws={
        source="hashicorp/aws"
        version="4.16"
        
    }
  }
}
provider "aws" {
  region = "us-west-2"
  
access_key="AKIAU3BURJMQ6D2OSLQF"
secret_key="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"
}
resource "aws_vpc" "vpc1" {
  cidr_block = "172.19.0.0/16"
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "172.19.1.0/24"
  availability_zone = "us-west-2a"
}
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "172.19.2.0/24"
  availability_zone = "us-west-2b"
}
resource "aws_instance" "example_instance" {
  ami                    = "ami-0ccea833bf267252a" 
  instance_type          = "t2.micro"
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  tags = {
    purpose = "Assignment"
  }
}
resource "aws_security_group" "securityg" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]

}
}
