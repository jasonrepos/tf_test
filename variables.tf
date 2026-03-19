variable "environment" {
  description = "The environment name"
}

variable "service" {
  description = "The service name"
}

variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "rds_username" {
  description = "Master username for the RDS instance"
  default     = "dbadmin"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
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
