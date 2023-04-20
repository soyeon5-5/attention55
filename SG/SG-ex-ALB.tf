# SG-ex-ALB
resource "aws_security_group" "SG-ex-ALB" {
  name        = "SG-ex-ALB"
  description = "Terraform SG-ex-ALB"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
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
    Name = "SG-ex-ALB"
  }
}
