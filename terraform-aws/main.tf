provider "aws" {
 shared_credentials_file = "˜/.aws/credentials"
 region     = "us-east-1"
}

resource "aws_instance" "example01" {
 ami           = "ami-0080e4c5bc078760e"
 instance_type = "t2.micro"
}