data "digitalocean_ssh_key" "personal" {
  name = local.ssh_key_name
}

resource "digitalocean_droplet" "jupyterhub" {
  image    = "ubuntu-18-04-x64"
  name     = local.machine_name
  region   = "nyc1"
  size     = "s-2vcpu-4gb"
  backups  = false
  ssh_keys = [data.digitalocean_ssh_key.personal.id]
}

output "jupyterhub_ip_address" {
  value = digitalocean_droplet.jupyterhub.ipv4_address
}
