# Defines a variable that stores the AWS region where resources will be created
variable "aws_region" {

  # Default value used when no other value is provided
  default = "us-east-1"
}


variable "instance_type"{
    default = "t2.micro"
}