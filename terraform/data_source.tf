data "terraform_remote_state" "geral" {
  backend = "remote"

  config = {
    organization = "ambrosia-serve"
    workspaces = {
      name = "postech-workspace"
    }
  }
}

data "aws_vpc" "vpc" {
  id = data.terraform_remote_state.geral.outputs.vpc_id
}