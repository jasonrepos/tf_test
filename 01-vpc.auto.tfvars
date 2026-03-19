vpc_cidr = "10.0.0.0/16"

subnets = {
  public-1 = {
    cidr              = "10.0.0.0/24"
    availability_zone = "eu-west-2a"
    public_ip         = true
    tier              = "public"
    route_table       = "public"
  }
  public-2 = {
    cidr              = "10.0.1.0/24"
    availability_zone = "eu-west-2b"
    public_ip         = true
    tier              = "public"
    route_table       = "public"
  }
  web-1 = {
    cidr              = "10.0.2.0/24"
    availability_zone = "eu-west-2a"
    public_ip         = false
    tier              = "web"
    route_table       = "private"
  }
  web-2 = {
    cidr              = "10.0.3.0/24"
    availability_zone = "eu-west-2b"
    public_ip         = false
    tier              = "web"
    route_table       = "private"
  }
  database-1 = {
    cidr              = "10.0.5.0/24"
    availability_zone = "eu-west-2a"
    public_ip         = false
    tier              = "database"
    route_table       = "private"
  }
  database-2 = {
    cidr              = "10.0.6.0/24"
    availability_zone = "eu-west-2b"
    public_ip         = false
    tier              = "database"
    route_table       = "private"
  }
}

route_tables = {
  public  = {
    target = "igw"
    }
  private = {
    target = "nat"
    }
}

security_groups = {
  ecs = {
    name        = "sgrp-web-server"
    description = "Allow HTTP inbound traffic"
    ingress = [
      {
        description = "Allow HTTP from ALB"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = []
        self        = true
      }
    ]
    egress = [
      {
        description = "outbound traffic"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        self        = false
      }
    ]
  }
  database = {
    name        = "sgrp-database"
    description = "Allow inbound traffic from application security group"
    ingress = [
      {
        description = "Allow traffic from application layer"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        self        = false
      }
    ]
    egress = [
      {
        description = "outbound"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        self        = false
      }
    ]
  }
}
