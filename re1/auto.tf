# 인스턴스 생성
resource "aws_instance" "terra-web-ins" {
  ami                    = "ami-0c6e5afdd23291f73"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.SG-Web.id]

  user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install apache2
                echo "Hello, World" > index.html
		EOF

  tags = {
    Name = "terra-web-ins"
  }
}




# Luanch Configuration 설정
resource "aws_launch_configuration" "terra-launch-config" {
  image_id        = "ami-0c6e5afdd23291f73"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.SG-Web.id]

  user_data = <<-EOF
		#!/bin/bash
                sudo apt update
                sudo apt install apache2
		echo "Hello, World" > index.html
		EOF
}

# AWS AutoScaling Group 생성
resource "aws_autoscaling_group" "terra-asg" {
  launch_configuration = aws_launch_configuration.terra-launch-config.name
  vpc_zone_identifier = [aws_subnet.terra-web-a.id, aws_subnet.terra-web-c.id]

  min_size = 2
  max_size = 2

  tag {
    key                 = "Name"
    value               = "terra-asg"
    propagate_at_launch = true
  }

  ## ASG에서 시작 구성을 사용할때 필요한 옵션: 최신 리소스를 선 생성 후 기존 리소스를 삭제
  lifecycle {
    create_before_destroy = true
  }
}
