# 🚀 Node.js DevOps Project — Docker, Compose, CI & Terraform

A hands-on DevOps project demonstrating how to containerize a Node.js application, manage multiple services with Docker Compose, enable development hot reload, connect the application to MongoDB, configure Nginx, automate the build process using GitHub Actions, and define AWS infrastructure using Terraform.

---

## 📌 Project Overview

This project was created as a practical implementation of core DevOps concepts using a simple Node.js application.

The project gradually evolves from running a Node.js application locally to preparing a deployment-ready environment with:

* Node.js application
* MongoDB database
* Nginx reverse proxy
* Docker & Docker Compose
* Development hot reload
* GitHub Actions CI
* Terraform Infrastructure as Code (IaC)
* AWS infrastructure configuration

The main goal is to understand how these technologies work together in a real-world DevOps workflow.

---

## 🛠️ Technologies Used

* **Node.js**
* **Express.js**
* **MongoDB**
* **Mongoose**
* **Docker**
* **Docker Compose**
* **Nginx**
* **Git & GitHub**
* **GitHub Actions**
* **Terraform**
* **AWS**

---

## 🏗️ Project Architecture

The project is designed as a gradual DevOps workflow, starting from application containerization and extending toward cloud infrastructure.

```text
                         👨‍💻 Developer
                              │
                              │ git push
                              ▼
                       ┌───────────────┐
                       │    GitHub     │
                       │   Repository  │
                       └───────┬───────┘
                               │
                               │ GitHub Actions
                               ▼
                       ┌───────────────┐
                       │ GitHub Runner │
                       └───────┬───────┘
                               │
                               │ CI
                               ▼
                    ┌────────────────────────┐
                    │     Docker Image       │
                    │     Node.js App        │
                    └────────────────────────┘


              Infrastructure as Code
                         │
                         ▼
                    ┌───────────┐
                    │ Terraform │
                    └─────┬─────┘
                          │
                          ▼
                 ┌──────────────────┐
                 │       AWS        │
                 │                  │
                 │ VPC              │
                 │ Subnet           │
                 │ Internet Gateway │
                 │ Route Table      │
                 │ Security Group   │
                 │ EC2              │
                 └──────────────────┘
```

> **Note:** The AWS infrastructure is currently defined using Terraform configuration. It has not been provisioned on AWS yet because no AWS credentials/account were used for the deployment phase.

---

## 🔄 DevOps Workflow

The project is being developed in stages:

```text
Developer
    │
    │ git push
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ├── Install dependencies
    ├── Run CI checks
    └── Build Docker image
            │
            ▼
       Docker Image
            │
            │
            ▼
      Future AWS Deployment
            │
            ▼
        Amazon ECR
            │
            │ pull
            ▼
       AWS EC2 Instance
            │
            ▼
          Nginx
            │
            ▼
       Node.js App
```

Terraform is responsible for defining the AWS infrastructure required for the future deployment.

---

## 🐳 Docker

The Node.js application is containerized using a custom `Dockerfile`.

The Docker image contains the application and its required dependencies, allowing it to run consistently regardless of the host environment.

### Build the Image

```bash
docker build -t node-app .
```

### Run the Container

```bash
docker run -p 4000:4000 node-app
```

The application is available on:

```text
http://localhost:4000
```

---

## 🔥 Development Hot Reload

For development, the project uses **Nodemon** together with Docker bind mounts.

The source code is mounted into the container so that changes made locally are reflected inside the running container without rebuilding the image every time.

Example:

```yaml
volumes:
  - ./src:/app/src
```

This allows the application to automatically restart when source files are modified.

---

## 🧩 Docker Compose

Docker Compose is used to define and run the application's multiple services.

The project includes separate Compose configurations for the base setup and development environment.

### Start the Development Environment

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d --build
```

### Stop the Environment

```bash
docker compose down
```

Docker Compose manages the application containers and their networking configuration.

---

## 🍃 MongoDB

MongoDB is used as the application's database.

The Node.js application connects to MongoDB through **Mongoose** using the Docker Compose service name:

```text
mongodb://mongodb:27017/mydb
```

Inside the Docker Compose network, the application communicates with MongoDB using the service name `mongodb` instead of `localhost`.

This allows the Node.js application and MongoDB container to communicate through Docker's internal network.

---

## 🌐 Nginx

Nginx is included as a reverse proxy in the containerized environment.

It sits in front of the Node.js application and forwards incoming requests to the application container.

The architecture is:

```text
Client
  │
  ▼
Nginx
  │
  ▼
Node.js / Express
  │
  ▼
