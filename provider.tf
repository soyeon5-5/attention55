terraform {
  backend "s3" {
    bucket = "cute-sy-s3" #S3 버킷명
    key    = "1" #terraform.tfstate 파일위치 ex) aws-an2/jenkins_terraform_test/terraform.tfstate
    region = "ap-south-1" # 리전
    dynamodb_table = "cute-sy-db" #테라폼 백엔드 구성용 DynamoDB 테이블명
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}
