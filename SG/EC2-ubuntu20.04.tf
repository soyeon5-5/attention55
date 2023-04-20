resource "aws_instance" "terra-bastion-ubuntu" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t3.2xlarge"

  subnet_id = aws_subnet.terra-pub-a.id
  associate_public_ip_address = true
  key_name = "terra-key"
  vpc_security_group_ids = [
      aws_security_group.SG-Bastion.id
  ]

  user_data              = "${file("data.sh")}"
  tags = {
      Name = "terra-bastion-ubuntu"
  }
}

resource "aws_instance" "terra-web-a" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t3.2xlarge"

  subnet_id = aws_subnet.terra-web-a.id
  key_name = "web01-key"
  vpc_security_group_ids = [
      aws_security_group.SG-Web.id
  ]
  tags = {
      Name = "terra-web-a"
  }
}
