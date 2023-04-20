# SG-RDS
resource "aws_security_group" "SG-RDS" {
  name        = "SG-RDS"
  description = "Terraform SG-RDS"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 3306
    to_port          = 3306
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
    Name = "SG-RDS"
  }
}
