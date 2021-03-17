# EFS

A simple EFS module to create a file system and some entry points.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.14 |
| aws | ~> 3.31 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.31 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_points | The list of access points | `map(map(map(string)))` | `{}` | no |
| access\_points\_defaults | The default values for the access points | `map(map(string))` | `{}` | no |
| aws\_region | The AWS region where the module is being applied. Required when `enable_vpc_endpoint == true` | `string` | `""` | no |
| enable\_vpc\_endpoint | Whether to enable the VPC endpoint | `bool` | `false` | no |
| encrypted | Whether the EFS File System should be encrypted | `bool` | `false` | no |
| file\_system\_name | The name of the file system | `string` | `""` | no |
| kms\_key\_id | The KMS Key ID that will be used to encrypt the file system. Encryption will be turned on automatically | `string` | `""` | no |
| performance\_mode | The file system performance mode | `string` | `"generalPurpose"` | no |
| provisioned\_throughput\_in\_mibps | The throughput when using 'throughput\_mode == "provisioned"' | `number` | `0` | no |
| security\_groups | The security groups used in the ALB and the ECS service | `list(string)` | n/a | yes |
| subnets | The list of subnets where the services will be deployed | `list(string)` | n/a | yes |
| throughput\_mode | Throughput mode for the file system. When using provisioned, specify 'provisioned\_throughput\_in\_mibps' | `string` | `"bursting"` | no |
| transition\_to\_ia | The period of time that a file is not accessed, after which it transitions to the IA storage class | `string` | `""` | no |
| vpc\_id | The VPC identifier. Required when `enable_vpc_endpoint == true` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| access\_points | n/a |
| file\_system\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
