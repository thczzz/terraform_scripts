provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "intro" {
  ami                    = "ami-022e1a32d3f742bd8"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  key_name               = "webserver"
  vpc_security_group_ids = ["sg-0653fca37a39a9e1d"]
  tags = {
    Name = "Dove-Instance"
  }
}
