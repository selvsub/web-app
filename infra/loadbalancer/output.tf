output "load_balancer_dns" {
  value = aws_lb.nlb.dns_name
}
