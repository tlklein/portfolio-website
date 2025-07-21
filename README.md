![banner](/static/images/all-devices-black.png)

# Trinity Klein's Cloud Resume Challenge

## Overview
Since April 2020, the Cloud Resume Challenge is designed to help people skill-up on the cloud, improve their career prospects, and land cloud jobs from non-tech fields. It has three cloud-specific editions, AWS, Azure, and Google Cloud. 

It has a detailed challenge walkthrough featuring loads of handpicked learning resources to help people level up on the cloud, programming, and DevOps skills you need. With a total of three 'megamods' (DevOps, Security, and Developer), that help build on the core challenge project with MORE hands-on practice to help people polish their skills. 

This repository contains Trinity Klein's resume and portfolio website as a part of this challenge. To view more blog posts about how to achieve these skills, or more information on her journey, please go to https://dev.to/tlklein. 

## Features
- Terminal-style using the Hugo Console Theme
- Fast, lightweight, and terminal-inspired layout and nav
- GitHub Actions CI/CD pipeline 
- Hosted on AWS using S3 and CloudFront
- Visitor counter using Lambda, API Gateway, and DynamoDB
- IaC using Terraform

<!--
## Architecture Diagrams
FIXME: ADD ARCH DIAGRAMS -->

## Prerequisites
These are assumed to be installed or exist already on your computer. It not an exhaustive list. 
1. GitHub Account
2. Git
3. Hugo
4. Node.js (for optional testing)
5. AWS CLI (if deploying to S3)
6. Terraform (if using IaC)
7. A public directory with your content

## Installation
1. Clone this repository:
```
gh repo clone tlklein/portfolio-website
```
2. Initialize the Hugo Console Theme
```
hugo mod init github.com/<your-username>/portfolio-website
hugo mod get github.com/mrmierzejewski/hugo-theme-console
```
3. Configure config.toml. 
```
baseURL = "https://your-cloudfront-url.cloudfront.net/"
title = "your-name"
theme = "github.com/mrmierzejewski/hugo-theme-console"
languageCode = "en-us"
relativeURLs = false
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

[deployment]
  [[deployment.targets]]
    name = "aws"
    URL = "s3://your-s3-bucket-name?region=your-region-num"
    cloudFrontDistributionID = "your-distribution-id"

  [[deployment.matchers]]
    pattern = "^.+\\.(js|css|svg|png|jpg|jpeg|gif|woff2?)$"
    cacheControl = "max-age=31536000, no-transform, public"
```
4. After that, you will need to configure any AWS CLI, GitHub Actions secrets and any other files need. 

## How to Run
1. To prepare my website for viewing, either in the localhost or else where, run hugo to generate a public folder.
```
hugo build
```

2. To run my website, the command hugo build with run it in the [localhost](http://localhost:1313/)
```
hugo serve
```
3. If you want to remove the whitespace, you would run hugo --minify. Please be aware that it may mess up some of the formatting though. 
```
hugo --minify
```

## File Structure
After installing, this is a guide on the files in the repository.
```
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
│       └── font/
│   └── images/
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
│   └── tv2_lambda_function.py
├── package.json
├── package-lock.json
├── go.mod
├── go.sum
├── makefile
├── .gitignore
├── config.toml
├── README.md
```

## General Troubleshooting Notes
- Ensure that your config.toml is correctly configured for your deployment needs, and is not hidden in .gitignore. 
- Ensure that you clear your CloudFront cache when you make changes
- Ensure that you configure the roles and the secrets correctly

## Future Improvements
- [ ] Terraform Your Cloud Resume Challenge - https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/
- [ ] Securing your software supply chain - https://cloudresumechallenge.dev/docs/extensions/supply-chain/

## Author
If you are following this challenge or just passing by, feel free to connect with me for explore my socials. I am happy to help you if you need anything!  
1. Email - trinitylklein@outlook.com
2. Linkedin - https://www.linkedin.com/in/trinity-klein/ 
3. Dev.to - https://dev.to/tlklein 
4. GitHub - https://github.com/tlklein/

## References and Helpful Links
1. The Cloud Resume Challenge Official Website - https://cloudresumechallenge.dev/
2. Hugo Console Theme - https://github.com/mrmierzejewski/hugo-theme-console/
3. Hugo Extended - https://gohugo.io/installation/
4. AWS Static Website Whitepapers - https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html 
5. Enrico Portolan's YouTube - https://www.youtube.com/@EnricoPortolan
6. Zhen Li's Portfolio - https://zhen404.com/posts/host-hugo-web-on-aws/ 
7. Esteban Moreno's Portfolio and Blog - https://github.com/estebanmorenoit/estebanmoreno-portfolio/ || https://blog.estebanmoreno.link/
8. Playwright - https://playwright.dev/docs/debug 
9. How to sign your git commits - https://endjin.com/blog/2022/12/how-to-sign-your-git-commits 
10. WSCAT - https://www.npmjs.com/package/wscat
11. Securing your software supply chain - https://cloudresumechallenge.dev/docs/extensions/supply-chain/
12. Terraform Your Cloud Resume Challenge - https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/
13. How to Find Your AWS Access Key ID and Secret Access Key - https://www.msp360.com/resources/blog/how-to-find-your-aws-access-key-id-and-secret-access-key/#:~:text=1%20Go%20to%20Amazon%20Web,and%20Secret%20Access%20Key 
14. Minimal AWS SSO setup for personal AWS development - https://dev.to/aws-builders/minimal-aws-sso-setup-for-personal-aws-development-220k
15. Configuring IAM Identity Center authentication with the AWS CLI - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-sso.html
16. Terraform CLI Documentation - https://developer.hashicorp.com/terraform/cli/commands 
17. Website Mockup Generator - https://websitemockupgenerator.com/ 