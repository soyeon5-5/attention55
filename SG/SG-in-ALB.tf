# SG-in-ALB
resource "aws_security_group" "SG-in-ALB" {
  name        = "SG-in-ALB"
  description = "Terraform SG-in-ALB"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/16"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-in-ALB"
  }
}