MongoDB
```

This setup introduces the reverse-proxy architecture commonly used when deploying web applications.

---

# 🔄 CI with GitHub Actions

The project includes a GitHub Actions workflow to automate the CI process.

The workflow is triggered when changes are pushed to the repository and is used to perform CI checks and build the Docker image.

This demonstrates the basic idea of **Continuous Integration (CI)**:

```text
Developer
    │
    │ git push
    ▼
GitHub Repository
    │
    │ GitHub Actions
    ▼
GitHub Runner
    │
    ├── Install dependencies
    ├── Run checks
    └── Docker build
            │
            ▼
       Docker Image
```

The current workflow focuses on CI. The AWS deployment stage is planned as a future extension.

---

# 🏗️ Infrastructure as Code with Terraform

Terraform was introduced to learn how cloud infrastructure can be defined and managed as code.

Instead of manually creating AWS resources through the AWS Console, Terraform allows the desired infrastructure to be described using **HashiCorp Configuration Language (HCL)**.

The Terraform configuration is located in:

```text
terraform/
```

---

## 📚 Terraform Concepts Practiced

The following Terraform concepts were studied and implemented:

* Infrastructure as Code (IaC)
* Terraform providers
* Terraform resources
* Terraform variables
* Terraform outputs
* Terraform state
* Resource dependencies
* Declarative configuration
* `terraform init`
* `terraform fmt`
* `terraform validate`
* `terraform plan`
* `terraform apply`
* `terraform destroy`

---

## ☁️ AWS Infrastructure Defined with Terraform

The current Terraform configuration defines the main components required for a simple public EC2-based application environment.

```text
                         🌍 Internet
                              │
                              ▼
                    ┌──────────────────┐
                    │ Internet Gateway │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │   Route Table    │
                    │  0.0.0.0/0 → IGW │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │  Public Subnet   │
                    └────────┬─────────┘
                             │
                             ▼
                    ┌──────────────────┐
                    │       EC2        │
                    │                  │
                    │  Public IPv4     │
                    └────────┬─────────┘
                             │
                       Security Group
                             │
                          TCP :80
```

### Resources currently defined

#### VPC

A Virtual Private Cloud provides the main isolated network for the application infrastructure.

```text
10.0.0.0/16
```

#### Subnet

A subnet is created inside the VPC:

```text
10.0.1.0/24
```

#### Internet Gateway

An Internet Gateway provides a path between the VPC and the Internet.

#### Route Table

The route table contains an Internet route:

```text
0.0.0.0/0 → Internet Gateway
```

This means that traffic destined for any IPv4 address uses the Internet Gateway when no more specific route exists.

#### Route Table Association

The subnet is associated with the route table so that resources inside the subnet use its routing rules.

#### Security Group

A security group controls traffic allowed to the EC2 instance.

The current configuration allows:

```text
TCP port 80
Source: 0.0.0.0/0
```

This allows inbound HTTP traffic from IPv4 addresses.

#### EC2

The Terraform configuration defines an EC2 instance that will act as the future application server.

The instance is configured with:

* An Ubuntu AMI
* Configurable instance type
* The created subnet
* The application security group
* A public IPv4 address

---

## 🔗 Terraform Resource Dependencies

Terraform automatically understands dependencies between resources when one resource references another.

For example:

```hcl
vpc_id = aws_vpc.main.id
```

The subnet depends on the VPC because it references the VPC's ID.

This allows Terraform to determine the correct order for creating resources.

A simplified dependency flow is:

```text
VPC
 │
 ├── Subnet
 │    │
 │    └── Route Table Association
 │
 ├── Internet Gateway
 │
 └── Route Table
       │
       └── Route
       
Security Group
      │
      ▼
     EC2
```

---

## 📤 Terraform Outputs

Terraform outputs are used to expose values produced by managed resources.

The project defines an output for the EC2 public IP:

```text
ec2_public_ip
```

After the infrastructure is actually provisioned, Terraform can display the public IP assigned to the EC2 instance.

This value can later be useful for connecting deployment automation to the target server.

---

## 🔐 Terraform State

Terraform uses a **state file** to keep track of the infrastructure it manages.

The state allows Terraform to understand the relationship between:

```text
Terraform Configuration
        │
        ▼
Terraform State
        │
        ▼
Real Infrastructure
```

Terraform uses this information when calculating changes during `terraform plan`.

The state is not the infrastructure itself. It is Terraform's record of the resources it manages.

---

## 🔄 Terraform Workflow

The general Terraform workflow practiced in this project is:

```text
Write .tf files
      │
      ▼
terraform init
      │
      ▼
terraform fmt
      │
      ▼
terraform validate
      │
      ▼
