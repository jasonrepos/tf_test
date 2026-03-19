provider "aws" {
  region = var.aws_region
}


resource "aws_db_instance" "rds" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.id
  engine                 = "postgres"
  engine_version         = "13.23"
  instance_class         = "db.t3.micro"
  multi_az               = true
  db_name                = "mydb"
  username               = var.rds_username
  password               = random_password.rds_password.result
  skip_final_snapshot    = true
  vpc_security_group_ids = [module.vpc.security_group_ids["database"]]
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "main"
  subnet_ids = [module.vpc.subnet_ids["public-1"], module.vpc.subnet_ids["public-2"]]
}
