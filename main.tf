terraform {
  required_version = ">= 0.13"

  required_providers {
    null = "~> 3.0.0"
  }
}

locals {
  host_changed     = var.resync_on_host_changed ? var.ssh_host : ""
  command_template = var.sudo_enabled ? var.sudo_template : "%s"
}

resource "null_resource" "update_content" {
  for_each = var.files

  triggers = {
    host_changed     = local.host_changed
    checksum_changed = sha256(each.value.content)
    force_resync_all = var.force_resync_all
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = var.ssh_private_key
    host        = var.ssh_host
    port        = var.ssh_port
  }

  provisioner "remote-exec" {
    inline = formatlist(local.command_template, [
      "mkdir -p ${var.upload_directory}",
      "chown -R ${var.ssh_user} ${var.upload_directory}",
      "chmod 0700 ${var.upload_directory}",
    ])
  }

  provisioner "file" {
    content     = each.value.content
    destination = "${var.upload_directory}/${sha256(each.key)}"
  }

  provisioner "remote-exec" {
    inline = formatlist(local.command_template, [
      "mkdir -p ${dirname(each.key)}",
      "mv -f ${var.upload_directory}/${sha256(each.key)} ${each.key}",
    ])
  }
}

resource "null_resource" "update_permissions" {
  for_each = var.files

  depends_on = [null_resource.update_content]

  triggers = {
    host_changed       = local.host_changed
    checksum_changed   = sha256(each.value.content)
    mode_changed       = each.value.mode != "" ? each.value.mode : var.default_file_mode
    owner_changed      = each.value.owner != "" ? each.value.owner : var.ssh_user
    force_resync_all   = var.force_resync_all
    update_permissions = var.force_update_permissions
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = var.ssh_private_key
    host        = var.ssh_host
    port        = var.ssh_port
  }

  provisioner "remote-exec" {
    inline = formatlist(local.command_template, [
      "chmod ${each.value.mode != "" ? each.value.mode : var.default_file_mode} ${each.key}",
      "chown ${each.value.owner != "" ? each.value.owner : var.ssh_user} ${each.key}",
    ])
  }
}
