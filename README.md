
<!--FIXME: ADD ARCH DIAGRAM & BANNER-->

# A RECENT GRAD'S GUIDE TO THE CLOUD RESUME CHALLENGE

## CHUNK 0 - Access, Credentials, and Certification Prep
The goal of this section is to get the AWS Certified Cloud Practitioner certification. I achieved it. Follow the this link, https://www.credly.com/badges/9ab1424b-f346-4461-a1b7-829dc8591cd9. 

Another, key achievement of this section was the proper configuration of the AWS Organizations structure. My account has 1 organization, 2 ou(one production and one testing), each ou has one user in it, along with one root user. MFA is enables on all accounts where is it necessary.

## CHUNK 1 - Building the Front-End
The goal of this section is to get my resume into HTML, style it with CSS, animate it using JavaScript, and finally place into a S3 bucket and secure it using CloudFront. I used a Hugo theme called console. It is simple, minimalistic and models the look of a Linux console. It is made with website performance in mind having a load time around 55ms.

Another key achievement of this chunk is putting the code into an s3 bucket, and configuring a CloudFront distribution. The code is currently viewable into a GitHub repository, at https://github.com/tlklein/portfolio-website. You will also be able to see some of the previous themes that were considered. 

## CHUNK 2 - Building the API
The goal of this section is to get a visitor counter, or more accurately a hit counter on my portfolio website using a database that is not DynamoDB, and is applicable to the AWS Free-Tier requirements. 

## CHUNK 3 - Building the Front-end/Back-end Integration

## CHUNK 4 - Building the CI/CD Automation Pipelines

## CHUNK 5 - Building the Blog Post, and Architectures Diagrams

# References  
1. Hugo Console Theme - https://github.com/mrmierzejewski/hugo-theme-console/
2. Hugo Extended - https://gohugo.io/installation/
3. AWS Static Website Whitepapers - https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html 
4. Zhen Li - https://zhen404.com/posts/host-hugo-web-on-aws/ 
5. Serverless MySQL Module - https://github.com/jeremydaly/serverless-mysql 
6. AWS Visitor Counter using DynamoDB - https://github.com/kuzeyardabulut/aws-visitor-counter