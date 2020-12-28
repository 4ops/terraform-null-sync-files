output "file_updated" {
  value = tomap({ for target, options in null_resource.update_permissions : target => options.id })

  description = "Last time file update identifier. Can be used for call some actions after file changed."
}
