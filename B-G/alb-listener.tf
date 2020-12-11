locals {
  json_data = jsondecode(file("./B-G/B-G-listener-percent.json"))
}


resource "aws_lb_listener" "alb_listener_forward_80" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.alb_tg.arn
        weight = local.json_data.Blue
      }

      target_group {
        arn    = aws_lb_target_group.alb_tg_G.arn
        weight = local.json_data.Green
      }

      stickiness {
        enabled  = true
        duration = 600
      }
    }
  }
}