#### VPC ####

resource "aws_vpc" "프로젝트-vpc" {
  cidr_block  = "10.0.0.0/16" # 업뎃 필요
  enable_dns_hostnames = true

  tags = {
    Name = "프로젝트-vpc"
  }
}