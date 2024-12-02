# Define the VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Define the subnet
resource "aws_subnet" "subnet" {
  vpc_id                  = aws_vpc.main.id  
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"  
  tags = {
    Name = "main-subnet"
  }
}

# Define the security group
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main.id  

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

# Define the EC2 instance
resource "aws_instance" "vm" {
  ami               = "ami-0c02fb55956c7d316"
  instance_type     = "t2.micro"
  subnet_id         = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "main-vm"
  }
}
