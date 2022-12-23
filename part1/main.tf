terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region     = "us-east-1"
  access_key = "ASIAVA4BL2KHEKMI25ON"
  secret_key = "YCgJrpPVxJ+qiDt+jJHpjHdLx7h6evMPV9qwGar5"
  token      = "FwoGZXIvYXdzEJf//////////wEaDLxj4ttdiKYC1RvnAyK+AYUs9wgC+rrQ+0vNGgndmNUKOrdoMCrEHruBeUm5sORl8bhM2n+1FFF2LRp0Y6fjmuxsg9K9R80KAxE5NBo5W8Cl0FCrNnmXyBW1eNytwcMtYnTMc/xcbIvMPZN0Vu2xSwKSgQ9xHF4ms2BcCum4A4W9UuCGosFJgqUhe14csD9pBzgNxY3t1cdTNYcxtLAA8TsXRPgmEzTu3YflKr7OnMX9lC6zBG5k+WcOPwhoHnUxC943r3+Mrn4i/t21bYkosN+WnQYyLfYY7pMxJ2DE5WEXIGCP4s/niqxH8NJb/SbFbmmJ9wG48RGB0sDjcKE8xqCYIQ=="
}


resource "aws_security_group" "security_gp" {
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "stand-alone" {
  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_gp.id]
  availability_zone      = "us-east-1d"
  user_data              = file("userdata.sh")
  key_name               = "vockey"
  tags = {
    Name = "Stand-alone"
  }
}

resource "aws_instance" "master" {
  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_gp.id]
  availability_zone      = "us-east-1d"
  key_name               = "vockey"
  tags = {
    Name = "Master"
  }
}

resource "aws_instance" "slave-1" {
  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_gp.id]
  availability_zone      = "us-east-1d"
  key_name               = "vockey"
  tags = {
    Name = "Slave 1"
  }
}

resource "aws_instance" "slave-2" {
  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_gp.id]
  availability_zone      = "us-east-1d"
  key_name               = "vockey"
  tags = {
    Name = "Slave 2"
  }
}

resource "aws_instance" "slave-3" {
  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_gp.id]
  availability_zone      = "us-east-1d"
  key_name               = "vockey"
  tags = {
    Name = "Slave 3"
  }
}

resource "aws_instance" "proxy" {
  ami                    = "ami-0149b2da6ceec4bb0"
  instance_type          = "t2.large"
  vpc_security_group_ids = [aws_security_group.security_gp.id]
  availability_zone      = "us-east-1d"
  key_name               = "vockey"
  user_data              = file("userdata.sh")
  tags = {
    Name = "Proxy"
  }
}