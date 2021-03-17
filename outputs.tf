output "file_system_id" {
  value       = aws_efs_file_system.this.id
  description = "The file system ID"
}

output "access_points" {
  value       = aws_efs_access_point.this
  description = "The access point list"
}
