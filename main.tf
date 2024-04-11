
provider "aws" {
  region = "us-east-1"
 
}

# Create a VPC
resource "aws_vpc" "vividarts_vpc" {
  cidr_block = "10.0.0.0/18" 

  tags = {
    Name = "vividarts_vpc"
  }
}

# Create a network ACL

resource "aws_network_acl" "vividarts_acl" {
  vpc_id = aws_vpc.vividarts_vpc.id 

}


# Create a public subnet within the vpc
resource "aws_subnet" "public1_varts" {
  vpc_id                  = aws_vpc.vividarts_vpc.id 
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "us-east-1a" 

  tags = {
    Name = "public Subnet"
  }
}

resource "aws_subnet" "public2_varts" {
  vpc_id                  = aws_vpc.vividarts_vpc.id 
  cidr_block              = "10.0.2.0/24" 
  availability_zone       = "us-east-1b" 

  tags = {
    Name = "public Subnet2"
  }
}


# Create a security group
resource "aws_security_group" "varts_sg" {
  vpc_id = aws_vpc.vividarts_vpc.id

  tags = {
    Name = "varts_sg"
  }

}

#Create an s3 bucket
resource "aws_s3_bucket" "vividarts" {
  bucket = "my-vivid-bucket"

  tags = {
    Name        = "My bucket"
    versioning  = "enabled"
  }
}