# RDS Subnet Group across DB Subnets
resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.db_subnets

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}

# Multi-AZ RDS MySQL Database Instance
resource "aws_db_instance" "main" {
  identifier             = "${var.environment}-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  max_allocated_storage  = 50
  storage_type           = "gp2"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_security_group_id]
  multi_az               = true
  skip_final_snapshot    = true

  tags = {
    Name = "${var.environment}-rds-mysql"
  }
}
