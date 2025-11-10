resource "github_repository_vulnerability_alerts" "alerts" {
  repository = data.github_repository.repo.name
}

resource "github_issue_label" "bug" {
  repository = data.github_repository.repo.name
  name       = "bug"
  color      = "d73a4a"
}

resource "github_issue_label" "enhancement" {
  repository = data.github_repository.repo.name
  name       = "enhancement"
  color      = "a2eeef"
}

resource "github_issue_label" "docs" {
  repository = data.github_repository.repo.name
  name       = "docs"
  color      = "0075ca"
}

resource "github_issue_label" "question" {
  repository = data.github_repository.repo.name
  name       = "question"
  color      = "d876e3"
}
