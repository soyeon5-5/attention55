# 시작 구성
resource "aws_launch_template" "web-launch-template" {
  name = "terra-web-launchtemplate"
  description = "terra-web-launchtemplate"
  image_id = "ami-04cebc8d6c4f297a3"
  vpc_security_group_ids = [aws_security_group.SG-Web.id]
  instance_type   = "t3.medium"
  key_name        = "Attention55"

user_data = base64encode(<<EOF
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
)
  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "web-asg" {
  name                = "myweb"
  vpc_zone_identifier  = [aws_subnet.terra-web-a.id, aws_subnet.terra-web-c.id]
  desired_capacity    = 2
  min_size            = 2
  max_size            = 4

  target_group_arns = [aws_lb_target_group.alb-target-group.arn]

 launch_template {
         id = aws_launch_template.web-launch-template.id
         version = "$Latest"
    }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}



 
