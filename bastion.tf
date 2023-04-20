resource "aws_instance" "terra-bastion-ubuntu" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t3.2xlarge"

  subnet_id = aws_subnet.terra-pub-c.id
  associate_public_ip_address = true
  key_name = "bastion-key"
  vpc_security_group_ids = [aws_security_group.SG-Bastion.id]
  user_data = <<-EOF
                #!/bin/bash
                touch /tmp/test
                sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
                sudo apt-get update -y
                EOF

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
      Name = "terra-bastion-ubuntu"
  }
}


resource "aws_instance" "terra-genkins" {
  ami = "ami-04cebc8d6c4f297a3"
  instance_type = "t3.2xlarge"

  subnet_id = aws_subnet.terra-pub-a.id
  key_name = "genkins-key"
  vpc_security_group_ids = [aws_security_group.SG-Bastion.id]
  user_data = <<-EOF
                #!/bin/bash
                sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
                sudo apt-get update -y
                EOF

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
      Name = "terra-genkins"
  }
}
