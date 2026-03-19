output "cluster_id" {
  description = "The ECS cluster ID"
  value       = aws_ecs_cluster.this.id
}

output "service_name" {
  description = "The ECS service name"
  value       = aws_ecs_service.this.name
}
