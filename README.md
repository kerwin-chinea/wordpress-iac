# WordPress Deployment on AWS EKS with Terraform and SNS Alerts

This project deploys a scalable WordPress application on **Amazon EKS (Elastic Kubernetes Service)** using **Terraform** for infrastructure automation. It integrates **Amazon SNS (Simple Notification Service)** for email notifications to monitor infrastructure health and events.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Prerequisites](#prerequisites)
4. [Setup Instructions](#setup-instructions)
5. [Features](#features)
6. [Technologies Used](#technologies-used)
7. [Troubleshooting](#troubleshooting)
8. [Future Improvements](#future-improvements)

---

## Project Overview

This deployment focuses on automating and optimizing the setup of a WordPress environment in AWS. It includes:

- **Infrastructure as Code (IaC)** using Terraform.
- **EKS Cluster** for containerized application management.
- **Amazon SNS** for sending email alerts on failures or scaling events.
- **Auto-scaling** to handle variable traffic loads efficiently.

---

## Architecture

![AWS EKS WordPress Architecture](link-to-architecture-diagram.png)

1. **Terraform** provisions the infrastructure:
   - Creates the EKS cluster.
   - Configures the worker nodes.
   - Deploys WordPress and its dependencies (MySQL).

2. **Amazon SNS** sends email alerts for:
   - High resource utilization.
   - Node or pod failures.

3. **WordPress**:
   - Runs as a containerized application.
   - Uses MySQL as the database (deployed using Helm or as an RDS instance).

---

## Prerequisites

1. **Tools**:
   - [Terraform](https://developer.hashicorp.com/terraform/downloads)
   - [AWS CLI](https://aws.amazon.com/cli/)
   - [kubectl](https://kubernetes.io/docs/tasks/tools/)
   - [Helm](https://helm.sh/docs/intro/install/)

2. **AWS Resources**:
   - An AWS account with IAM permissions to create EKS, SNS, and other related resources.
   - An AWS S3 bucket for Terraform state storage.

3. **Configure AWS CLI**:
   ```bash
   aws configure
   ```

4. **Terraform Backend**:
   - Create a remote backend in S3 for storing Terraform state.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/kerwin-chinea/wordpress-iac.git
cd wordpress-iac
```

### 2. Configure Terraform Variables

Edit the `variables.tf` file to set AWS region, VPC details, and other configurations:

```hcl
variable "region" {
  default = "us-east-1"
}

variable "eks_cluster_name" {
  default = "wordpress-eks-cluster"
}

variable "sns_email" {
  default = "your-email@example.com"
}
```

### 3. Initialize and Apply Terraform

1. Initialize the Terraform project:
   ```bash
   terraform init
   ```

2. Plan the deployment:
   ```bash
   terraform plan
   ```

3. Apply the configuration:
   ```bash
   terraform apply
   ```

### 4. Configure `kubectl` for EKS

Get the kubeconfig to access your EKS cluster:

```bash
aws eks update-kubeconfig --region <your-region> --name wordpress-eks-cluster
```

Verify cluster access:
```bash
kubectl get nodes
```

### 5. Deploy WordPress Using Helm

Install WordPress using Helm:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install wordpress bitnami/wordpress --namespace wordpress --create-namespace
```

### 6. Configure SNS Notifications

Terraform automatically creates an SNS topic. Confirm your email subscription using the link sent to your inbox.

---

## Features

- **Scalable Infrastructure**:
  - WordPress runs on an EKS cluster with auto-scaling configurations.
- **Cost Optimization**:
  - Auto-scaling minimizes fixed costs for variable workloads.
- **Monitoring and Alerts**:
  - Amazon SNS notifies you of infrastructure or application issues.
- **Security**:
  - EKS nodes are deployed in private subnets.
  - IAM roles are configured for least privilege access.

---

## Technologies Used

- **Terraform**: Infrastructure as Code.
- **AWS**: Managed services (EKS, SNS, RDS, etc.).
- **Kubernetes**: Orchestration for WordPress and MySQL.
- **Helm**: Simplifies Kubernetes application deployment.
- **Amazon SNS**: Notification service for alerting.

---

## Troubleshooting

1. **No Email Alerts**:
   - Check SNS subscriptions in the AWS Management Console.
   - Ensure the email is verified.

2. **EKS Cluster Unreachable**:
   - Verify the kubeconfig setup.
   - Check AWS IAM role permissions.

3. **Terraform Issues**:
   - Ensure Terraform is initialized correctly.
   - Check the remote state backend configuration.

---

## Future Improvements

- Implement AWS RDS for a managed MySQL database.
- Integrate Prometheus and Grafana for detailed monitoring.
- Configure AWS WAF (Web Application Firewall) for enhanced security.
- Automate Helm deployments through Terraform `helm_release` resources.

---
