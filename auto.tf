# 시작 구성
resource "aws_launch_template" "web-launch-template" {
  name = "terra-web-launchtemplate"
  description = "terra-web-launchtemplate"
  image_id = "ami-04cebc8d6c4f297a3"
  vpc_security_group_ids = [aws_security_group.SG-Web.id]
  instance_type   = "t3.medium"
  key_name        = "attention55"
  target_group_arns = [aws_alb_target_group.alb-target-group.arn]

user_data = base64encode(<<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 php php-mysql -y
sudo apt-get install mysql-client -y
sudo mount -t efs -o tls fs-05cca786546229385:/ /var/www/html
EOF
)
  # Required when using a launch configuration with an auto scaling group.
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "web-asg2" {
  vpc_zone_identifier  = [aws_subnet.terra-web-a.id, aws_subnet.terra-web-c.id]
  desired_capacity    = 2
  min_size            = 2
  max_size            = 2

 launch_template {
         id = aws_launch_template.web-launch-template.id
         version = "$Latest"
    }

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = true
  }
}






 
