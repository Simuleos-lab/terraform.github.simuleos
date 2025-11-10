~/.terraform/github/
|- main.tf                # public
|- variables.tf           # public
|- repos.tf               # public (your resources/rules)
|- ...
|- .gitignore             # public, ignores secrets/state
|- variables.example.tfvars   # public, template (NO secrets)
|- simuleos.auto.tfvars       # local secret/context (ignored)
|- personal.auto.tfvars       # local secret/context (ignored, optional)
