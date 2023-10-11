# EFS

A simple EFS module to create a file system and some entry points.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.54 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.20.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_access_point.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_vpc_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_points"></a> [access\_points](#input\_access\_points) | The list of access points | `map(map(map(string)))` | `{}` | no |
| <a name="input_access_points_defaults"></a> [access\_points\_defaults](#input\_access\_points\_defaults) | The default values for the access points | `map(map(string))` | `{}` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the module is being applied. Required when `enable_vpc_endpoint == true` | `string` | `""` | no |
| <a name="input_enable_vpc_endpoint"></a> [enable\_vpc\_endpoint](#input\_enable\_vpc\_endpoint) | Whether to enable the VPC endpoint | `bool` | `false` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Whether the EFS File System should be encrypted | `bool` | `false` | no |
| <a name="input_file_system_name"></a> [file\_system\_name](#input\_file\_system\_name) | The name of the file system | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The KMS Key ID that will be used to encrypt the file system. Encryption will be turned on automatically | `string` | `""` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | The file system performance mode | `string` | `"generalPurpose"` | no |
| <a name="input_provisioned_throughput_in_mibps"></a> [provisioned\_throughput\_in\_mibps](#input\_provisioned\_throughput\_in\_mibps) | The throughput when using 'throughput\_mode == "provisioned"' | `number` | `0` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | The security groups used in the ALB and the ECS service | `list(string)` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The list of subnets where the services will be deployed | `list(string)` | n/a | yes |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | Throughput mode for the file system. When using provisioned, specify 'provisioned\_throughput\_in\_mibps' | `string` | `"bursting"` | no |
| <a name="input_transition_to_ia"></a> [transition\_to\_ia](#input\_transition\_to\_ia) | The period of time that a file is not accessed, after which it transitions to the IA storage class | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC identifier. Required when `enable_vpc_endpoint == true` | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_points"></a> [access\_points](#output\_access\_points) | The access point list |
| <a name="output_file_system_id"></a> [file\_system\_id](#output\_file\_system\_id) | The file system ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
