resource "aws_instance" "terra-bastion-ubuntu" {
  ami = "ami-0c6e5afdd23291f73"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.terra-pub-a.id
  associate_public_ip_address = true
  key_name = "test"
  vpc_security_group_ids = [
      aws_security_group.SG-Bastion.id
  ]
  tags = {
      Name = "terra-bastion-ubuntu"
  }
}
