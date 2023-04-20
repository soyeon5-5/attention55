# 시작 구성
resource "aws_launch_configuration" "web-launchconfig" {
  image_id            = "ami-04cebc8d6c4f297a3"
  instance_type   = "t3.2xlarge"
  security_groups = [aws_security_group.SG-Web.id]
  key_name        = "web-key"
user_data = <<-EOF
 #!/bin/bash
 touch /tmp/test
 sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
 sudo apt-get update
 sudo apt-get install -y apache2
 sudo apt-get install -y php
 sudo apt-get install -y php-mysql
 sudo apt-get install -y mysql-client
EOF

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }


  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "web-asg" {
  launch_configuration = aws_launch_configuration.web-launchconfig.name
  vpc_zone_identifier  = [aws_subnet.terra-web-a.id, aws_subnet.terra-web-c.id]

  desired_capacity    = 2
  min_size            = 2
  max_size            = 2

  tag {
    key                 = "Name"
    value               = "terra-asg"
    propagate_at_launch = true
  }
}






 
