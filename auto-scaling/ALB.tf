resource "aws_lb" "WebAppALB" {
  name               = "WebAppALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.HTTP_SG_ID]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


resource "aws_lb_listener" "WebAppALB_listener" {
  load_balancer_arn = aws_lb.WebAppALB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebAppTG.arn
  }
}

