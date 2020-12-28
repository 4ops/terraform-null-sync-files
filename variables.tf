variable "ssh_host" {
  type = string

  description = "Required: hostname for SSH connection."
}

variable "resync_on_host_changed" {
  type    = bool
  default = true

  description = "Resync file if SSH host changed."
}

variable "ssh_user" {
  type    = string
  default = "root"

  description = "SSH username."
}

variable "ssh_port" {
  type    = number
  default = 22

  validation {
    condition     = var.ssh_port > 0 && var.ssh_port < 65536 && floor(var.ssh_port) == var.ssh_port
    error_message = "Must be positive integer number. Max value: 65535."
  }

  description = "SSH server port number."
}

variable "ssh_private_key" {
  type = string

  description = "Required: private key for SSH authentication."
}

variable "sudo_enabled" {
  type    = bool
  default = true

  description = "Enables sudo command usage. Sudo command can be customized in `sudo_template` input variable."
}

variable "sudo_template" {
  type    = string
  default = "sudo %s"

  description = "String template for running commands with super user privileges."
}

variable "files" {
  type = map(object({
    content = string
    owner   = string
    mode    = string
  }))

  default = {}

  description = "Map absolute target file paths to objects contains their properties."
}

variable "default_file_mode" {
  type    = string
  default = "0644"

  description = "Default permissions mode. Used if <file>.mode has empty value."
}

variable "upload_directory" {
  type    = string
  default = "~/.upload"

  description = "Temporary directory for uploading files. It will be created if not exists."
}

variable "force_update_permissions" {
  type    = string
  default = "Change me for action"

  description = "Updates owner and mode for all files."
}

variable "force_resync_all" {
  type    = string
  default = "Change me for action"

  description = "Replaces all files."
}
