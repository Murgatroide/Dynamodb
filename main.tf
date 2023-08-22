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

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores_Test_iva"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"
  deletion_protection_enabled = "true"        #Enable deletion protection for DynamoDB tables, In case you need to destroy the table with this same script you must first deactivate the current deletion protection for this table.

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }
#Ensure DynamoDB Tables are encrypted using AWS managed keys (KMS)
  server_side_encryption {
    enabled = true
  }
#Configure DynamoDB tables to have point-in-time recovery (PITR) enabled 
  point_in_time_recovery {
    enabled = true
  }

  lifecycle {
    ignore_changes = [ write_capacity, read_capacity ]
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }
  
  tags = {
    Name        = "dynamodb-table-dev_test_ivega"
    Environment = "DEV"
  }

}

output "aws_dynamodb_table" {
  value = aws_dynamodb_table.basic-dynamodb-table.id
  
}
#in case you need to use DAX you should have in advance an aws_ dax_subnet_group
resource "aws_dax_subnet_group" "sng-test-iva" {
  name = "daxsng-test-iva"
  subnet_ids = [ 
    "subnet-0bc4eeab5975373ef",
    "subnet-0cf1b2a274a3a0f85" ]
}

output "aws_dax_subnet_group" {
  value = aws_dax_subnet_group.sng-test-iva.id
}