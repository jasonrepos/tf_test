variable "environment" {
  description = "The environment name"
  type        = string
}

variable "service" {
  description = "The service name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-2"
  type        = string
}

variable "rds_username" {
  description = "Master username for the RDS instance"
  default     = "dbadmin"
  type        = string
}

variable "container_image" {
  description = "Docker image for the ECS container"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type        = string
}

variable "memory" {
  description = "Memory (MiB) for the ECS task"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks to run"
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    cidr              = string
    availability_zone = string
    public_ip         = bool
    tier              = string
    route_table       = string
  }))
}

variable "route_tables" {
  description = "Map of route table configurations"
  type = map(object({
    target = string
  }))
}

variable "security_groups" {
  description = "Map of security group configurations"
  type = map(object({
    name        = string
    description = string
    ingress = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      self        = bool
    }))
    egress = list(object({
      description = string
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      self        = bool
    }))
  }))
}
