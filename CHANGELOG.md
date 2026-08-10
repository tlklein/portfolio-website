# Changelog

- Update to use DevPortfolio template.
- Remove main and dev branches, convert feature to main branch.
- Rename previous feature branch to become main.
- Remove html-validation checks due to template in-line styles being needed for optimal UI. 
- Change workflows to update following major UI update. 
- Update copy on resume to mirror resume.
- Change CI/CD to consolidate SBOM generation and scanning in one workflow.
- Remove schedule of some CI/CD workflows and only do on pushed changed and updates.
- Updated README.MD to show changes as updated.
- Certain CI/CD that use cloud infrastructure will be in txt and not always in yml (terraform and build-site).
- Fix node version mix-up. Different versions on different folders, both being used in application. Deleted the runaway and noted commands below for future reference. Caused npm run build to not work because it was using a runaway version, not the proper version. 

## Commands For Reference
node -p "process.execPath"
npm exec -- node -p "process.execPath"
where node
npm ls node -g
.\node_modules\.bin\astro dev
npm config get prefix
