terraform {
  required_version = ">= 0.13"
}

module "example" {
  source = "../../"

  ssh_host        = var.ssh_host
  ssh_user        = var.ssh_user
  ssh_port        = var.ssh_port
  ssh_private_key = file(var.ssh_private_key_file)

  files = {

    "/tmp/main.tf" = {
      owner   = ""
      mode    = ""
      content = file("${path.root}/main.tf")
    }

  }
}
