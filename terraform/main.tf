terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}
resource "aws_vpc" "main" {
  # Defines the IP address range available inside the VPC
  cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id # Subnet دي تتعمل داخل الـ VPC اللي اسمها main
  cidr_block = "10.0.1.0/24"
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "internet" {

  # Uses the route table created above
  route_table_id = aws_route_table.main.id

  # 0.0.0.0/0 means any IPv4 destination
  destination_cidr_block = "0.0.0.0/0"

  # Sends that traffic to our Internet Gateway
  gateway_id = aws_internet_gateway.main.id
}

# Connects the subnet to the route table
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id      # The subnet that will use this route table
  route_table_id = aws_route_table.main.id # The route table that the subnet will use
}

# Creates a security group that will control traffic to and from the EC2 instance
resource "aws_security_group" "app" {

  # Name shown for this security group in AWS
  name = "app-security-group"

  # Associates the security group with our VPC
  vpc_id = aws_vpc.main.id

  # Description explaining the purpose of this security group
  description = "Security group for the application EC2 instance"
}

# Allows inbound HTTP traffic to the application
resource "aws_vpc_security_group_ingress_rule" "http" {

  # The security group that this rule belongs to
  security_group_id = aws_security_group.app.id

  # Allows TCP traffic
  ip_protocol = "tcp"

  # HTTP uses port 80
  from_port = 80
  to_port   = 80

  # Allows HTTP traffic from any IPv4 address
  cidr_ipv4 = "0.0.0.0/0"
}

# Creates an EC2 instance that will act as our application server
resource "aws_instance" "app" {

  # Specifies the Amazon Machine Image (AMI) used to create the server
  # This AMI ID is for an Ubuntu server in the us-east-1 region
  ami = "ami-0c94855ba95c71c99"

  instance_type = var.instance_type

  # Places the EC2 instance inside the subnet we created earlier
  subnet_id = aws_subnet.main.id

  # Attaches our application security group to the EC2 instance
  vpc_security_group_ids = [aws_security_group.app.id]

  # Assigns a public IPv4 address to the EC2 instance at launch
  # This allows the instance to communicate with the Internet through the Internet Gateway
  associate_public_ip_address = true
}