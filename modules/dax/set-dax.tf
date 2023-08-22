variable "dax-control" {
  type = string
}

resource "aws_dax_parameter_group" "pg-test-iva" {
  name = "daxpg-test-iva"
  parameters {
    name = "query-ttl-millis"
    value = "10000"
  }
  parameters {
    name = "record-ttl-millis"
    value = "10000"
  }
}

resource "aws_dax_cluster" "cl-test-iva" {
  cluster_name = "dax-cl-test-iva"
  iam_role_arn = "arn:aws:iam::487517618172:role/ppg-role-dax-dba"
  node_type = "dax.t2.small"
  replication_factor = 3
  subnet_group_name = "daxsng-test-iva"
  cluster_endpoint_encryption_type = "TLS"
  security_group_ids = ["sg-0e218bf4f343724b0"]
#Configure DynamoDB Accelerator (DAX) clusters to encrypt data at rest AND in transit
  server_side_encryption {
    enabled = true
  }

}

output "module_output_3" {
  value = aws_dax_parameter_group.pg-test-iva.id
}

output "module_output_4" {
  value = aws_dax_cluster.cl-test-iva.id
}