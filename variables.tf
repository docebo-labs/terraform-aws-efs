variable "file_system_name" {
  type        = string
  description = "The name of the file system"
  default     = ""
}

variable "encrypted" {
  type        = bool
  description = "Whether the EFS File System should be encrypted"
  default     = false
}

variable "kms_key_id" {
  type        = string
  description = "The KMS Key ID that will be used to encrypt the file system. Encryption will be turned on automatically"
  default     = ""
}

variable "performance_mode" {
  type        = string
  description = "The file system performance mode"
  default     = "generalPurpose"

  validation {
    condition     = contains(["generalPurpose", "maxIO"], var.performance_mode)
    error_message = "The file system performance mode must be either 'generalPurpose' or 'maxIO'."
  }
}

variable "throughput_mode" {
  type        = string
  description = "Throughput mode for the file system. When using provisioned, specify 'provisioned_throughput_in_mibps'"
  default     = "bursting"

  validation {
    condition     = contains(["bursting", "provisioned"], var.throughput_mode)
    error_message = "Throughput mode must be either 'bursting' or 'provisioned'."
  }
}

variable "provisioned_throughput_in_mibps" {
  type        = number
  description = "The throughput when using 'throughput_mode == \"provisioned\"'"
  default     = 0
}

variable "transition_to_ia" {
  type        = string
  description = "The period of time that a file is not accessed, after which it transitions to the IA storage class"
  default     = ""

  validation {
    condition     = var.transition_to_ia == "" || contains(["AFTER_7_DAYS", "AFTER_14_DAYS", "AFTER_30_DAYS", "AFTER_60_DAYS", "AFTER_90_DAYS"], var.transition_to_ia)
    error_message = "Invalid value for transition_to_ia."
  }
}

variable "access_points" {
  type        = map(any)
  description = "The list of access points"
  default     = {}
}

variable "access_points_defaults" {
  type        = map(any)
  description = "The default values for the access points"
  default     = {}
}

variable "subnets" {
  type        = list(string)
  description = "The list of subnets where the services will be deployed"

  validation {
    condition     = alltrue([for sg in var.subnets : can(regex("^subnet-", sg))])
    error_message = "All subnets must be valid."
  }
}

variable "security_groups" {
  type        = list(string)
  description = "The security groups used in the ALB and the ECS service"

  validation {
    condition     = alltrue([for sg in var.security_groups : can(regex("^sg-", sg))])
    error_message = "All security groups must be valid."
  }
}

variable "enable_vpc_endpoint" {
  type        = bool
  default     = false
  description = "Whether to enable the VPC endpoint"
}

variable "vpc_id" {
  type        = string
  description = "The VPC identifier. Required when `enable_vpc_endpoint == true`"
  default     = ""

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "Wrong value for variable vpc_id."
  }
}

variable "aws_region" {
  type        = string
  default     = ""
  description = "The AWS region where the module is being applied. Required when `enable_vpc_endpoint == true`"
}

