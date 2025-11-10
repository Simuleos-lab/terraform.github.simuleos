resource "github_branch_protection" "main" {
  repository_id = data.github_repository.repo.node_id
  pattern       = "main"

  enforce_admins                  = true
  allows_deletions                = false
  allows_force_pushes             = false
  required_linear_history         = true
  require_conversation_resolution = true

  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
  }
}
