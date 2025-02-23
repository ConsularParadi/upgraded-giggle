provider "aws" {
  region = "ap-south-1"
}

# VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "personal-website"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "prod_gw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "personal-website"
  }
}

# Route Table
resource "aws_route_table" "prod_rt" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }

  tags = {
    Name = "personal-website"
  }
}

# Subnet
resource "aws_subnet" "prod_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "ap-south-1a"

  tags = {
    Name = "personal-website"
  }
}

# Association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod_subnet.id
  route_table_id = aws_route_table.prod_rt.id
}

# Security Group for port 22, 80, 443
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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

  tags = {
    Name = "personal-website"
  }
}

resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.prod_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
  
  tags = {
    Name = "personal-website"
  }
}

resource "aws_eip" "web_server_eip" {
  vpc                       = true
  network_interface         = aws_network_interface.web_server_nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.prod_gw]
}

output "server_public_ip" {
  value = aws_eip.web_server_eip.public_ip
}


variable "ubuntu_ami" {
  # default = "ami-0ad21ae1d0696ad58"
  description = "value of ubuntu ami"
  type = string
}

variable "subnet" {
  type = list
}



resource "aws_instance" "web_server" {
  ami = var.ubuntu_ami
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name = "terraform"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web_server_nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo your very first web server > /var/www/html/index.html'
              EOF
  tags = {
    Name = "personal-website"
  }
}
