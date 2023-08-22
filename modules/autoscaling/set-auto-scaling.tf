#Configure DynamoDB tables to scale capacity automatically with demand
variable "autoscaling-control" {
  type = string
}

resource "aws_appautoscaling_target" "dynamodb_table_read_target" {
  max_capacity       = 100
  min_capacity       = 20
  resource_id        = "table/GameScores_Test_iva"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_read_policy" {
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.dynamodb_table_read_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dynamodb_table_read_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dynamodb_table_read_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = 70
  }
}

resource "aws_appautoscaling_target" "dynamodb_table_write_target" {
    max_capacity       = 200
    min_capacity       = 5
    resource_id        = "table/GameScores_Test_iva"
    scalable_dimension = "dynamodb:table:WriteCapacityUnits"
    service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "dynamodb_table_write_policy" {
    name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.dynamodb_table_write_target.resource_id}"
    policy_type        = "TargetTrackingScaling"
    resource_id        = aws_appautoscaling_target.dynamodb_table_write_target.resource_id
    scalable_dimension = aws_appautoscaling_target.dynamodb_table_write_target.scalable_dimension
    service_namespace  = aws_appautoscaling_target.dynamodb_table_write_target.service_namespace

    target_tracking_scaling_policy_configuration {
        predefined_metric_specification {
            predefined_metric_type = "DynamoDBWriteCapacityUtilization"
        }
        target_value = 70
    }
}

resource "aws_appautoscaling_target" "dynamodb_index_read_target" {
  max_capacity       = 100
  min_capacity       = 5
  resource_id        = "table/GameScores_Test_iva/index/GameTitleIndex"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_target" "dynamodb_index_write_target" {
  max_capacity       = 100
  min_capacity       = 5
  resource_id        = "table/GameScores_Test_iva/index/GameTitleIndex"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

output "module_output_1" {
  value = aws_appautoscaling_policy.dynamodb_table_read_policy.id
}

output "module_output_2" {
  value = aws_appautoscaling_policy.dynamodb_table_write_policy.id
}

output "module_output_5" {
  value =  aws_appautoscaling_target.dynamodb_index_read_target.scalable_dimension
}

output "module_output_6" {
  value = aws_appautoscaling_target.dynamodb_index_write_target.scalable_dimension
}