# Changelog

## 1.1.0

- Update to use DevPortfolio template.
- Remove main and dev branches, convert feature to main branch.
- Rename previous feature branch to become main.
- Remove html-validation checks due to template in-line styles being needed for optimal UI. 
- Change workflows to update following major UI update. 
- Update copy on resume to mirror resume.

## 1.2.0
- Change CI/CD to consolidate SBOM generation and scanning in one workflow.
- Remove schedule of some CI/CD workflows and only do on pushed changed and updates.
- Updated README.MD to show changes.
- Certain CI/CD that use cloud infrastructure will be in txt and not always in yml (terraform and build-site).