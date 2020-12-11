resource "aws_db_subnet_group" "rds-mysql-group" {
  name       = "main"
  subnet_ids = data.aws_subnet_ids.get_public_subnet_ids.ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds-mysql" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "mydb"
  username               = "root"
  password               = "******"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.rds-mysql-group.id
  vpc_security_group_ids = [aws_security_group.rds_ingress_sg.id]
}