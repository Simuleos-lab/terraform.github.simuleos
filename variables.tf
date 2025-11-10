variable "github_owner" {
  type        = string
  description = "GitHub org or username, e.g. Simuleos-lab"
}

variable "github_token" {
  type        = string
  sensitive   = true
  description = "Fine-grained PAT with org/repo admin perms"
}
