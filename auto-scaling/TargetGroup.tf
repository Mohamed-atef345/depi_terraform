resource "aws_lb_target_group" "WebAppTG" {
  name     = "WebAppTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}



