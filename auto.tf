# 시작 구성
resource "aws_launch_template" "web-launch-template" {
  name = "terra-web-launchtemplate"
  description = "terra-web-launchtemplate"
  image_id = "ami-0f5610ba8751123f3"
  vpc_security_group_ids = [aws_security_group.SG-Web.id]
  instance_type   = "t3.2xlarge"
  key_name        = "genkins-key"

user_data = base64encode(<<EOF2
#!/bin/bash
sudo mount -t efs -o tls fs-09e4715f324aef5d6:/ /var/www/html
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






 
