variable "github_owner" {
  type        = string
  description = "GitHub org or username, e.g. Simuleos-lab"
}

variable "github_token" {
  type        = string
  sensitive   = true
  description = "Fine-grained PAT with repo admin permissions"
}

# variables.tf
variable "repositories" {
  description = "Repos to manage in Simuleos-lab"
  type        = set(string)
}
