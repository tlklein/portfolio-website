![image](/resources/_gen/images/The%20Cloud%20Resume%20Challenge%20Graphics-2.png)

# A Recent Grad's Guide to the Cloud Resume Challenge
<!-- FIXME: ADD OVERVIEW -->

## Chunk 0 - Access, Credentials, and Certification Prep
The goal of this section is to get the AWS Certified Cloud Practitioner certification. I achieved it, you can follow the this link, https://www.credly.com/badges/9ab1424b-f346-4461-a1b7-829dc8591cd9. I am currently studying for the AWS Solution Architect exam.

Another, key achievement of this section was the proper configuration of the AWS Organizations structure. My account has 1 organization, 2 ou(one production and one testing), each ou has one user in it, along with one root user. MFA is enables on all accounts where is it necessary. More may be added in the future for development, or any other phase.

## Chunk 1 - Building the Front-End
The goal of this section is to get my resume into HTML, style it with CSS, animate it using JavaScript, and finally place into a S3 bucket and secure it using CloudFront. I used a Hugo theme called console. It is simple, minimalistic and models the look of a Linux console. It is made with website performance in mind having a load time around 55ms.

Another key achievement of this chunk is putting the code into an s3 bucket, and configuring a CloudFront distribution. The code is currently viewable here. You will also be able to see some of the multiple previous themes that were considered. My static website is configured to only be accessed through the CloudFront distribution link, with public access to the S3 bucket disabled, static hosting disabled, and an appropriate bucket policy to follow. 

## Chunk 2 - Building the API
The goal of this section is to get a visitor counter, or more accurately a hit counter on my portfolio website using DynamoDB. It has a table set, filled with the values, a lambda function, and an API gateway. The IAM roles are set up to give access to the appropriate users as needed. The api gateway interacts with the function to fetch the data from the table, and populate every time a hit is known. The API gateway to set up to show data in the footer of the website, including function that show if the data, for any reason, is not able to fetch (it will show N/A, or just be blank depending on the problem). 

Another key achievement of this chunk is to enable bucket versioning, and lifecycle policies for the S3 bucket. Also, the hit counter was refactored to become better visitor counter, that notes total visits, and unique visits. This needed a new table and values, complete with dummy data to test for production. The overall same services were used only the lambda function was overhauled, this can be seen in the visitor-counter folder. 

## Chunk 3 - Building the Front-end/Back-end Integration
The goal of this section is to smoke test the code for errors, and to integrate all of the previous code. The tests will be automated to make sure every function is working as expected. 

## Chunk 4 - Building the CI/CD Automation Pipelines
The goal of this section is to deploy the website's code using terraform. 

## Chunk 5 - Building the Blog Post, and Diagrams
The goal of this section is to write a blog post, create a architecture diagram, post it online, and get a offer! As you can see, I made the banner.

<!--FIXME: ADD ARCH DIAGRAM -->

## References - Helpful Links
1. The Cloud Resume Challenge Official Website - https://cloudresumechallenge.dev/
2. Hugo Console Theme - https://github.com/mrmierzejewski/hugo-theme-console/
3. Hugo Extended - https://gohugo.io/installation/
4. AWS Static Website Whitepapers - https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html 
5. Enrico Portolan - https://www.youtube.com/@EnricoPortolan
6. Zhen Li - https://zhen404.com/posts/host-hugo-web-on-aws/ 
7. AWS Visitor Counter using DynamoDB - https://blog.estebanmoreno.link/cloud-resume-challenge-part-2-website-visitors-counter-backed-with-api-gateway-lambda-and-dynamodb
8. The Cloud Resume Challenge Official Website - https://cloudresumechallenge.dev/
9. 