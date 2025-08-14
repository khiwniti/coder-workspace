#!/bin/bash

# Coder CLI Setup Script
# This script downloads and installs the latest Coder CLI

set -e

echo "🚀 Setting up Coder CLI..."

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    *)
        echo "❌ Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Get latest version
echo "📥 Fetching latest Coder version..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/coder/coder/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
    echo "❌ Failed to fetch latest version"
    exit 1
fi

echo "📦 Latest version: v$LATEST_VERSION"

# Download Coder CLI
DOWNLOAD_URL="https://github.com/coder/coder/releases/download/v${LATEST_VERSION}/coder_${LATEST_VERSION}_${OS}_${ARCH}.tar.gz"
echo "⬇️  Downloading from: $DOWNLOAD_URL"

curl -L -o coder.tar.gz "$DOWNLOAD_URL"

# Extract and install
echo "📂 Extracting..."
tar -xzf coder.tar.gz

# Make executable and move to PATH
chmod +x coder
sudo mv coder /usr/local/bin/

# Cleanup
rm coder.tar.gz

echo "✅ Coder CLI installed successfully!"
echo "🔧 Version: $(coder version)"
echo ""
echo "Next steps:"
echo "1. Run 'coder login <your-coder-url>' to authenticate"
echo "2. Or set up GitHub Actions with the CODER_SESSION_TOKEN secret"
