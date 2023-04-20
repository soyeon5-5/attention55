terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "attention-s3" #S3 버킷명
    key    = "terraform.tfstate" #terraform.tfstate 파일위치 ex) aws-an2/jenkins_terraform_test/terraform.tfstate
    region = "ap-northeast-2" # 리전
    dynamodb_table = "dyDB-jenkins" #테라폼 백엔드 구성용 DynamoDB 테이블명
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-2"
}
