# JupyterHub

Guide to setting up a JupyterHub instance for Project Night
using [The Littlest JupyterHub](https://tljh.jupyter.org) workflow.

#### Table of Contents

<!-- TOC -->

- [Provisioning VM via Terraform](#provisioning-vm-via-terraform)
- [Configuring Server with Ansible](#configuring-server-with-ansible)
- [Configuring JupyterHub](#configuring-jupyterhub)
  - [Setting up Development Enviroment for All Users](#setting-up-development-enviroment-for-all-users)
  - [User Workflow](#user-workflow)
- [Delete JupyterHub Resources](#delete-jupyterhub-resources)

<!-- /TOC -->

## Provisioning VM via Terraform

You will need to have access to the Chicago Python organization
on [Terraform Cloud](https://app.terraform.io).

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

## Configuring Server with Ansible

1. Requires ansible installed on the command line

```console
# go to ansible folder in this repo
cd ansible

# run playbook
ansible-playbook -i hosts install_and_configure_jupyterhub.yaml --extra-vars "admin_user_id=[admin-user-id] admin_email=[your-email-for-lets-encrypt] domain=jupyterhub.sivji.dev"
```

Note: might need to delete the jupyterhub.[yourdomain] entry from `~/.ssh/known_hosts`

## Configuring JupyterHub

JupyterHub is available on the domain configured it with.
You can use your [admin-user-id] to login.
The password you login with will be your password for this installation.

### Setting up Development Enviroment for All Users

[JupyterHub docs](https://tljh.jupyter.org/en/latest/howto/env/user-environment.html)

1. Login with your admin user account
1. `pip install` the required files

Recommend using a `requirements.txt` file to ensure you get the correct versions as required.

The docs have a [guide on updating Python versions](https://tljh.jupyter.org/en/latest/howto/env/user-environment.html#upgrade-to-a-newer-python-version),
but I have not been able to get it to work.
My solution is to fork [the-littlest-jupyterhub repo](https://github.com/jupyterhub/the-littlest-jupyterhub/) and change the miniconda version in the `ensure_user_environment` function. Also removed the sha check.
Then I pointed the ansible playbook to the bootstrap.py in my fork.

### User Workflow

1. Users can go to your domain and create an account to use JupyterHub
1. We can use [nbgitpuller](https://tljh.jupyter.org/en/latest/howto/content/nbgitpuller.html)
to create a link that users can use to fork a git repo to their JupyterHub workspace.

## Delete JupyterHub Resources

```console
export DIGITALOCEAN_ACCESS_TOKEN=[token from above]

# go to the terraform folder in this repo
cd terraform
terraform destroy
```
