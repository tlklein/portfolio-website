# Cloud Resume Challenge

![banner](/documentation/all-devices-black.png)

Welcome! This repo documents my Cloud Resume Challenge,
a hands-on project where I combined AWS services
Infrastructure-as-Code CI/CD, and DevOps practices
into a single portfolio project.

## Table of contents

- [Final Product](#final-product)
- [TL;DR](#tldr)
- [Architecture Overview](#architecture-overview)
- [Architecture Diagrams](#architecture-diagrams)
- [Architecture Trade-Offs](#architecture-trade-offs)
- [Blog Series](#blog-series)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [How to Run](#how-to-run)
- [File Structure](#file-structure)
- [Future Improvements](#future-improvements)
- [Let's Connect](#lets-connect)
- [References / Helpful Links](#references--helpful-links)

## Final Product

- Live Cloud Resume: [View Here](https://www.trinityklein.dev/)

## TL;DR

- Hugo front-end using the Console theme, optimized for
performance (<500ms load).  
- Multi-account AWS Organization setup: Production + Test OUs,
MFA enabled.  
- Backend visitor counter using Lambda + API Gateway + DynamoDB.  
- Infrastructure managed via Terraform 1.6+ with modularized
resources.  
- CI/CD with GitHub Actions + Playwright, secured with OIDC and
least-privilege IAM.  

## Architecture Overview

- Terminal-style front-end using the Hugo Console theme:
  - Minimal and responsive layout inspired by a system console.
  - Built with Hugo for ~500ms load times.
- Static hosting using S3 and CloudFront:
  - Static assets stored in an S3 bucket with public access
  disabled and static website hosting turned off.
  - Files served only via CloudFront OAC and a bucket policy.
  - Bucket hardening using versioning, server-side encryption
  (AES256), lifecycle rules to transition noncurrent objects to
  lower-cost classes, and `force_destroy = false` to avoid
  accidental mass deletes.
- Infrastructure as Code using Terraform:
  - All cloud resources (S3, CloudFront, ACM, Route53, DynamoDB,
  Lambda, API Gateway, and IAM roles/policies) are defined in
  Terraform modules for repeatable deployments.
  - State stored remotely in S3 and DynamoDB. 3
- Account structure & hardening using AWS Organizations:
  - 1 Organization with 2 OUs: `production` and `test`, each OU
  has dedicated user accounts for environment separation.
  - Root account exists but is locked down; MFA enabled on all
  accounts.
  - Billing alert configured to notify on very small thresholds
  (> $0.01) to catch accidental spending.
- Visitor analytics using serverless and NoSQL:
  - DynamoDB table track visits.
  - AWS Lambda implements the hit/visitor logic logging total and
  unique visits.
  - API Gateway (HTTP) fronts the Lambda and exposes a
  lightweight endpoint used by the resume footer to show counts,
  with graceful fallback. It will show `Loading...` if API is
  unreachable.
- CI/CD, smoke testing using GitHub Actions and Playwright:
  - Workflow builds the Hugo site, uploads a build artifact,
  syncs to S3, invalidates CloudFront, and runs Playwright smoke
  tests.
  - Deployments were performed primarily via terminal in the AWS
  CLI to keep tight control during development; GitHub
  Actions is configured for code validation on all branches, and
  only Terraform plan and apply on main branch.
- Supply-chain and credential security:
  - GitHub Actions uses OIDC and short-lived roles with no
  long-term secrets to assume a deploy role in AWS.
  - Principle of least privilege applied to IAM policies;
  deployment and runtime roles are scoped narrowly.
  - Artifacts and objects use lifecycle policies and versioning
  to support rollback and forensic analysis.

## Architecture Diagrams

These the are the set of diagrams that illustrate the system from multiple perspectives. These visuals help clarify how the application is structured end-to-end, from the user-facing front-end, to the serverless back-end, all the way down to how S3 objects are managed over time.

### High-level

Provides a system-wide overview showing CloudFront, API Gateway, Lambda, DynamoDB, S3, and supporting services

![banner](/documentation/high-level-diagram.png)


### Front-end

Shows how the static website is delivered from S3 through CloudFront and how client-side logic interacts with the API.

![banner](/documentation/frontend-diagram.png)

### Back-end

Illustrates the serverless data path, including API Gateway routing, Lambda execution, DynamoDB persistence, IAM permissions, and operational logging.

![banner](/documentation/backend-diagram.png)

### S3 Lifecycle Management

Explains how static assets transition through S3 storage classes over time to optimize cost efficiency.

![banner](/documentation/lifecycle-diagram.png)

## Architecture Trade-Offs

This section outlines the architectural decisions considered during the build of this project. This section outlines the architectural decisions considered during the build of this project. Each option includes a high-level overview of pros and cons, with an emphasis on scalability, cost, operational complexity, and long-term maintenance.

### Real-Time Visitor Counter (WebSockets + DynamoDB Streams)

#### Pros

- True real-time updates with low latency, ideal for dashboard or live traffic visualization 
- DynamoDB Streams provide event-driven scalability, automatically reacting to counter increments.
- Removes the need for client-side polling, reducing redundant API calls and bandwidth
- Works well with serverless patterns and avoids managing WebSocket servers yourself.

#### Cons

- Significantly more complex than a simple API read/write pattern. 
- WebSocket APIs in API Gateway for significantly more complex and add more mental overhead. 
- DynamoDB Streams double the moving parts and areas to debug.
- Higher operations cost than a base counter due to the active components doubling. 
- Overkill over a simple visitor counter, unless real-time behavior is essential. 
- Same end effect as a simple visitor counter for the end-user

### Using Amazon RDS Instead of DynamoDB

#### Pros

- Supports relational queries and SQL joins, if the data grows in complexity
- Offers predictable query performance and transactional guarantees.
- Works well if expanding to a multi-table application later (e.g., user profiles, sessions, etc.).

#### Cons

- Far more expensive, even at a small scale, and requires continuous uptime and storage.
- Requires patching, backups, maintenance windows.
- More operational overhead than DynamoDB
- Unnecessary complexity for a simple visitor counter, that only requires fast read/writes to a single record. 

### Using a Hugo Template Instead of Hand-Crafting Your Own

#### Pros

- Rapid development, themes provide layouts, components, and styling out of the box.
- Built-in optimizations, like minification, static pipelines, and SEO-ready structures.
- Easier long-term maintenance with clearly defined template partials and content organization.
- Simpler to scale the portfolio with additional blogs, pages, sections.

#### Cons

- Less creative control; customizing a theme can require learning the template’s internals.
- Some themes can feel heavy or overly opinionated, adding features you don’t need.
- Risk of relying on a theme that isn’t maintained long-term.
- For small personal sites, building by hand can feel more lightweight and minimal.

### Modular Terraform vs. a Simple Single-File Setup

#### Pros
- Extremely scalable, easy to grow out my infrastructure without having to rewrite configuration. 
- Modules keep resources logically separated by AWS Service. 
- Enables reuse of the same patterns that can be applied to new environments (dev, test and prod). 
- Cleaner organization reduces the chance of misconfigurations in more complex projects.

#### Cons
- High initial complexity, module input, outputs, and variables must all be well-designed. 
- Debugging can be harder when resources are in modules.
- Overkill for a small-scale project.
- Requires more documentation to ensure consistency across modules.

## Blog Series

I documented every chunk on my blog:

- [Chunk 5 - The Final Write-Up](https://dev.to/tlklein/cloud-resume-challenge-chunk-5-the-final-write-up-4n06)
- [Chunk 4 - Building the Automation and CI](https://dev.to/tlklein/cloud-resume-challenge-chunk-4-building-the-automation-and-ci-3fbo)
- [Chunk 3 - Front-End & Back-End Integration](https://dev.to/tlklein/cloud-resume-challenge-chunk-3-front-end-back-end-integration-11e5)
- [Chunk 2 - Building the API](https://dev.to/tlklein/cloud-resume-challenge-chunk-2-building-the-api-4dgn)
- [Chunk 1 - Building the Front-End](https://dev.to/tlklein/cloud-resume-challenge-chunk-1-building-the-front-end-49hi)
- [Chunk 0 - Access, Credentials, and Certification Prep](https://dev.to/tlklein/cloud-resume-challenge-chunk-0-access-credentials-and-certification-prep-56db)

## Prerequisites

These are assumed to be installed or exist already on your computer. It not
an complete list.

1. GitHub Account - Required to store code and trigger GitHub Actions
2. Git - For version control and managing the repository
3. Hugo Extend Edition - To build the static site
   (<https://gohugo.io/installation/>)
4. Node.js - For running Playwright tests or any other tools
5. AWS CLI - If deploying to an S3 bucket and managing AWS resources
   manually
6. Terraform - If using IaC (Infrastructure as code)
7. A public directory with your content - Your generated site content from
   'hugo build'.

## Installation

- Clone this repository.

  ```bash
  gh repo clone tlklein/portfolio-website
  ```

- Initialize the Hugo Console Theme. Then declare the Console theme module
  as a dependency.

  ```bash
  hugo mod init github.com/your-username/your-repo-site
  hugo mod get github.com/mrmierzejewski/hugo-theme-console
  ```

- Configure config.toml. This is an example.

  ```config.toml
  baseURL = "https://your-cloudfront-url.cloudfront.net/"
  title = "your-name"
  theme = "github.com/mrmierzejewski/hugo-theme-console"
  languageCode = "en-us"
  relativeURLs = true
  canonifyURLs = true

  [params]
    titleCutting = true
    animateStyle = "animated zoomIn fast"

    [[params.navlinks]]
    name = "blogs/"
    url = "/posts.html"

    [[params.navlinks]]
    name = "projects/"
    url = "/projects.html"

    [[params.navlinks]]
    name = "resume/"
    url = "/resume.html"
    
    [[params.navlinks]]
    name = "contact/"
    url = "/ping.html"

    favicon = "favicon.ico"

  [deployment]
    [[deployment.targets]]
      name = "aws"
      URL = "s3://your-s3-bucket-name?region=your-region-num"
      cloudFrontDistributionID = "your-distribution-id"

    [[deployment.matchers]]
      pattern = "^.+\\.(js|css|svg|png|jpg|jpeg|gif|woff2?)$"
      cacheControl = "max-age=31536000, no-transform, public"
      
    [taxonomies]
  ```

- After that, you will need to configure any AWS CLI, GitHub Actions
  secrets and any other files need.

## How to Run

- To prepare my website for viewing, either in the localhost or else where,
  run hugo to generate a public folder.

  ```bash
  hugo 
  ```

- To run my website, the command hugo serve with run it in the
  [localhost](http://localhost:1313/)

  ```bash
  hugo serve
  ```

- If you want to remove the whitespace, you would run hugo --minify. Please
  be aware that it may mess up some of the formatting though.

  ```bash
  hugo --minify
  ```

## File Structure

After installing, this is a guide on the files in the repository.

  ```text
  ├── .github/
  │   └── workflows/
  │       └── build-and-deploy-static-site.txt
  │       └── code-validation.txt
  │       └── site-quality.txt
  │       └── terraform-plan-apply.txt
  ├── layouts/
  │   └── _default/
  │       └── baseof.html
  │       └── list.html
  │       └── single.html
  │   └── partials/
  │       └── favicon.html
  │       └── footer.html
  │       └── header.html
  │       └── twitter_cards.html
  │       └── opengraph.html
  │   └── 404.html
  │   └── index.html
  │   └── index.xml
  │   └── sitemap.xml
  ├── static/ 
  │   └── hugo-theme-console/
  │       └── css/
  │           └── animate-4.1.1.min.css
  │           └── console.css
  │           └── terminal-0.7.4.min.css
  │       └── font/
  │           └── RobotoMono-Bold.ttf
  │           └── RobotoMono-BoldItalic.ttf
  │           └── RobotoMono-Italic.ttf
  │           └── RobotoMono-Regular.ttf
  │   └── images/
  │       └── The-Cloud-Resume-Challenge-Graphics-2.png
  │       └── The-Cloud-Resume-Challenge-Graphics-4.png
  │       └── The-Cloud-Resume-Challenge-Graphics-6.png
  │       └── The-Cloud-Resume-Challenge-Graphics-8.png
  │       └── The-Cloud-Resume-Challenge-Graphics-10.png
  │       └── The-Cloud-Resume-Challenge-Graphics-12.png
  │   └── favicon.ico
  │   └── resume.html
  │   └── ping.html
  │   └── posts.html
  │   └── projects.html
  │   └── trinity-klein-resume.pdf
  ├── test-results/
  │   └── .last-run.json
  ├── tests/
  │   └── test-console-errors.spec.js
  │   └── test-page-load.spec.js
  │   └── test-responsive.spec.js
  │   └── test-visitor-counter.spec.js
  ├── visitor-counter/
  │   └── v2_lambda_function.py
  ├── documentation/
  │   └── all-devices-black.png
  │   └── front-end-diagram.png
  │   └── back-end-diagram.png
  │   └── high-level-diagram.png
  │   └── lifecycle-diagram.png
  ├── terraform/
  │   └── modules/
  │      └── api/
  |          └── lambda/
  │               └── visitor-counter.zip
  │          └── main.tf
  │          └── output.tf
  │          └── variables.tf
  │      └── cloudfront/
  │          └── main.tf
  │          └── output.tf
  │          └── variables.tf
  │      └── database/
  │          └── main.tf
  │          └── output.tf
  │          └── variables.tf
  │      └── dns/
  │          └── main.tf
  │          └── output.tf
  │          └── variables.tf
  │      └── s3_site/
  │          └── main.tf
  │          └── policies.tf
  │          └── output.tf
  │          └── variables.tf
  │   └── backend.tf
  │   └── main.tf
  │   └── output.tf
  │   └── provider.tf
  │   └── role.tf
  │   └── variables.tf
  │   └── versions.tf
  ├── .htmlvalidate.json
  ├── .htmlvalidateignore
  ├── package.json
  ├── package-lock.json
  ├── go.mod
  ├── go.sum
  ├── makefile
  ├── .gitignore
  ├── config.toml
  ├── grype-results.json
  ├── sbom-clean.json
  ├── sbom.json
  ├── README.md
  ```

## Future Improvements

- [x] Securing your software supply chain -
  <https://cloudresumechallenge.dev/docs/extensions/supply-chain/>
- [x] Terraform Your Cloud Resume Challenge -
  <https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/>
- [x] Architecture Diagrams, and Blog Posts

## Let's Connect

If you're following this challenge, or just passing by, feel free to connect
with me and explore my socials. I'm always happy to help if you need
anything! I'm also open to new opportunities, If you have inquiries for me,
let me know!

- [LinkedIn](https://linkedin.com/in/trinity-klein/)
- [GitHub](https://github.com/tlklein)
- [Dev.to Blog](https://dev.to/tlklein)
- [Portfolio](https://www.trinityklein.dev/)
- Email Address: <tlklein05@gmail.com>

## References / Helpful Links

1. The Cloud Resume Challenge Official Website -
   <https://cloudresumechallenge.dev/>
2. Hugo Console Theme -
   <https://github.com/mrmierzejewski/hugo-theme-console/>
3. Hugo Extended - <https://gohugo.io/installation/>
4. AWS Static Website Whitepapers -
   <https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html>
5. Enrico Portolan's YouTube - <https://www.youtube.com/@EnricoPortolan>
6. Zhen Li's Portfolio -
   <https://zhen404.com/posts/host-hugo-web-on-aws/>
7. Esteban Moreno's Portfolio and Blog -
   <https://github.com/estebanmorenoit/estebanmoreno-portfolio/> ||
   <https://blog.estebanmoreno.link/>
8. Playwright - <https://playwright.dev/docs/debug>
9. How to sign your git commits -
   <https://endjin.com/blog/2022/12/how-to-sign-your-git-commits>
10. WSCAT - <https://www.npmjs.com/package/wscat>
11. Securing your software supply chain -
    <https://cloudresumechallenge.dev/docs/extensions/supply-chain/>
12. Terraform Your Cloud Resume Challenge -
    <https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/>
13. How to Find Your AWS Access Key ID and Secret Access Key -
    <https://www.msp360.com/resources/blog/how-to-find-your-aws-access-key-id-and-secret-access-key/#:~:text=1%20Go%20to%20Amazon%20Web,and%20Secret%20Access%20Key>
14. Minimal AWS SSO setup for personal AWS development -
    <https://dev.to/aws-builders/minimal-aws-sso-setup-for-personal-aws-development-220k>
15. Configuring IAM Identity Center authentication with the AWS CLI -
    <https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html>
16. Terraform CLI Documentation -
    <https://developer.hashicorp.com/terraform/cli/commands>
17. Website Mockup Generator - <https://websitemockupgenerator.com/>
18. Setting Up Terraform Backend with S3: A Step-by-Step Guide -
    <https://rashadansari.medium.com/setting-up-terraform-backend-with-s3-a-step-by-step-guide-4cb3e6b4685f>
19. Error acquiring the state lock: ConditionalCheckFailedException -
    <https://stackoverflow.com/questions/62189825/error-acquiring-the-state-lock-conditionalcheckfailedexception>
20. Syft - <https://github.com/anchore/syft>
21. How to buy domain from Namecheap, connect to AWS Route 53 and attach
    AWS Certificate Manager -
    <https://celestina.hashnode.dev/how-to-buy-domain-from-namecheap-connect-to-aws-route-53-and-attach-aws-certificate-manager>
22. How to fix-Terraform Error acquiring the state lock
    ConditionalCheckFiledException? -
    <https://jhooq.com/terraform-conidtional-check-failed/>
23. Terraform State Lock Errors: Emergency Solutions &
    Prevention Guide -
    <https://scalr.com/learning-center/terraform-state-lock-errors-emergency-solutions-prevention-guide/>

---

If you found this project helpful, feel free to star the repo!
