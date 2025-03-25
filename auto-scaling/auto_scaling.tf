resource "aws_autoscaling_group" "WebAppAutoScaling" {
  vpc_zone_identifier = [var.public_subnet01, var.public_subnet02]
  desired_capacity    = 3
  max_size            = 5
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.WebAppTG.arn]
  name                = "WebAppAutoScaling"

  launch_template {
    id      = aws_launch_template.AutoScalingLaunchTemplate.id
    version = "$Latest"
  }

}