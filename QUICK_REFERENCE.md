# QUICK REFERENCE

## Git Commands

```bash
# Initial setup
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR-ORG/harness-test-module.git
git push -u origin main

# Create version
git tag -a v1.0.0 -m "v1.0.0"
git push origin v1.0.0

# Update version
git tag -a v1.1.0 -m "v1.1.0"
git push origin v1.1.0
```

## Environment Variables

```bash
# Required for authentication
export HARNESS_PLATFORM_API_KEY="your-pat-token"
export TF_TOKEN_abc_sandbox_harness_io="your-pat-token"
```

## Module Source Formats

```hcl
# Root module
source = "abc-sandbox.harness.io/<account-id>/harness_test_module/harness"

# Submodule (note the double slash //)
source = "abc-sandbox.harness.io/<account-id>/harness_test_module//modules/rbac"
```

## Harness UI Navigation

- **Module Registry**: Account Settings → IaCM Module Registry
- **Connectors**: Account Settings → Connectors
- **API Tokens**: Profile Icon → My API Keys & Tokens

## Common Issues

| Error | Solution |
|-------|----------|
| 401 Unauthorized | Set `TF_TOKEN_abc_sandbox_harness_io` env var |
| Module not found | Click Sync in Harness Module Registry |
| No versions available | Create and push git tag (v1.0.0) |
| Submodule 404 | Use `//modules/rbac` (double slash) |

## File Structure

```
harness-test-module/
├── main.tf           # Root module
├── variables.tf      # Root variables  
├── outputs.tf        # Root outputs
└── modules/          # Must be named "modules"
    └── rbac/         # Submodule name
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Testing Locally

```bash
# Clean start
rm -rf .terraform .terraform.lock.hcl

# Initialize
terraform init

# Plan
terraform plan
```
