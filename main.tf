terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = var.github_owner
}

variable "github_owner" {
  type = string
}

variable "repo_name" {
  type    = string
  default = "Simuleos.jl"
}

data "github_repository" "repo" {
  full_name = "${var.github_owner}/${var.repo_name}"
}
