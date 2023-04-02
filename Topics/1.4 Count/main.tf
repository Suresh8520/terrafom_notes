# Terraform Block

variable "bucket_names" {
  type = list(string)
  default = ["bucket1", "bucket2"]
}

resource "aws_s3_bucket" "s3_bucket" {
  count = length(var.bucket_names)
  bucket = var.bucket_names[count.index]
  acl    = "private"
  
  tags = {
    Name = "My Bucket ${count.index + 1}"
  }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

# Create 5 EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-079b5e5b3971bd10d" # Amazon Linux
  instance_type = "t2.micro"
  count         = 5
  tags = {
    #"Name" = "web"
    "Name" = "web-${count.index}"
  }
}
