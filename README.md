# Terraform AWS Cloudfront CDN Example

Studies based in day 85-86 of 100 Days System Design for DevOps and Cloud Engineers.

https://deoshankar.medium.com/100-days-system-design-for-devops-and-cloud-engineers-18af7a80bc6f

Days 81–90: Advanced Networking and Content Delivery

Day 85–86: Configure advanced CDN strategies for dynamic content using AWS CloudFront and Lambda@Edge.

## Project Overview

This project demonstrates how to configure advanced Content Delivery Network (CDN) strategies for dynamic content using AWS CloudFront and Lambda@Edge with Terraform. 

The goal is to use CloudFront to distribute and cache content globally while adding dynamic header modifications and optimizing content delivery for a FastAPI application hosted on an AWS EC2 instance.

The project covers:

* Setting up an EC2 instance with a FastAPI application.
* Deploying a CloudFront distribution for the EC2 instance.
* Configuring custom headers using CloudFront's built-in capabilities, eliminating the need for Lambda@Edge.
* Demonstrating the power of CloudFront for serving static assets and handling dynamic content efficiently.

## How to Use

### Prerequisites

* Terraform installed locally.
* An AWS account with the necessary permissions to create resources (EC2, CloudFront, IAM roles, etc.).
* A key pair for SSH access to the EC2 instance.

### Steps

1. Clone the repository.

2. Modify the Terraform Configuration

* Update the main.tf file to replace placeholders such as ```your-key-pair-name```, ```subnet-your-subnet-id```, and ```vpc-your-vpc-id``` with appropriate values for your AWS environment (or use TFVARS).

3. Initialize, Plan and Apply Terraform Configuration
```
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

4. Access the CloudFront Distribution

* Once the deployment is complete, navigate to the CloudFront distribution URL provided in the Terraform output. You should see your FastAPI application content delivered through CloudFront.

5. Testing Custom Headers

* Use curl or a web browser to inspect the response headers. Custom headers configured via CloudFront should be visible in the response.

### Cleanup

To remove all the resources created by this project:
```
terraform destroy
```

## Author
This project was implemented by [Lucas de Queiroz dos Reis][2]. It is based on the [100 Days System Design for DevOps and Cloud Engineers][1].

[1]: https://deoshankar.medium.com/100-days-system-design-for-devops-and-cloud-engineers-18af7a80bc6f "Medium - Deo Shankar 100 Days"
[2]: https://www.linkedin.com/in/lucas-de-queiroz/ "LinkedIn - Lucas de Queiroz"