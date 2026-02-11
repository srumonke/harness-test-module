# SETUP GUIDE - Step by Step

## Step 1: Create GitHub Repository

```bash
cd harness-iacm-test

# Initialize git
git init

# Add all files
git add .
git commit -m "Initial commit: minimal Harness IACM test module"

# Create GitHub repo (replace YOUR-ORG with your GitHub org/username)
# Go to GitHub and create a new repository named: harness-test-module

# Add remote
git remote add origin https://github.com/YOUR-ORG/harness-test-module.git

# Push to GitHub
git branch -M main
git push -u origin main

# Create and push version tag
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## Step 2: Create GitHub Connector in Harness

1. Login to Harness: `https://abc-sandbox.harness.io`
2. Click the gear icon (⚙️) → **Account Settings**
3. Go to **Connectors** → **+ New Connector**
4. Select **Code Repositories** → **GitHub**
5. Fill in:
   - **Name**: `github_test` (or any name)
   - **URL Type**: Repository
   - **Connection Type**: HTTP
   - **GitHub Repository URL**: `https://github.com/YOUR-ORG/harness-test-module`
   - **Authentication**: 
     - Click **+ Create or Select a Secret**
     - Create new secret with your GitHub Personal Access Token (PAT)
     - Token needs `repo` scope
   - **Connectivity Mode**: Connect through Harness Platform
6. Click **Test** to verify connection
7. Click **Finish**

## Step 3: Register Module in Harness

1. In Harness, go to **Account Settings**
2. Click **IaCM Module Registry** (under Account Resources)
3. Click **+ New Module**
4. Fill in:
   - **Module Name**: `harness_test_module`
   - **Description**: `Test module for IACM registry`
   - **Repository Connector**: Select `github_test` (or whatever you named it)
   - **Repository Branch**: `main`
   - **Repository Path**: `.` (root of repository)
   - **Git Tag Pattern**: `v*` (matches v1.0.0, v1.1.0, etc.)
5. Click **Save**
6. Click the **Sync** button to pull versions from GitHub
7. You should see version `v1.0.0` appear

## Step 4: Get Your Personal Access Token (PAT)

1. In Harness, click your profile icon (top right)
2. Go to **My API Keys & Tokens**
3. Click **+ API Key**
4. Name it: `terraform_module_registry`
5. Set expiration (recommend 90 days for testing)
6. Click **Generate Token**
7. **Copy the token** (you won't see it again!)

## Step 5: Test Module Locally

Create a test directory:

```bash
mkdir ~/test-harness-module
cd ~/test-harness-module
```

Create `main.tf`:

```hcl
terraform {
  required_version = ">= 1.6.0"
  
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "~> 0.40"
    }
  }
}

provider "harness" {
  endpoint   = "https://abc-sandbox.harness.io/gateway"
  account_id = "OTk3Mjc0MzEtNWFhMy00OG"  # Replace with your account ID
}

# Test root module
module "test_root" {
  source  = "abc-sandbox.harness.io/OTk3Mjc0MzEtNWFhMy00OG/harness_test_module/harness"
  version = "1.0.0"
  
  org_name = "test-organization"
}

# Test submodule
module "test_rbac" {
  source  = "abc-sandbox.harness.io/OTk3Mjc0MzEtNWFhMy00OG/harness_test_module//modules/rbac"
  version = "1.0.0"
  
  org_id          = module.test_root.organization_id
  user_group_name = "platform-team"
}

output "org_id" {
  value = module.test_root.organization_id
}
```

Set environment variables and test:

```bash
# Set authentication tokens
export HARNESS_PLATFORM_API_KEY="your-pat-token-here"
export TF_TOKEN_abc_sandbox_harness_io="your-pat-token-here"

# Initialize
terraform init

# You should see:
# "Initializing modules..."
# "Module abc-sandbox.harness.io/OTk3Mjc0MzEtNWFhMy00OG/harness_test_module/harness 1.0.0"

# Plan
terraform plan

# If plan works, you're ready to go!
```

## Troubleshooting

### 401 Unauthorized Error

**Problem**: `Failed to retrieve available versions... 401 Unauthorized`

**Solutions**:
1. Check token is set: `echo $TF_TOKEN_abc_sandbox_harness_io`
2. Verify token hasn't expired
3. Create `.terraformrc` file:
   ```hcl
   # ~/.terraformrc
   credentials "abc-sandbox.harness.io" {
     token = "your-pat-token"
   }
   ```

### Module not found

**Problem**: Module doesn't appear after registration

**Solutions**:
1. Verify git tag exists: `git tag -l`
2. Click **Sync** button in Harness Module Registry
3. Check Repository Connector has access to the repo
4. Verify tag matches pattern (e.g., `v*` matches `v1.0.0`)

### Submodule not found

**Problem**: Submodule path returns 404

**Solutions**:
1. Verify submodule is in `modules/` folder (exact name required)
2. Check syntax: use `//modules/rbac` (double slash)
3. Version applies to entire module, not individual submodules

## Success Criteria

✅ Repository created and tagged in GitHub  
✅ GitHub connector created in Harness  
✅ Module registered in Harness Module Registry  
✅ Version appears after sync  
✅ `terraform init` downloads the module  
✅ Both root module and submodule work  

## Next Steps

Once working:
1. Make changes to the module
2. Create new git tag: `git tag v1.1.0 && git push origin v1.1.0`
3. Click Sync in Harness
4. Update version in your Terraform: `version = "1.1.0"`
5. Run `terraform init -upgrade`
