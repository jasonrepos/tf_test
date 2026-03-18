output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.nginx_alb.dns_name
}

# debug subnet IDs
# output "networking_subnet_ids" {
#     value = module.networking.subnet_ids
# }