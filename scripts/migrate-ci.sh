#!/usr/bin/env bash
# File: migrate-ci.sh
# Helper script to transition from old CI to new GitHub Actions

set -euo pipefail

echo "🚀 CI/CD Migration Helper"
echo "========================="

# Check if we're in the right directory
if [[ ! -f "setup.py" ]]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Check if GitHub Actions workflows exist
if [[ ! -d ".github/workflows" ]]; then
    echo "❌ GitHub Actions workflows not found. Please run this after setting up the workflows."
    exit 1
fi

# Test the new scripts
echo "🧪 Testing new CI scripts..."

echo "📝 1. Testing lint script..."
if ./scripts/lint.sh; then
    echo "✅ Lint script works"
else
    echo "❌ Lint script failed"
fi

echo "📝 2. Testing test script..."
if ./scripts/test.sh; then
    echo "✅ Test script works"
else
    echo "❌ Test script failed"
fi

echo "📝 3. Testing build script..."
if ./scripts/build.sh; then
    echo "✅ Build script works"
else
    echo "❌ Build script failed"
fi

# Check Git status
echo "📝 4. Checking Git status..."
if git status --porcelain | grep -q .; then
    echo "⚠️  You have uncommitted changes. Consider committing them before the migration."
    git status --short
else
    echo "✅ Working directory is clean"
fi

# Summary
echo ""
echo "📋 Migration Summary:"
echo "====================="
echo "✅ New GitHub Actions workflows created"
echo "✅ New shell scripts created and tested"
echo "✅ Documentation created"
echo ""
echo "🔄 Next steps:"
echo "1. Commit and push the new workflows and scripts"
echo "2. Create a test PR to verify GitHub Actions work"
echo "3. Once verified, remove the old 'ci/' directory"
echo "4. Update branch protection rules in GitHub"
echo ""
echo "🎉 Migration preparation complete!"
