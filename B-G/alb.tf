
resource "aws_lb" "alb" {
  name                       = "alb-test"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_ingress_sg.id]
  subnets                    = data.aws_subnet_ids.get_public_subnet_ids.ids
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 10
    protocol            = "HTTP"
    matcher             = "200"
  }

}



resource "aws_lb_target_group" "alb_tg_G" {
  name     = "alb-tg-G"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    interval            = 10
    protocol            = "HTTP"
    matcher             = "200"
  }

}