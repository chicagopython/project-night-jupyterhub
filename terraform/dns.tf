resource "digitalocean_domain" "jupyterhub" {
  name = "sivji.dev"
}

resource "digitalocean_record" "jupyterhub" {
  domain = digitalocean_domain.jupyterhub.name
  type   = "A"
  name   = local.subdomain
  value  = digitalocean_droplet.jupyterhub.ipv4_address
}
