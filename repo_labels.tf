# # repo_labels.tf
# locals {
#   standard_labels = {
#     bug         = "d73a4a"
#     enhancement = "a2eeef"
#     docs        = "0075ca"
#     question    = "d876e3"
#   }
# }

# resource "github_issue_label" "standard" {
#   for_each = {
#     for pair in flatten([
#       for repo_key, repo in data.github_repository.repos : [
#         for label, color in local.standard_labels :
#         "${repo.name}:${label}" => {
#           repo  = repo.name
#           name  = label
#           color = color
#         }
#       ]
#     ]) : pair.key => pair.value
#   }

#   repository = each.value.repo
#   name       = each.value.name
#   color      = each.value.color
# }
