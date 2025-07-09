![image](/static/images/The-Cloud-Resume-Challenge-Graphics-2.png)

<!--FIXME: ADD ARCH DIAGRAMS -->

# A Recent Grad's Guide to the Cloud Resume Challenge
Since April 2020, the Cloud Resume Challenge is designed to help people skill-up on the cloud, improve their career prospects, and land cloud jobs from non-tech fields. It has three cloud-specific editions, AWS, Azure, and Google Cloud. 

It has a detailed challenge walkthrough featuring loads of handpicked learning resources to help people level up on the cloud, programming, and DevOps skills you need. With a total of three 'megamods' (DevOps, Security, and Developer), that help build on the core challenge project with MORE hands-on practice to help people polish their skills. 

## Chunk 0 - Access, Credentials, and Certification Prep
The goal of this section is to get the AWS Certified Cloud Practitioner certification. I achieved it, you can follow the this link, https://www.credly.com/badges/9ab1424b-f346-4461-a1b7-829dc8591cd9. I am currently studying for the AWS Solution Architect exam.

Another, key achievement of this section was the proper configuration of the AWS Organizations structure. My account has 1 organization, 2 ou(one production and one testing), each ou has one user in it, along with one root user. MFA is enables on all accounts where is it necessary. More may be added in the future for development, or any other phase.

## Chunk 1 - Building the Front-End
The goal of this section is to get my resume into HTML, style it with CSS, animate it using JavaScript, and finally place into a S3 bucket and secure it using CloudFront. I used a Hugo theme called console. It is simple, minimalistic and models the look of a Linux console. It is made with website performance in mind having a load time around 55ms.

Another key achievement of this chunk is putting the code into an s3 bucket, and configuring a CloudFront distribution. The code is currently viewable here. You will also be able to see some of the multiple previous themes that were considered. My static website is configured to only be accessed through the CloudFront distribution link, with public access to the S3 bucket disabled, static hosting disabled, and an appropriate bucket policy to follow. 

## Chunk 2 - Building the API
The goal of this section is to get a visitor counter, or more accurately a hit counter on my portfolio website using DynamoDB. It has a table set, filled with the values, a lambda function, and an API gateway. The IAM roles are set up to give access to the appropriate users as needed. The api gateway interacts with the function to fetch the data from the table, and populate every time a hit is known. The API gateway to set up to show data in the footer of the website, including function that show if the data, for any reason, is not able to fetch (it will show 'Loading...' if no count can be sent). 

Another key achievement of this chunk is to enable bucket versioning, and lifecycle policies for the S3 bucket. Also, the hit counter was refactored to become better visitor counter, that notes total visits, and unique visits. This needed a new table and values, complete with dummy data to test for production. The overall same services were used only the lambda function was overhauled, this can be seen in the visitor-counter folder. 

One thing I want to note is that I did consider a real-time visitor counter using a Web Socket gateway and DynamoDB Streams instead of a REST Api.  Doing this would not only be more expensive to scale, but significantly more complicated to set-up/optimize, and ultimately having the same effect to the end customer, therefore, I went with the REST Api instead.

## Chunk 3 - Building the Front-end/Back-end Integration
The goal of this section is to smoke test the code for errors, and to integrate all of the previous code. The tests will be automated to make sure every function is working as expected. The tests were completed using playwright. The tests scripts can be seen in the tests folder.  I ran the scripts multiple times as needed. According to the original challenge, refactoring the Api to count hits was supposed to done in this section, but I did it all in Chunk 3. 

## Chunk 4 - Building the CI/CD Automation Pipelines
The goal of this section is to deploy the website's code using only terraform. 

## Chunk 5 - Building the Blog Post, and Diagrams
The goal of this section is to write a blog post, create a architecture diagram, post it online, and get a offer! As you can see, I made the banner already!

<!--FIXME: ADD ARCH DIAGRAMS -->

## Feel Free to Connect with Me!
If you are following this challenge or just passing by, feel free to connect with me for explore my socials. I am happy to help you if you need anything. 
1. Linkedin - https://www.linkedin.com/in/trinity-klein/ 
2. Dev.to - https://dev.to/tlklein 
3. GitHub - https://github.com/tlklein/

## References - Helpful Links
1. The Cloud Resume Challenge Official Website - https://cloudresumechallenge.dev/
2. Hugo Console Theme - https://github.com/mrmierzejewski/hugo-theme-console/
3. Hugo Extended - https://gohugo.io/installation/
4. AWS Static Website Whitepapers - https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html 
5. Enrico Portolan - https://www.youtube.com/@EnricoPortolan
6. Zhen Li - https://zhen404.com/posts/host-hugo-web-on-aws/ 
7. AWS Visitor Counter using DynamoDB - https://blog.estebanmoreno.link/cloud-resume-challenge-part-2-website-visitors-counter-backed-with-api-gateway-lambda-and-dynamodb
8. The Cloud Resume Challenge Official Website - https://cloudresumechallenge.dev/
9. Playwright - https://playwright.dev/docs/debug 
10. How to sign your git commits - https://endjin.com/blog/2022/12/how-to-sign-your-git-commits 
11. Realtime communication using API Gateway (Websockets), DynamoDB, and AWS Lambda - https://mychewcents.medium.com/realtime-communication-using-api-gateway-websockets-dynamodb-and-aws-lambda-c912349474f9
12. WSCAT -https://www.npmjs.com/package/wscat
13. Securing your software supply chain - https://cloudresumechallenge.dev/docs/extensions/supply-chain/
14. Terraform Your Cloud Resume Challenge - https://cloudresumechallenge.dev/docs/extensions/terraform-getting-started/
