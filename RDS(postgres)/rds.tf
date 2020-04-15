resource "aws_db_subnet_group" "postgress-subnet" {
  name        = "postgress-subnet"
  description = "RDS subnet group"
  subnet_ids  = [aws_subnet.app-vpc-private.id,aws_subnet.app-vpc-private-1.id]
}

resource "aws_db_parameter_group" "postgress-parameters" {
  name        = "postgress-parameters"
  family      = "postgres11"
  description = "postgress parameter group"

}

resource "aws_db_instance" "postgres" {
  allocated_storage       = 10 
  engine                  = "postgres"
  engine_version          = "11.5"
  instance_class          = "db.t2.micro" 
  identifier              = "postgres"
  name                    = "postgres"
  username                = "root"           # username
  password                = var.RDS_PASSWORD # password
  db_subnet_group_name    = aws_db_subnet_group.postgress-subnet.name
  parameter_group_name    = aws_db_parameter_group.postgress-parameters.name
  multi_az                = "false" 
  vpc_security_group_ids  = [aws_security_group.allow-postgress.id]
  storage_type            = "gp2"
  backup_retention_period = 30                                          # how long you’re going to keep your backups
  availability_zone       = aws_subnet.app-vpc-private.availability_zone # prefered AZ
  skip_final_snapshot     = true                                        # skip final snapshot when doing terraform destroy
  tags = {
    Name = "postgres-instance"
  }
}
