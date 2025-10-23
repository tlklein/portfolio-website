# Cloud Resume Challenge

![banner](/documentation/all-devices-black.png)

Welcome! This repo documents my Cloud Resume Challenge, a hands-on project
where I combined **AWS services, Infrastructure-as-Code CI/CD, and DevOps
practices** into a single portfolio project. For more information about the
final architecture, achievements, and lessons learned, head over to my
[Dev.to blog series](#blog-series)

## Final Product

- **Live Cloud Resume:** [View Here](https://www.trinityklein.dev/)

## Blog Series

I documented every chunk on my blog:

- Chunk 5 - The Final Write-Up
- Chunk 4 - Building the Automation and CI
- [Chunk 3 - Front-End & Back-End Integration](https://dev.to/tlklein/cloud-resume-challenge-chunk-3-front-end-back-end-integration-11e5)
- [Chunk 2 - Building the API](https://dev.to/tlklein/cloud-resume-challenge-chunk-2-building-the-api-4dgn)
- [Chunk 1 - Building the Front-End](https://dev.to/tlklein/cloud-resume-challenge-chunk-1-building-the-front-end-49hi)
- [Chunk 0 - Access, Credentials, and Certification Prep](https://dev.to/tlklein/cloud-resume-challenge-chunk-0-access-credentials-and-certification-prep-56db)

## Features & Achievements

- Terminal-style using the Hugo Console Theme
- Fast, lightweight, and terminal-inspired layout and nav
- Hosted on an S3 bucket and CloudFront
- AWS Organization with 1 Org, 2 OUs (Prod & Test), all accounts
  MFA-protected.
- Visitor counter with DynamoDB, Lambda, API Gateway (total + unique
  visits).
- GitHub Actions CI/CD pipeline setup as follows: GitHub Actions → build
  Hugo, sync to S3, invalidate CloudFront, run Playwright tests.
- Infra-as-code setup using Terraform for repeatability and version
  control.
- Implemented Supply Chain Security using OIDC instead of long-term keys,
  lifecycle policies, least-privilege IAM.

## Architecture Diagrams

Here is a look at the architecture:

### High-level

![banner](/documentation/high-level-diagram.png)

### Front-end

![banner](/documentation/frontend-diagram.png)

### Back-end

![banner](/documentation/backend-diagram.png)

### S3 Lifecycle Management

![banner](/documentation/lifecycle-diagram.png)

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
  │       └── build-and-deploy-static-site.yml
  ├── layouts/
  │   └── _default/
  │       └── baseof.html
  │       └── list.html
  │       └── single.html
  │   └── partials/
  │       └── favicon.html
  │       └── footer.html
  │       └── header.html
  │   └── 404.html
  │   └── index.html
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
  │       └── The-Cloud-Resume-Challenge-Graphics-4.png
  │       └── The-Cloud-Resume-Challenge-Graphics-8.png
  │       └── The-Cloud-Resume-Challenge-Graphics-10.png
  │       └── The-Cloud-Resume-Challenge-Graphics-12.png
  │       └── The-Cloud-Resume-Challenge-Graphics-14.png
  │   └── resume.html
  │   └── ping.html
  │   └── posts.html
  │   └── projects.html
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
  ├── package.json
  ├── package-lock.json
  ├── go.mod
  ├── go.sum
  ├── makefile
  ├── .gitignore
  ├── config.toml
  ├── README.md
  ```

## Future Improvements

- [x] Terraform Your Cloud Resume Challenge -
  <https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/>
- [ ] Securing your software supply chain -
  <https://cloudresumechallenge.dev/docs/extensions/supply-chain/>
- [x] Architecture Diagrams, and Blog Posts

## Let's Connect

If you're following this challenge, or just passing by, feel free to connect
with me and explore my socials. I'm always happy to help if you need
anything! I'm also open to new opportunities, If you have inquiries for me,
let me know!

- [LinkedIn](https://linkedin.com/in/trinity-klein/)
- [GitHub](https://github.com/tlklein)
- [Dev.to Blog](https://dev.to/tlklein)
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
24. "no matching Route53Zone found": Terraform's 
    Route53 data source is not recognizing the hosted zone name
    <https://stackoverflow.com/questions/41631966/no-matching-route53zone-found-terraforms-route53-data-source-is-not-recogniz>

---

If you found this project helpful, feel free to star the repo!
