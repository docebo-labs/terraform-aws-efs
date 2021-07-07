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
  count = length(var.subnets)

  file_system_id = aws_efs_file_system.this.id
  subnet_id      = var.subnets[count.index]

  security_groups = var.security_groups
}

resource "aws_efs_access_point" "this" {
  for_each       = var.access_points
  file_system_id = aws_efs_file_system.this.id

  dynamic "posix_user" {
    for_each = null != lookup(each.value, "posix_user", lookup(var.access_points_defaults, "posix_user", null)) ? [1] : []
    content {
      gid = lookup(lookup(each.value, "posix_user", lookup(var.access_points_defaults, "posix_user")), "gid")
      uid = lookup(lookup(each.value, "posix_user", lookup(var.access_points_defaults, "posix_user")), "uid")
    }
  }

  root_directory {
    path = "/${each.key}"

    dynamic "creation_info" {
      for_each = null != lookup(each.value, "creation_info", lookup(var.access_points_defaults, "creation_info", null)) ? [1] : []

      content {
        owner_gid   = lookup(lookup(each.value, "creation_info", lookup(var.access_points_defaults, "creation_info")), "owner_gid")
        owner_uid   = lookup(lookup(each.value, "creation_info", lookup(var.access_points_defaults, "creation_info")), "owner_uid")
        permissions = lookup(lookup(each.value, "creation_info", lookup(var.access_points_defaults, "creation_info")), "permissions")
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
