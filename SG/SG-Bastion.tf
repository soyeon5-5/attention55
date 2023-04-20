# SG-Bastion
resource "aws_security_group" "SG-Bastion" {
  name        = "SG-Bastion"
  description = "Terraform SG-Bastion"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Bastion"
  }
}
