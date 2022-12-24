terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Don't forget to replace for the correct credentials
provider "aws" {
  region     = "us-east-1"
  access_key = "ASIAVA4BL2KHLZF556OQ"
  secret_key = "KrSSsFIGgPfkylxgHFctSf5Hj2MnvVF2I+8C912/"
  token      = "FwoGZXIvYXdzEJ7//////////wEaDEVzM/OFYUcc9DCtEyK+AW491a+6wAdEcH4y5tI8dHK7DSyQybYlTYxL5Pf6NGVmKUyBFlcGb400GKdNbLtzdyTFtAoh+EnP5F4VjCRGNlCfeC6CL/cEmIaYhI9ptlEH/MgRPXyDO2imSg29ZbQHnNWy1muZRkWHi3Ky1RN3+2g3hZpYtG+gMh4vrP1rG6AHNNkcXcwxdwTjROCGlOTsC3M16lEZA4PRXHMthOwpEISutCurVrfncvdGRQDxJ0jLOeK5rpaNRS8oUIb9SwAokqeYnQYyLTFkOIGeFuWHJqaV58snzJsw4xUrf4aShLc+rBM0WIz6XSeM05f7TtRaXerPPA=="
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

# Notice that proxy is the only one with t2.large instance type, since it's specified in the instructions
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