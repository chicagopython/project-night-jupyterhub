# JupyterHub

Guide to setting up a JupyterHub instance for Project Night.

## Terraform

You will need to have access to the Chicago Python organization on [Terraform Cloud](https://app.terraform.io).

1. `terraform login`
1. Create DigitalOcean Access Token using Web Interface; save token
1. Add SSH key to DigitalOcean; update name in `main.tf`

```console
terraform login
export DIGITALOCEAN_ACCESS_TOKEN=[token from above]

# go to the terraform folder in this repo
cd terraform

# initialize terraform providers
terraform init

# view terraform plan
terraform plan

# apply plan if it looks good
terraform apply
```

There will be an IP address outputted. Save that.
