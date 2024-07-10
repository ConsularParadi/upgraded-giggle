provider "aws" {
  region = "ap-south-1"
}

# Create VPC
resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "personal-website"
  }
}

resource "aws_internet_gateway" "prod_gw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "personal-website"
  }
}

# Create route table
resource "aws_route_table" "prod-route-table" {
  
  vpc_id = aws_vpc.prod-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    egress_only_gateway_id = aws_internet_gateway.prod_gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    egress_only_gateway_id = aws_internet_gateway.prod_gw.id
  }

  tags = {
    Name = "personal-website"
  }
}

# Create subnet
resource "aws_subnet" "prod-subnet" {
  vpc_id = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "personal-website"
  }
}

# Associate subnet with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod-subnet.id
  route_table_id = aws_route_table.prod-route-table.id
}

# Create security group
resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.prod-vpc.id

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

# Create network interface
resource "aws_network_interface" "web-server-nic" {
  subnet_id       = aws_subnet.prod-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.allow_web.id]
}

# Assign elastic IP
resource "aws_eip" "one" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.web-server-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.prod_gw]
}

# Create Ubuntu server and install/enable apache2
resource "aws_instance" "firstInstance" {
  ami = "ami-0ad21ae1d0696ad58"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  key_name = "personal-website"

  network_interface {
    device_index = "0"
    network_interface_id = aws_network_interface.web-server-nic.id
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
