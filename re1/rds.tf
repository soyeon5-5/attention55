resource "aws_rds_cluster" "terra-rds" {

  vpc_security_group_ids = [aws_security_group.SG-RDS.id]
  db_subnet_group_name = aws_db_subnet_group.rds-grp2.name	

  cluster_identifier        = "aurora-rds"
  availability_zones        = ["ap-northeast-2a", "ap-northeast-2c"]
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.11.2"
  db_cluster_instance_class = "db.r6g.2xlarge"
  master_username           = "terra123"
  master_password           = "terra123"
}


resource "aws_db_subnet_group" "rds-grp2" {
  name       = "rds-grp22"
  subnet_ids = [aws_subnet.terra-db-a.id, aws_subnet.terra-db-c.id]

  tags = {
    Name = "rds-grp2"
  }
}
