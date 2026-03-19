resource "random_password" "rds_password" {
  length           = 32
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "${var.environment}-rds-credentials"
}

resource "aws_secretsmanager_secret_version" "rds_credentials" {
  secret_id = aws_secretsmanager_secret.rds_credentials.id
  secret_string = jsonencode({
    username = aws_db_instance.rds.username
    password = random_password.rds_password.result
    engine   = aws_db_instance.rds.engine
    host     = aws_db_instance.rds.address
    port     = aws_db_instance.rds.port
    dbname   = aws_db_instance.rds.db_name
  })
}
