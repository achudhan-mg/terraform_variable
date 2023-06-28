resource "aws_instance" "Demo" {
  ami = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1a"
  associate_public_ip_address = true
  key_name = "Every"
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]

  user_data = <<-EOF
  #!bin/bash
  sudo apt update -y
  sudo apt install -y nginx 
  EOF

  tags = {
    Name = "Terraform-Variables"
  }
}

#Create Security Group and attached to EC2 instance
resource "aws_security_group" "ec2-sg" {
  description = "Allow Ports"
  vpc_id = "vpc-05ed220fe17756a7d"

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "CUSTOM"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "variable-sg"
  }
}