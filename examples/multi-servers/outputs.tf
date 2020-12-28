output "file_updated" {
  value = tomap({ for k, v in module.example : k => v.file_updated })
}
