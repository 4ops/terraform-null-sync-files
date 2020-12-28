# Sync files

Helps to synchronize files on remote server.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| null | ~> 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| null | ~> 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_file\_mode | Default permissions mode. Used if <file>.mode has empty value. | `string` | `"0644"` | no |
| files | Map absolute target file paths to objects contains their properties. | <pre>map(object({<br>    content = string<br>    owner   = string<br>    mode    = string<br>  }))</pre> | `{}` | no |
| force\_resync\_all | Replaces all files. | `string` | `"Change me for action"` | no |
| force\_update\_permissions | Updates owner and mode for all files. | `string` | `"Change me for action"` | no |
| resync\_on\_host\_changed | Resync file if SSH host changed. | `bool` | `true` | no |
| ssh\_host | Required: hostname for SSH connection. | `string` | n/a | yes |
| ssh\_port | SSH server port number. | `number` | `22` | no |
| ssh\_private\_key | Required: private key for SSH authentication. | `string` | n/a | yes |
| ssh\_user | SSH username. | `string` | `"root"` | no |
| sudo\_enabled | Enables sudo command usage. Sudo command can be customized in `sudo_template` input variable. | `bool` | `true` | no |
| sudo\_template | String template for running commands with super user privileges. | `string` | `"sudo %s"` | no |
| upload\_directory | Temporary directory for uploading files. It will be created if not exists. | `string` | `"~/.upload"` | no |

## Outputs

| Name | Description |
|------|-------------|
| file\_updated | Last time file update identifier. Can be used for call some actions after file changed. |
