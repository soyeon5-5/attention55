# SG-redis
resource "aws_security_group" "SG-redis" {
  name        = "SG-redis"
  description = "Terraform SG-redis"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 6379
    to_port          = 6379
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
    Name = "SG-redis"
  }
}
