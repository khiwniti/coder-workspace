# Coder Setup Workspace

This repository contains a GitHub Actions workflow to set up and authenticate with Coder's CLI.

## Setup Instructions

### 1. Create a Coder Session Token

You need to create a long-lived session token for GitHub Actions to authenticate with your Coder deployment.

**Option A: Using Coder CLI**
```bash
coder token create --lifetime 8760h --name "GitHub Actions"
```

**Option B: Using Browser Console**
1. Log into your Coder deployment in your browser
2. Open the browser developer console (F12)
3. Run the following command:
   ```javascript
   coder token create --lifetime 8760h --name "GitHub Actions"
   ```

### 2. Configure GitHub Secrets

1. Go to your GitHub repository settings
2. Navigate to **Settings** > **Secrets and variables** > **Actions**
3. Click **New repository secret**
4. Create a secret named `CODER_SESSION_TOKEN` with the token value from step 1

### 3. Update Workflow Configuration

1. Open `.github/workflows/main.yml`
2. Replace `https://coder.example.com` with your actual Coder deployment URL
3. Ensure your Coder user has the appropriate permissions (Template Admin or Owner role)

## Workflow Features

The GitHub Actions workflow:
- Triggers on pushes to main branch
- Triggers on pull requests to main branch
- Can be manually triggered via workflow_dispatch
- Sets up Coder CLI with authentication
- Ready for additional Coder commands

## Usage Example

After setup, you can add additional steps to your workflow to run Coder commands:

```yaml
- name: List Coder workspaces
  run: coder list

- name: Create workspace
  run: coder create my-workspace --template my-template

- name: Stop workspace
  run: coder stop my-workspace
```

## Security Notes

- Never commit session tokens directly in your code
- Use GitHub secrets for sensitive information
- Consider using shorter-lived tokens for production environments
- Regularly rotate your session tokens

## Troubleshooting

- Ensure your Coder deployment is accessible from GitHub Actions runners
- Verify that your session token has the correct permissions
- Check that the access_url is correct and includes the protocol (https://)
