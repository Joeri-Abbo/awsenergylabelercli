# CI/CD Migration Guide

This directory contains modern shell scripts that replace the legacy CI Python scripts in the `ci/` directory.

## Migration Summary

The CI/CD pipeline has been modernized to use GitHub Actions with simplified shell scripts:

### Old vs New Structure

| Old Script | New Script | GitHub Action Job |
|------------|------------|-------------------|
| `ci/scripts/build.py` | `scripts/build.sh` | `build` job in main workflow |
| `ci/scripts/test.py` | `scripts/test.sh` | `test` job in main workflow |
| `ci/scripts/lint.py` | `scripts/lint.sh` | `lint` job in main workflow |
| `ci/scripts/upload.py` | `scripts/upload.sh` | `release` job in main workflow |

### New GitHub Actions Workflows

1. **`.github/workflows/main.yml`** - Main CI/CD pipeline
   - Runs linting, testing, building, and releasing
   - Triggers on push to main, tags, and PRs

2. **`.github/workflows/dev.yml`** - Development workflow
   - Runs on feature branches and develop
   - Quick feedback for development

3. **`.github/workflows/docs.yml`** - Documentation workflow
   - Builds and deploys documentation to GitHub Pages

4. **`.github/workflows/security.yml`** - Security scanning
   - Runs security scans with Safety, Bandit, and Semgrep
   - Weekly scheduled scans

5. **`.github/workflows/update-deps.yml`** - Dependency updates
   - Automatically updates dependencies weekly
   - Creates PRs with updated dependencies

## Usage

### Local Development

You can still run the scripts locally for development:

```bash
# Run linting
./scripts/lint.sh

# Run tests
./scripts/test.sh

# Build package
./scripts/build.sh

# Upload to PyPI (requires PYPI_API_TOKEN)
export PYPI_API_TOKEN="your-token"
./scripts/upload.sh
```

### GitHub Actions

The workflows automatically handle:
- Python environment setup
- Dependency caching
- Parallel job execution
- Artifact uploads
- Automatic releases on tags

## Benefits of the New System

1. **Faster CI**: Parallel job execution and dependency caching
2. **Better Security**: Trusted publishing to PyPI, security scanning
3. **Modern Tools**: Uses latest GitHub Actions and Python tools
4. **Automatic Updates**: Dependencies and security patches
5. **Better Reporting**: Improved test and coverage reports
6. **Documentation**: Automatic docs building and deployment

## Migration Checklist

- [x] Create GitHub Actions workflows
- [x] Replace Python CI scripts with shell scripts
- [x] Update PyPI publishing to use trusted publishing
- [x] Add security scanning
- [x] Add dependency update automation
- [x] Add documentation deployment
- [ ] Remove old CI directory (after verification)
- [ ] Update repository settings for branch protection

## Next Steps

1. Test the new workflows by creating a PR
2. Verify all jobs pass successfully
3. Create a test tag to verify the release process
4. Once verified, remove the old `ci/` directory
5. Update branch protection rules to require the new workflow jobs

## Environment Variables

For PyPI publishing, the workflow uses trusted publishing (recommended) or you can set:
- `PYPI_API_TOKEN` - PyPI API token for package uploads

## Notes

- The new system uses `python -m build` instead of `setup.py sdist`
- Tests use pytest directly instead of tox (but tox is still supported)
- Coverage reports are uploaded to Codecov automatically
- Security scans run weekly and on every PR
