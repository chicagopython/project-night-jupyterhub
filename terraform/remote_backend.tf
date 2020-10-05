terraform {
  backend "remote" {
    organization = "chicago-python"

    workspaces {
      name = "ProjectNight-JupyterHub"
    }
  }
}
