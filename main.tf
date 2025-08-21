terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.9.0"
    }
  }
}

provider "aws" {
  
  region = var.region
}

resource "aws_instance" "my-instance" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
    user_data = <<-EOF
            #!/bin/bash
            yum install -y httpd
            systemctl enable httpd
            systemctl start httpd
            cat <<EOT > /var/www/html/index.html
              ${file("index.html")}
              EOT
              EOF
    tags = {
      Name = "mywebserver"
    }
  
}
resource "aws_security_group" "allow_ssh_http" {
    name = "allow_ssh_http"
    description = "allow SSH inboud traffic and outbound HTTP"


    #ingress is used for inbound trrafic 
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # allow SSH from anywhere (can restrict later)
  }

  ingress {
  description = "HTTP"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
  #egress is used for outbound trrafic. -1 protocol  means allow all protocols (tcp, udp,https)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}