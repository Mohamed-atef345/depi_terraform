output "ALB_DNS" {
  value = aws_lb.WebAppALB.dns_name
}