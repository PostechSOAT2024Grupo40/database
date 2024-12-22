resource "aws_rds_cluster" "cluster" {
  engine                              = "aurora-postgresql"
  cluster_identifier                  = "ambrosia-serve-cluster"
  allocated_storage                   = 1
  backtrack_window                    = 0
  backup_retention_period             = 10
  availability_zones                  = [
    data.terraform_remote_state.geral.outputs.subnet_private_a_az,
    data.terraform_remote_state.geral.outputs.subnet_private_b_az,
  ]
  copy_tags_to_snapshot               = true
  database_name                       = "ambrosia"
  db_cluster_parameter_group_name     = "default.aurora-postgresql16"
  deletion_protection                 = false
  enable_global_write_forwarding      = false
  enable_http_endpoint                = false
  enabled_cloudwatch_logs_exports     = ["postgresql", ]
  engine_version                      = "16.1"
  iam_database_authentication_enabled = false
  master_username                     = "postgres"
  network_type                        = "IPV4"
  port                                = 5432
  preferred_backup_window             = "03:23-03:53"
  preferred_maintenance_window        = "mon:04:00-mon:04:30"
  skip_final_snapshot                 = true
  storage_encrypted                   = true
  storage_type                        = "aurora-iopt1"

  vpc_security_group_ids = [
    aws_security_group.db.id,
  ]

  tags = {
    Name = "ambrosia-serve-cluster"
  }
}

resource "aws_rds_cluster_instance" "cluster_instance_writer" {
  depends_on                   = [aws_rds_cluster.cluster]
  identifier                   = "instance-1"
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  cluster_identifier           = aws_rds_cluster.cluster.id
  engine                       = aws_rds_cluster.cluster.engine
  engine_version               = aws_rds_cluster.cluster.engine_version
  availability_zone            = data.terraform_remote_state.geral.outputs.subnet_private_a_az
  copy_tags_to_snapshot        = true
  instance_class               = "db.r7g.large"
  db_parameter_group_name      = "default.aurora-postgresql16"
  preferred_backup_window      = "03:23-03:53"
  preferred_maintenance_window = "wed:06:17-wed:06:47"
  promotion_tier               = 0
  publicly_accessible          = false

  tags = {
    Name ="instance-1"
  }
}