terraform plan
      │
      ▼
terraform apply
      │
      ▼
Infrastructure
```

### Initialize Terraform

```bash
terraform init
```

Initializes the Terraform working directory and downloads the required providers.

### Format Configuration

```bash
terraform fmt
```

Formats Terraform files according to Terraform's standard formatting rules.

### Validate Configuration

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically and structurally valid.

### Preview Changes

```bash
terraform plan
```

Creates a preview of the infrastructure changes Terraform would make.

### Apply Changes

```bash
terraform apply
```

Applies the planned changes and creates or updates the infrastructure.

> In this project, `terraform apply` has not been executed against AWS. The AWS configuration was validated and the infrastructure design was studied without provisioning paid AWS resources.

### Destroy Infrastructure

```bash
terraform destroy
```

Removes infrastructure managed by Terraform.

---

# 🔗 How Terraform Connects to the Application

Terraform and Docker have different responsibilities.

### Terraform

Terraform prepares the **infrastructure**:

```text
Terraform
   │
   ├── VPC
   ├── Subnet
   ├── Internet Gateway
   ├── Route Table
   ├── Security Group
   └── EC2
```

### Docker

Docker packages and runs the **application**:

```text
Node.js Application
        │
        ▼
    Docker Image
        │
        ▼
    Docker Container
```

### GitHub Actions

GitHub Actions automates the **CI/CD workflow**:

```text
Git Push
   │
   ▼
GitHub Actions
   │
   ├── Test
   ├── Build Docker Image
   ├── Push Image to Registry
   └── Future: Deploy to EC2
```

The planned AWS deployment architecture is:

```text
                    Terraform
                       │
                       ▼
              ┌─────────────────┐
              │       AWS       │
              │      EC2        │
              └────────┬────────┘
                       │
                       │ Docker
                       ▼
                    Nginx
                       │
                       ▼
                 Node.js App
```

For a future AWS implementation, the Docker image can be stored in **Amazon ECR**, and the EC2 instance can pull the image from ECR during deployment.

---

# 📚 DevOps Concepts Practiced

Throughout this project, the following concepts were practiced:

### Linux & Version Control

* Linux command-line basics
* Git
* GitHub
* Branches
* Commits
* Pull/Push workflow

### Docker

* Docker images
* Docker containers
* Dockerfiles
* `.dockerignore`
* Port mapping
* Bind mounts
* Volumes
* Docker Compose
* Multi-container applications
* Container networking
* Development environments
* Hot reload

### Application Infrastructure

* MongoDB containerization
* Nginx reverse proxy
* Service-to-service communication
* Environment-based configuration

### CI/CD

* GitHub Actions
* CI workflows
* Dependency installation
* Docker image building
* GitHub Container Registry (GHCR)
* CI/CD concepts

### Infrastructure as Code

* Terraform
* HCL
* AWS Provider
* Resources
* Variables
* Outputs
* Terraform State
* Resource dependencies
* VPC
* Subnets
* Internet Gateway
* Route Tables
* Routes
* Security Groups
* EC2
* Infrastructure planning

---

# 🎯 Project Goals

The project focuses on gaining practical experience with the DevOps workflow rather than only learning individual commands.

The main objectives are to:

1. Containerize a Node.js application.
2. Understand how Docker images and containers work.
3. Use Docker Compose to manage multiple services.
4. Create a development environment with hot reload.
5. Connect a containerized application to MongoDB.
6. Introduce Nginx as a reverse proxy.
7. Automate CI using GitHub Actions.
8. Understand container registries such as GHCR and Amazon ECR.
9. Learn Infrastructure as Code using Terraform.
10. Understand how AWS networking components work together.
11. Define an EC2-based AWS deployment environment using Terraform.
12. Understand how infrastructure provisioning and application deployment connect in a CI/CD workflow.

---

# 🚀 Future Improvements

Possible next steps for the project include:

* Adding automated application tests.
* Improving the CI pipeline.
* Using Amazon ECR as the Docker image registry.
* Connecting GitHub Actions to AWS securely.
* Deploying the Docker application to the Terraform-provisioned EC2 instance.
* Automating application deployment through CD.
* Configuring Nginx on the AWS server.
* Exploring remote Terraform state.
* Introducing Kubernetes/EKS as a separate advanced deployment architecture.

---

## 👩‍💻 Author

**Asmaa Mohamed**

Communication Engineer | Aspiring DevOps & Cloud Engineer

---

⭐ This project is part of my practical journey into **DevOps & Cloud Engineering**, where I am continuously building and improving hands-on projects while learning how application, container, CI/CD, and cloud infrastructure layers work together.
