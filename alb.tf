resource "aws_lb" "terra-elb" {
  internal           = false
  name               = "terra-elb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG-ex-ALB.id]
  subnets            = [aws_subnet.terra-pub-a.id, aws_subnet.terra-pub-c.id]



  tags = {
    Name = "terra-elb"
  }
}


# ALB aws_lb_listener 생성
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.terra-elb.arn
  port              = 80
  protocol          = "HTTP"
  
## 기본값으로 단순한 404 페이지 오류를 반환
  default_action {
	type = "fixed-response"

	fixed_response {
	  content_type = "text/plain"
	  message_body = "404: page not found"
	  status_code = 404
	}
  }
}



# ALB 타겟그룹 생성
resource "aws_lb_target_group" "alb-target-group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# ALB with ASG 서비스 연결
resource "aws_lb_listener_rule" "alb-listner-rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
}










