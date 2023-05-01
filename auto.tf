# 시작 구성
resource "aws_launch_configuration" "web-launchconfig" {
  image_id            = "ami-04cebc8d6c4f297a3"
  instance_type   = "t3.medium"
  security_groups = [aws_security_group.SG-Web.id]
  key_name        = "Attention55"
user_data = <<-EOF
 #!/bin/bash
sudo apt-get update
sudo apt-get install apache2 php php-mysql -y
sudo apt-get install mysql-client -y
sudo apt-get update
git clone https://github.com/aws/efs-utils
sudo apt-get -y install binutils
efs-utils/build-deb.sh
sudo apt-get -y install efs-utils/build/amazon-efs-utils*deb
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
  max_size            = 4

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}

 
