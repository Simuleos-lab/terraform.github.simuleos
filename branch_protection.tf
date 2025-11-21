# branch_protection.tf
resource "github_branch_protection" "main" {
  for_each      = data.github_repository.repos
  repository_id = each.value.node_id
  pattern       = "main"

  enforce_admins                  = true
  allows_deletions                = false
  allows_force_pushes             = false
  required_linear_history         = true
  require_conversation_resolution = true

  required_status_checks {
    # = "Require branches to be up to date before merging"
    strict   = true     
    # you can add CI checks here later, e.g. ["ci", "lint"]
    contexts = []        
  }

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
  }
}
