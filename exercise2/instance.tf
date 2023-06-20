resource "aws_instance" "dove-instance" {
  ami = var.AMIS[var.REGION]
  instance_type = "t2.micro"
  availability_zone = var.ZONE1
  key_name = "webserver"
  vpc_security_group_ids = ["sg-0653fca37a39a9e1d"]
  tags = {
    Name = "Dove-Instance"
  }
}
