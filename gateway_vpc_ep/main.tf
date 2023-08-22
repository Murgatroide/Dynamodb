terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.11.0"
        }
    }
}

#configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile = "PPG_Developer_ReadWrite-487517618172"
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id          = vpc-0089eb5a22c8118fc
  service_name    = "com.amazonaws.us-east-1.dynamodb"
  route_table_ids = ["rtb-0c83767e31702a82e"]

  tags = {
    Name = "my-dynamodb-endpoint"
  }
}