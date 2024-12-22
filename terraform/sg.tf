resource "aws_security_group" "db" {
  name = "db_sg"
  description = "Security group for RDS into VPC"
    vpc_id = data.terraform_remote_state.geral.outputs.vpc_id

  tags = {
    Name = "db_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "postgresql" {
  security_group_id = aws_security_group.db.id
  from_port         = 5432
  to_port           = 5432
  ip_protocol       = "tcp"
  cidr_ipv4 = data.aws_vpc.vpc.cidr_block
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id =aws_security_group.db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
