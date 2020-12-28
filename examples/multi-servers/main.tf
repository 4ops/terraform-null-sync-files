terraform {
  required_version = ">= 0.13"
}

module "example" {
  source = "../../"

  for_each = toset(var.ssh_hosts)

  ssh_host        = each.key
  ssh_user        = var.ssh_user
  ssh_port        = var.ssh_port
  ssh_private_key = file(var.ssh_private_key_file)

  files = {

    "/tmp/main.tf" = {
      owner   = "root:root"
      mode    = "0600"
      content = file("${path.root}/main.tf")
    }

    "/tmp/variables.tf" = {
      owner   = "nobody"
      mode    = "0666"
      content = file("${path.root}/variables.tf")
    }

    "/tmp/outputs.tf" = {
      owner   = "1000"
      mode    = "a+rw"
      content = file("${path.root}/outputs.tf")
    }

  }
}
