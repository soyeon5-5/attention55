resource "aws_rds_cluster" "example" {
  cluster_identifier        = "example"
  availability_zones        = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  engine                    = "mysql"
  db_cluster_instance_class = "db.r6gd.xlarge"
  storage_type              = "io1"
  allocated_storage         = 100
  iops                      = 1000
  master_username           = "test"
  master_password           = "mustbeeightcharaters"
  vpc_security_group_ids  
  db_subnet_group_name  
}
