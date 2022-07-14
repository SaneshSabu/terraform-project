

variable "Project"{
  default = "zomato"
}

variable "Env"{
  default = "dev"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-bkt"
    key    = "tfstate"
    region = "us-east-1"
  }
}

resource "aws_security_group" "webserver" {
  name        = "allow_http,https"
  description = "Allow http,https inbound traffic"

  ingress {
    description      = ""
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
 }

  ingress {
    description      = ""
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
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

  tags = {
    Name = "${var.Project}-${var.Env}"
    Project = var.Project
    Env = var.Env
  }
}


