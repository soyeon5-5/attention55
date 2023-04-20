resource "aws_security_group" "SG-Bastion" {
  name        = "SG-Bastion"
  description = "Terraform SG-Bastion"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
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



# SG-Web
resource "aws_security_group" "SG-Web" {
  name        = "SG-Web"
  description = "Terraform SG-Web"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.1.2.0/24"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Web"
  }
}


# SG-ex-ALB
resource "aws_security_group" "SG-ex-ALB" {
  name        = "SG-ex-ALB"
  description = "Terraform SG-ex-ALB"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
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




# SG-RDS
resource "aws_security_group" "SG-RDS" {
  name        = "SG-RDS"
  description = "Terraform SG-RDS"
  vpc_id      = aws_vpc.terra-vpc.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.1.0.0/16"]
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



