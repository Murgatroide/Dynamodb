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

module "autoscaling-control" {
    source = "./autoscaling"
    autoscaling-control = "Mod-Autoscaling"
}

module "dax-control" {
    source = "./dax"
    dax-control = "Mod-DAX"
}

output "autoscaling-control-1" {
  value = module.autoscaling-control.module_output_1
}
output "autoscaling-control-2" {
  value = module.autoscaling-control.module_output_2
}
output "aws_dax_parameter_group-3" {
  value = module.dax-control.module_output_3
}
output "aws_dax_cluster-4" {
  value = module.dax-control.module_output_4
}
output "autoscaling-control-5" {
  value = module.autoscaling-control.module_output_5
}
output "autoscaling-control-6" {
  value = module.autoscaling-control.module_output_6
}