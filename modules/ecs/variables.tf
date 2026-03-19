variable "environment" {
  description = "The environment name"
  type        = string
}

variable "service" {
  description = "The service name"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "cpu" {
  description = "CPU units for the task"
  type        = string
}

variable "memory" {
  description = "Memory (MiB) for the task"
  type        = string
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
}

variable "subnet_ids" {
  description = "Subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs for the ECS service"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}
