# Cloud Resume Challenge

![banner](/documentation/all-devices-black.png)

Welcome! This repo documents my Cloud Resume Challenge, a hands-on project
where I combined AWS services, Infrastructure-as-Code, CI/CD, and DevOps
practices into a single portfolio project.

## Let's Connect

If you're following this challenge, or just passing by, feel free to connect
with me and explore my socials. I'm always happy to help if you need anything!
I'm also open to new opportunities. If you have inquiries or questions for me,
let me know!

- [LinkedIn](https://linkedin.com/in/trinity-klein/)
- [GitHub](https://github.com/tlklein)
- [Dev.To Blog](https://dev.to/tlklein)
- Email: <tlklein05@gmail.com>

## Final Product

To view the live website, please [click here](https://www.trinityklein.dev/)

## TL;DR

- Modern, minimalist portfolio template built with Astro and Tailwind CSS
  using DevPortfolio.
- Multi-account AWS Organization setup: Production + Test OUs, MFA enabled.  
- Backend visitor counter using Lambda + API Gateway + DynamoDB.  
- Infrastructure managed via Terraform 1.6+ with modularized resources.  
- CI/CD with GitHub Actions + Playwright, secured with OIDC and
  least-privilege IAM.  

----

## Table of Contents

- [Let's Connect](#lets-connect)
- [Final Product](#final-product)
- [TL;DR](#tldr)
- [Architecture Overview](#architecture-overview)
- [Architecture Diagrams](#architecture-diagrams)
- [Architecture Trade-Offs](#architecture-trade-offs)
- [Blog Series](#blog-series)
- [Tech Stack](#tech-stack)
- [Configuration](#configuration)
- [Local Development](#local-development)
- [File Structure](#file-structure)
- [Future Improvements](#future-improvements)
- [References / Helpful Links](#references--helpful-links)

## Architecture Overview

- Modern, minimalist portfolio template built with Astro and Tailwind CSS.
- Static hosting using S3 and CloudFront:
  - Static assets stored in an S3 bucket with public access disabled and
    static website hosting turned off.
  - Files served only via CloudFront OAC and a bucket policy.
  - Bucket hardening using versioning, server-side encryption (AES256),
    lifecycle rules to transition noncurrent objects to lower-cost classes,
    and `force_destroy = false` to avoid accidental mass deletes.
- Infrastructure as Code using Terraform:
  - All cloud resources (S3, CloudFront, ACM, Route53, DynamoDB, Lambda,
    API Gateway, and IAM roles/policies) are defined in Terraform modules
    for repeatable deployments.
  - State stored remotely in S3 and DynamoDB.
- Account structure & hardening using AWS Organizations:
  - 1 Organization with 2 OUs: `production` and `test`, each OU has
    dedicated user accounts for environment separation.
  - Root account exists but is locked down; MFA enabled on all accounts.
  - Billing alert configured to notify on very small thresholds (> $0.01)
    to catch accidental spending.
- Visitor analytics using serverless and NoSQL:
  - DynamoDB table tracks visits.
  - AWS Lambda implements the hit/visitor logic logging total and unique
    visits.
  - API Gateway (HTTP) fronts the Lambda and exposes a lightweight endpoint
    used by the resume footer to show counts, with graceful fallback. It will
    show `Loading...` if API is unreachable.
- CI/CD, smoke testing using GitHub Actions and Playwright:
  - Workflow builds the Hugo site, uploads a build artifact, syncs to S3,
    invalidates CloudFront, and runs Playwright smoke tests.
  - Deployments were performed primarily via terminal in the AWS CLI to keep
    tight control during development; GitHub Actions is configured for code
    validation on all branches, and only Terraform plan and apply on main branch.
- Supply-chain and credential security:
  - GitHub Actions uses OIDC and short-lived roles with no long-term secrets
    to assume a deploy role in AWS.
  - Principle of least privilege applied to IAM policies; deployment and
    runtime roles are scoped narrowly.
  - Artifacts and objects use lifecycle policies and versioning to support
    rollback and forensic analysis.

## Architecture Diagrams

These are the set of diagrams that illustrate the system from multiple
perspectives. These visuals help clarify how the application is structured
end-to-end, from the user-facing front-end, to the serverless back-end, all
the way down to how S3 objects are managed over time.

### High-level

Provides a system-wide overview showing CloudFront, API Gateway, Lambda,
DynamoDB, S3, and supporting services

![banner](/documentation/high-level-diagram.png)

### Front-end

Shows how the static website is delivered from S3 through CloudFront and how
client-side logic interacts with the API.

![banner](/documentation/frontend-diagram.png)

### Back-end

Illustrates the serverless data path, including API Gateway routing, Lambda
execution, DynamoDB persistence, IAM permissions, and operational logging.

![banner](/documentation/backend-diagram.png)

### S3 Lifecycle Management

Explains how static assets transition through S3 storage classes over time to
optimize cost efficiency.

![banner](/documentation/lifecycle-diagram.png)

## Architecture Trade-Offs

This section outlines the architectural decisions considered during the build of
this project. Each option includes a high-level overview of pros and cons, with
an emphasis on scalability, cost, operational complexity, and long-term
maintenance.

### Real-Time Visitor Counter (WebSockets + DynamoDB Streams)

Pros

- True real-time updates with low latency, ideal for dashboard or live
  traffic visualization.
- DynamoDB Streams provide event-driven scalability, automatically reacting
  to counter increments.
- Removes the need for client-side polling, reducing redundant API calls and
  bandwidth.
- Works well with serverless patterns and avoids managing WebSocket servers
  yourself.

Cons

- Significantly more complex than a simple API read/write pattern.
- WebSocket APIs in API Gateway add more mental overhead.
- DynamoDB Streams increase moving parts and areas to debug.
- Higher operations cost due to active components doubling.
- Overkill for a simple visitor counter unless real-time behavior is
  essential.
- Same end effect as a simple visitor counter for the end-user.

### Using Amazon RDS Instead of DynamoDB

Pros

- Supports relational queries and SQL joins if data grows in complexity.
- Predictable query performance and transactional guarantees.
- Works well if expanding to a multi-table application later (e.g., user
  profiles, sessions).

Cons

- Far more expensive, even at small scale.
- Requires patching, backups, and maintenance windows.
- More operational overhead than DynamoDB.
- Unnecessary complexity for a simple visitor counter.

### Using a Hugo Template Instead of Hand-Crafting Your Own

Pros

- Rapid development, themes provide layouts, components, and styling out of
  the box.
- Built-in optimizations like minification, static pipelines, and SEO-ready
  structures.
- Easier long-term maintenance with clearly defined template partials.
- Simpler to scale the portfolio with additional blogs, pages, sections.

Cons

- Less creative control; customizing a theme can require learning template internals.
- Some themes can feel heavy or overly opinionated.
- Risk of relying on a theme that isn’t maintained long-term.
- For small personal sites, building by hand can feel more lightweight and minimal.

### Modular Terraform vs. a Simple Single-File Setup

Pros

- Extremely scalable; easy to grow out infrastructure without rewriting config.
- Modules keep resources logically separated by AWS Service.
- Enables reuse of patterns across new environments (dev, test, prod).
- Cleaner organization reduces misconfigurations in complex projects.

Cons

- High initial complexity; module input, outputs, and variables must be well-designed.
- Debugging can be harder when resources are in modules.
- Overkill for small-scale projects.
- Requires more documentation to ensure consistency across modules.

### Updating Hugo Console to DevPortfolio

Pros

- Modern stack (Astro + Tailwind) — faster builds and smaller bundles.
- Easier component-driven customization via `src/config.ts`.
- Better JS/tooling and deployment integration (Netlify/Vercel/Cloudflare).

Cons

- Migration work; templates, shortcodes, and content need porting.
- Terraform, GitHub, and other files must mirror changes.
- Potential loss of Hugo plugins, themes, and features.

## Blog Series

I documented every chunk on my blog:

- [Chunk 5 - The Final Write-Up](https://dev.to/tlklein/cloud-resume-challenge-chunk-5-the-final-write-up-4n06)
- [Chunk 4 - Building the Automation and CI](https://dev.to/tlklein/cloud-resume-challenge-chunk-4-building-the-automation-and-ci-3fbo)
- [Chunk 3 - Front-End & Back-End Integration](https://dev.to/tlklein/cloud-resume-challenge-chunk-3-front-end-back-end-integration-11e5)
- [Chunk 2 - Building the API](https://dev.to/tlklein/cloud-resume-challenge-chunk-2-building-the-api-4dgn)
- [Chunk 1 - Building the Front-End](https://dev.to/tlklein/cloud-resume-challenge-chunk-1-building-the-front-end-49hi)
- [Chunk 0 - Access, Credentials, and Certification Prep](https://dev.to/tlklein/cloud-resume-challenge-chunk-0-access-credentials-and-certification-prep-56db)

## Tech Stack

- **[Astro](https://astro.build/)** - Static site generator for modern web apps
- **[Tailwind CSS v4](https://tailwindcss.com/)** - Utility-first CSS framework
- **[Tabler Icons](https://tabler.io/icons)** - Free and open source icons
- **[TypeScript](https://www.typescriptlang.org/)** - For type-safe configuration
- **[AWS CLI](https://aws.amazon.com/cli/)** - For deploying to S3 and managing AWS
  resources
- **[Terraform](https://www.hashicorp.com/en)** - For IaC and cloud resource
  management

## Configuration

Configure the `config.ts` file. The template is designed to be easily
   customizable through `src/config.ts`. This file controls:

- **Personal Information**: Name, title, description
- **Accent Color**: Primary color theme (changes site-wide)
- **Social Links**: Email, LinkedIn, Twitter, GitHub (optional)
- **About Section**: Personal bio/description
- **Skills**: List of technical skills
- **Projects**: Project showcase with descriptions and links
- **Experience**: Work history with bullet points
- **Education**: Educational background and achievements

If any section is removed or empty, it will be hidden entirely.

Here's the config structure for each section:

Basic Information

```typescript
name: "Your Name",
title: "Your Job Title",
description: "Brief site description",
accentColor: "#1d4ed8", // Hex color for theme
````

Social Links

```typescript
social: {
  email: "your-email@example.com",
  linkedin: "https://linkedin.com/in/yourprofile",
  twitter: "https://twitter.com/yourprofile", 
  github: "https://github.com/yourusername",
}
```

About Section

```typescript
aboutMe: "A paragraph describing yourself, your background, interests, 
and what you're passionate about. This appears in the About section of your 
portfolio."
```

Skills Section

```typescript
skills: ["JavaScript", "React", "Node.js", "Python", "AWS", "Docker"]
```

Projects Section

```typescript
projects: [
  {
    name: "Project Name",
    description: "Brief description of what the project does and its impact",
    link: "https://github.com/yourusername/project",
    skills: ["React", "Node.js", "AWS"], // Technologies used
  }
]
```

Experience Section

```typescript
experience: [
  {
    company: "Company Name",
    title: "Your Job Title",
    dateRange: "Jan 2022 - Present",
    bullets: [
      "Led development of microservices architecture serving 1M+ users",
      "Reduced API response times by 40% through optimization",
      "Mentored team of 5 junior developers",
    ],
  }
]
```

Education Section

```typescript
education: [
  {
    school: "University Name",
    degree: "Bachelor of Science in Computer Science",
    dateRange: "2014 - 2018",
    achievements: [
      "Graduated Magna Cum Laude with 3.8 GPA",
      "Dean's List all semesters",
      "President of Computer Science Club"
    ]
  }
]
```

## Local Development

```bash
git clone https://github.com/tlklein/portfolio-website.git
cd portfolio-website
npm install
```

After that, start the Astro dev server:

```bash
npm run dev
```

or

Bypass npm using this: 

```bash
.\node_modules\.bin\astro dev
```

## File Structure

```text
  ├── .github/
  │   └── workflows/                         
  │       ├── build-and-deploy-static-site.txt   # GitHub Actions pipeline that builds Astro site & deploys to S3/CloudFront
  │       ├── code-signature-check.yml           # Verifies AWS Lambda code signatures before deployment
  │       ├── codeql-analysis.yml                # GitHub CodeQL security/static analysis for the repository
  │       ├── playwright-tests.yml               # End-to-end UI test pipeline using Playwright
  │       ├── sbom-generation.yml                # Syft-based SBOM generation for the entire stack
  │       ├── sbom-vulnerability-scan.yml        # Grype + OSV vulnerability scanning of SBOM artifacts
  │       ├── site-validation.yml                # Linting, link checking, accessibility & performance validation for site
  │       └── terraform-plan-apply.txt           # Terraform CI/CD for plan/apply with safety controls
  │
  ├── .vscode/                     
  │   ├── extensions.json                         # Recommended VS Code extensions for consistent development setup
  │   └── launch.json                             # Debugger configuration for the Lambda and Astro project
  │
  ├── bin/                     
  │   └── grype.exe                               # Locally installed Grype scanner for Windows
  │
  ├── documentation/                     
  │   ├── all-devices-black.png                   # Device mockup used for portfolio visuals
  │   ├── front-end-diagram.png                   # Front-end architecture diagram
  │   ├── back-end-diagram.png                    # Back-end Lambda/API/DynamoDB architecture diagram
  │   ├── high-level-diagram.png                  # System-level infrastructure diagram
  │   └── lifecycle-diagram.png                   # S3 lifecycle & storage-tiering diagram
  │
  ├── src/
  │   ├── components/                             # Astro UI components used across the site
  │   │   ├── About.astro                          # About section component
  │   │   ├── Education.astro                      # Education section component
  │   │   ├── Experience.astro                     # Experience/work section
  │   │   ├── Footer.astro                         # Global footer
  │   │   ├── Header.astro                         # Navigation bar/header
  │   │   ├── Hero.astro                           # Landing section with CTA + visuals
  │   │   └── Projects.astro                       # Projects section, including Cloud Resume Challenge
  │   ├── pages/
  │   │   └── index.astro                          # Main homepage/portfolio entry point
  │   ├── styles/
  │   │   └── global.css                           # Global styling for the Astro site
  │   └── config.ts                                # Astro site configuration
  │
  ├── terraform/                         
  │   ├── modules/                                 # Modular Terraform design for reusable infra components
  │   │   ├── api/                                 # Lambda, API Gateway, IAM policies, code signing resources
  │   │   │   ├── lambda/visitor-counter.zip       # Packaged Lambda artifact deployed by Terraform
  │   │   │   ├── main.tf                          # Main module logic for API + Lambda
  │   │   │   ├── output.tf                        # Outputs for use by root module
  │   │   │   └── variables.tf                     # Module inputs 
  │   │   ├── cloudfront/                          # CDN distribution for static website
  │   │   │   ├── main.tf
  │   │   │   ├── output.tf
  │   │   │   └── variables.tf
  │   │   ├── database/                            # DynamoDB table + IAM policies
  │   │   ├── dns/                                 # Route53 hosted zone + records module
  │   │   └── s3_site/                             # Static hosting bucket + lifecycle + bucket policies
  │   ├── backend.tf                               # Remote Terraform state backend configuration
  │   ├── main.tf                                  # Root module orchestrating all infrastructure modules
  │   ├── output.tf                                # Global outputs for CloudFront URL, API URL, etc.
  │   ├── provider.tf                              # AWS provider configuration
  │   ├── role.tf                                  # Helper IAM roles for deployment processes
  │   └── variables.tf                             # Root-level variables for environment, project prefix, etc.
  │
  ├── test-results/
  │   └── .last-run.json                           # Playwright test output used by GitHub Actions
  │
  ├── tests/                                      
  │   ├── test-console-errors.spec.js              # Fails build if console errors are detected
  │   ├── test-page-load.spec.js                   # Basic page load & performance tests
  │   ├── test-responsive.spec.js                  # Responsive design validation across breakpoints
  │   └── test-visitor-counter.spec.js             # Functional test validating the Lambda visitor counter API
  │
  ├── visitor-counter/
  │   └── v2_lambda_function.py                    # Source code for Lambda visitor counter
  │
  ├── .gitignore                                   # Ignore patterns for node, Terraform, Python, build outputs
  ├── astro.config.mjs                             # Astro configuration entrypoint
  ├── CHANGELOG.md                                 # Versioned release notes
  ├── grype-results.json                           # Cached vulnerability scan results
  ├── package-lock.json                            # Node package lockfile
  ├── package.json                                 # Dependencies + scripts
  ├── README.md                                    # Project overview, architecture, diagrams, setup instructions
  ├── sbom-clean.json                              # Cleaned SBOM used for OSV scanning
  ├── sbom.json                                    # Raw Syft SBOM
  └── tsconfig.json                                # TypeScript configuration                                                
```

## Future Improvements

- [x] Securing my software supply chain -
  [https://cloudresumechallenge.dev/docs/extensions/supply-chain/](https://cloudresumechallenge.dev/docs/extensions/supply-chain/)
- [x] Terraform my Cloud Resume Challenge -
  [https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/](https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/)
- [x] Architecture Diagrams, and Blog Posts
- [x] Update front-end from Hugo Console to the DevPortfolio theme

## References / Helpful Links

1. Cloud Resume Challenge Official Website -
   <https://cloudresumechallenge.dev/>
2. DevPortfolio Theme -
   <https://github.com/RyanFitzgerald/devportfolio/tree/master?tab=readme-ov-file>
3. Terraform CLI Documentation -
   <https://developer.hashicorp.com/terraform/cli/commands>
4. AWS Static Website Hosting Guide -
   <https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html>
5. Minimal AWS SSO setup for personal development -
   <https://dev.to/aws-builders/minimal-aws-sso-setup-for-personal-aws-development-220k>
6. How to sign your git commits -
   <https://endjin.com/blog/2022/12/how-to-sign-your-git-commits>
7. Playwright Debugging Docs - <https://playwright.dev/docs/debug>
8. Securing your software supply chain -
   <https://cloudresumechallenge.dev/docs/extensions/supply-chain/>
9. Terraform backend with S3 guide -
   <https://rashadansari.medium.com/setting-up-terraform-backend-with-s3-a-step-by-step-guide-4cb3e6b4685f>
