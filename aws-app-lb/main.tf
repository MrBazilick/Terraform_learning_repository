#default subnets for lb
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

#Application Load Balancer 
resource "aws_lb" "app_elb_test" {
  name               = "app-elb-test01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = data.aws_subnets.default.ids

#To avoid accidentally deleting this LB. Need to be removed before deletion. Now not need as test purpose
#  enable_deletion_protection = true
}

#to configure health check for lb
resource "aws_lb_target_group" "http-check" {
  name     = "http-healthcheck"
  port     = 80
  #target_type = "alb"
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 20
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "test_tar_gro_att" {
  target_group_arn = aws_lb_target_group.http-check.arn
  target_id        = var.target_id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app_elb_test.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.http-check.arn
  }
}