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
  token = var.github_token
}

data "github_repository" "repos" {
  for_each  = var.repositories
  full_name = "${var.github_owner}/${each.value}"
}