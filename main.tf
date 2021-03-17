resource "aws_efs_file_system" "this" {
  encrypted                       = var.encrypted
  kms_key_id                      = var.kms_key_id
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.transition_to_ia
    }
  }

  tags = {
    Name = var.file_system_name
  }
}

resource "aws_efs_mount_target" "this" {
  for_each = toset(var.subnets)

  file_system_id = aws_efs_file_system.this.id
  subnet_id      = each.value

  security_groups = var.security_groups
}

locals {
  default_uid        = lookup(var.access_points_defaults, "user_uid", "")
  default_gid        = lookup(var.access_points_defaults, "user_gid", "")
  default_permission = lookup(var.access_points_defaults, "user_gid", "")
}

resource "aws_efs_access_point" "this" {
  for_each       = var.access_points
  file_system_id = aws_efs_file_system.this.id

  dynamic "posix_user" {
    for_each = "" != lookup(each.value, "user_gid", local.default_gid) || "" != lookup(each.value, "user_uid", local.default_uid) ? [each.value] : []
    content {
      gid = lookup(posix_user, "user_gid", local.default_gid)
      uid = lookup(posix_user, "user_uid", local.default_uid)
    }
  }

  root_directory {
    path = "/${each.key}"

    dynamic "creation_info" {
      for_each = "" != lookup(each.value, "user_gid", local.default_gid) || "" != lookup(each.value, "user_uid", local.default_uid) || "" != lookup(each.value, "permission", local.default_permission) ? [each.value] : []

      content {
        owner_gid   = lookup(creation_info, "user_gid", local.default_gid)
        owner_uid   = lookup(creation_info, "user_uid", local.default_uid)
        permissions = lookup(creation_info, "permission", local.default_permission)
      }
    }
  }

  tags = {
    Name = each.key
  }
}

resource "aws_vpc_endpoint" "this" {
  count = var.enable_vpc_endpoint ? 1 : 0

  service_name = "com.amazonaws.${var.aws_region}.elasticfilesystem"
  vpc_id       = var.vpc_id

  vpc_endpoint_type   = "Interface"
  security_group_ids  = var.security_groups
  subnet_ids          = var.subnets
  private_dns_enabled = true

  tags = {
    Name = var.file_system_name
  }
}
