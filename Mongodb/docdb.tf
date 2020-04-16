resource "aws_docdb_subnet_group" "doc-db-subnetg" {
  name       = "doc-db-subnetg"
  subnet_ids = ["${aws_subnet.app-vpc-private.id}", "${aws_subnet.app-vpc-private-1.id}"]

  tags = {
    Name = " docdb-ubnet-group"
  }
}


resource "aws_docdb_cluster_parameter_group" "doc-db-parametername" {
  family      = "docdb3.6"
  name        = "doc-db-parametername"
  description = "docdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "enabled"
  }
}

resource "aws_docdb_cluster" "app-mongo-docdb" {
  cluster_identifier      = "app-mongo-docdb-cluster"
  engine                  = "docdb"
  master_username         = "root"
  master_password         = "root12345"
  port                    = 27017
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.doc-db-subnetg.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.parameter-group.name
  vpc_security_group_ids = ["${aws_security_group.allow-mongodb.id}"]
}

resource "aws_docdb_cluster_instance" "app-mongo-cluster_instances" {
  count              = 2
  identifier         = "app-mongo-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.app-mongo-docdb.id
  instance_class     = "db.r5.large"
 
}




resource "aws_docdb_cluster_parameter_group" "parameter-group" {
  family      = "docdb3.6"
  name        = "example"
  description = "docdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}