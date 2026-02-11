# Harness IACM Module Registry - Minimal Test

A minimal Terraform module for testing Harness IACM Module Registry with submodules.

## Structure

```
.
├── main.tf              # Root module
├── variables.tf         # Root variables
├── outputs.tf          # Root outputs
└── modules/            # Submodules folder (REQUIRED name)
    └── rbac/           # Simple RBAC submodule
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Quick Start

### 1. Push to GitHub

```bash
# Initialize git
git init
git add .
git commit -m "Initial commit"

# Add remote and push
git remote add origin https://github.com/YOUR-ORG/harness-test-module.git
git push -u origin main

# Create and push a tag
git tag -a v1.0.0 -m "v1.0.0"
git push origin v1.0.0
```

### 2. Register in Harness

1. Go to Harness → **Account Settings** → **IaCM Module Registry**
2. Click **+ New Module**
3. Fill in:
   - **Name**: `harness_test_module`
   - **Repository Connector**: Select your GitHub connector
   - **Repository Branch**: `main`
   - **Repository Path**: `.`
   - **Git Tag Pattern**: `v*`
4. Click **Save** then **Sync**

### 3. Use the Module

```hcl
# Root module
module "test" {
  source  = "abc-sandbox.harness.io/<account-id>/harness_test_module/harness"
  version = "1.0.0"
  
  org_name = "my-test-org"
}

# Submodule
module "rbac" {
  source  = "abc-sandbox.harness.io/<account-id>/harness_test_module//modules/rbac"
  version = "1.0.0"
  
  org_id         = "test_org_id"
  user_group_name = "test-group"
}
```

### 4. Authenticate

```bash
# Set environment variable
export TF_TOKEN_abc_sandbox_harness_io="your-pat-token"

# Initialize
terraform init
```

## Requirements

- Terraform >= 1.6.0
- Harness Provider >= 0.40
