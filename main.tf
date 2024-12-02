provider "aws" {
  region = "us-east-1"
}

# Define the VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "main-vpc"
  }
}

# Define the subnet in an acceptable availability zone (e.g., us-east-1a)
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id  # Ensure the subnet is in the same VPC
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # Use an acceptable availability zone

  tags = {
    Name = "main-subnet"
  }
}

# Define the security group in the same VPC as the subnet
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id  # Ensure the security group is in the same VPC as the subnet

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

  tags = {
    Name = "main-sg"
  }
}

# Define the EC2 instance in the same subnet and security group
resource "aws_instance" "vm" {
  ami               = "ami-08eb150f611ca277f" 
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "main-vm"
  }
}
