data "terraform_remote_state" "geral" {
  backend = "remote"

  config = {
    organization = "ambrosia-serve"
    workspaces = {
      name = "postech-workspace"
    }
  }
}

data "aws_vpc" "ambrosia_serve_vpc" {
  id = var.vpc_id
}
