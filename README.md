# GitHub Infrastructure with Terraform

This repository manages GitHub settings for the **Simuleos-lab** organization using [Terraform](https://www.terraform.io/).  
It defines reproducible rules for branch protection, vulnerability alerts, and issue labels.

---

## 📁 Folder Structure

```

~/.terraform/github/
├─ main.tf
├─ variables.tf
├─ branch_protection.tf
├─ repo_basics.tf
├─ auth.example.tfvars         # public just a template
├─ auth.simuleos.tfvars        # local secrets (ignored)
├─ auth.<context>.tfvars       # other contexts (ignored)
└─ .gitignore

````

- **`*.tf`** — Terraform configuration (safe to commit).  
- **`*.tfvars`** — Local variable files containing secrets or org context (never commit).  
- **`.gitignore`** — Prevents Terraform state, cache, and secrets from being tracked.  

---

## ⚙️ Setup

### 1. Install Terraform

Check version:

```bash
terraform -v
````

If missing, install via Homebrew:

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

---

### 2. Authentication

Create a **fine-grained personal access token (PAT)** on GitHub:

* Go to: `https://github.com/settings/personal-access-tokens`
* Choose **"Fine-grained token"**
* Repository access: **All repositories** (or specific ones)
* Permissions:

  * Repository administration → **Read and write**
  * Repository metadata → **Read**
  * Organization administration → **Read**

Copy the token (starts with `github_pat_...`).

---

### 3. Configure Local Auth Files

Each token and org context lives in a local `.tfvars` file (ignored by Git).

Example `auth.simuleos.tfvars`:

```hcl
github_owner = "Simuleos-lab"
github_token = "github_pat_xxx"
```

Keep all your `.tfvars` files prefixed consistently, e.g.:

* `auth.simuleos.tfvars`
* `auth.bloberias.tfvars`
* `auth.personal.tfvars`

To select a context:

```bash
terraform plan  -var-file=auth.simuleos.tfvars
terraform apply -var-file=auth.simuleos.tfvars
```

---

### 4. Initialize Terraform

Inside `~/.terraform/github`:

```bash
terraform init
```

This downloads the GitHub provider and prepares the working directory.

---

### 5. Plan and Apply

Preview what Terraform will change:

```bash
terraform plan -var-file=auth.simuleos.tfvars
```

Then apply it for real:

```bash
terraform apply -var-file=auth.simuleos.tfvars
```

---

## 🧩 Main Components

### `main.tf`

Defines the provider and data source for an existing repository:

```hcl
provider "github" {
  owner = var.github_owner
  token = var.github_token
}

data "github_repository" "repo" {
  full_name = "${var.github_owner}/${var.repo_name}"
}
```

### `branch_protection.tf`

Applies sensible default protections to `main`:

* Require pull requests (1 approval)
* Dismiss stale reviews
* Require conversation resolution
* Block force pushes and deletions
* Enforce admin rules

### `repo_basics.tf`

Adds useful repository defaults:

* Enable **Dependabot vulnerability alerts**
* Create standard issue labels (`bug`, `enhancement`, `docs`, `question`)

### `variables.tf`

Acts as a schema for configuration inputs:

```hcl
variable "github_owner" { type = string }
variable "github_token" { type = string, sensitive = true }
```

---

## 🧱 Best Practices

* Keep **`.tf`** files versioned.
* Keep **`.tfvars`**, **state**, and **cache** untracked.
* Use descriptive `.tfvars` prefixes (`auth.simuleos.tfvars`, etc.).
* Use **fine-grained tokens** per organization or automation context.
* Run `terraform plan` before every `apply`.
* Periodically back up or rotate your tokens.

---

## 🧰 Optional Enhancements

* Add CI checks to `required_status_checks` once Actions are configured.
* Add a `CODEOWNERS` file and enable `require_code_owner_reviews = true`.
* Use a shared bot account token (`simuleos-bot`) for automation.
* Add more repositories by duplicating `data "github_repository"` + resources.

---

## 🧾 References

* [Terraform GitHub Provider Docs](https://registry.terraform.io/providers/integrations/github/latest)
* [GitHub Branch Protection Rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)

---

© Simuleos-lab — Infrastructure as Code for collaborative reproducibility.

