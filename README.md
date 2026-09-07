````markdown
# 🚀 Node.js DevOps Project — Docker, Compose & CI

A hands-on DevOps project demonstrating how to containerize a Node.js application and run it as a multi-container environment using **Docker, Docker Compose, Nginx, and MongoDB**.

The project also includes a **GitHub Actions CI pipeline** that automatically builds the Docker image when changes are pushed to the `main` branch or when a Pull Request targets `main`.

---

## 🛠️ Tech Stack

- **Node.js / Express.js** — Application
- **MongoDB** — Database
- **Mongoose** — MongoDB object modeling for Node.js
- **Docker** — Containerization
- **Docker Compose** — Multi-container application management
- **Nginx** — Reverse proxy
- **Git & GitHub** — Version control
- **GitHub Actions** — Continuous Integration (CI)

---

## 🏗️ Project Architecture

The application consists of three main services:

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
                               │ docker build
                               ▼
                    ┌────────────────────────┐
                    │   Docker Environment   │
                    │                        │
                    │  ┌──────────────────┐  │
                    │  │      Nginx       │  │
                    │  │  Reverse Proxy   │  │
                    │  └────────┬─────────┘  │
                    │           │            │
                    │           ▼            │
                    │  ┌──────────────────┐  │
                    │  │     Node.js      │  │
                    │  │    Express App   │  │
                    │  └────────┬─────────┘  │
                    │           │            │
                    │           ▼            │
                    │  ┌──────────────────┐  │
                    │  │     MongoDB      │  │
                    │  │     Database     │  │
                    │  └──────────────────┘  │
                    └────────────────────────┘
```
````

---

## 🔄 CI Workflow

The GitHub Actions workflow runs when:

- Code is pushed to the `main` branch.
- A Pull Request is opened or updated against the `main` branch.

The current CI pipeline performs the following steps:

```text
git push / Pull Request
          ↓
       GitHub
          ↓
    GitHub Actions
          ↓
   Checkout Repository
          ↓
     Setup Node.js
          ↓
       npm ci
          ↓
   Docker Image Build
          ↓
    ✅ CI Completed
```

The workflow is defined in:

```text
.github/workflows/ci.yml
```

---

## 🐳 Docker

The Node.js application is containerized using a `Dockerfile`.

The Docker image is built using:

```bash
docker build -t node-app:ci .
```

The Dockerfile uses Docker layer caching by copying the package files before the application source code:

```dockerfile
COPY package*.json ./
RUN npm install
COPY . .
```

This helps avoid reinstalling dependencies when only the application source code changes.

---

## 🐳 Docker Compose

Docker Compose is used to manage the complete application stack.

The project contains:

```text
docker-compose.yml
docker-compose.dev.yml
docker-compose.prod.yml
```

### Base Configuration

`docker-compose.yml` defines the main services:

- Node.js application
- MongoDB
- Nginx

### Development Environment

Development-specific settings are defined in:

```text
docker-compose.dev.yml
```

The development environment enables:

- `NODE_ENV=development`
- Read-only source-code mounting

Run the development environment with:

```bash
docker compose \
  -f docker-compose.yml \
  -f docker-compose.dev.yml \
  up -d --build
```

### Production Environment

Production-specific settings are defined in:

```text
docker-compose.prod.yml
```

Run the production environment with:

```bash
docker compose \
  -f docker-compose.yml \
  -f docker-compose.prod.yml \
  up -d --build
```

---

## 🌐 Nginx Reverse Proxy

Nginx is used as a reverse proxy in front of the Node.js application.

```text
Client
  │
  │ HTTP :8080
  ▼
Nginx :80
  │
  │ proxy_pass
  ▼
Node.js :4000
```

Nginx forwards incoming requests to the Docker Compose service:

```text
http://node-app:4000
```

The Nginx configuration is located at:

```text
nginx/nginx.conf
```

---

## 🗄️ MongoDB

MongoDB runs as a separate Docker container.

The Node.js application connects to MongoDB using the Docker Compose service name:

```text
mongodb://mongodb:27017/mydb
```

Inside the Docker Compose network, services can communicate using their service names.

MongoDB data is stored using a named Docker volume:

```text
mongo-data
```

This allows database data to persist even if the MongoDB container is removed.

---

## 🔐 Environment Variables

Environment-specific configuration is stored in a local `.env` file.

Example:

```env
PORT=4000
PASS=your_password_here
```

The `.env` file is excluded from Git using:

```text
.gitignore
```

It is also excluded from the Docker build context using:

```text
.dockerignore
```

> ⚠️ Never commit passwords, API keys, SSH private keys, or other secrets to GitHub.

---

## 📂 Project Structure

```text
devops-bootcamp/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── nginx/
│   └── nginx.conf
│
├── src/
│   └── index.js
│
├── .dockerignore
├── .gitignore
├── .env
├── Dockerfile
├── docker-compose.yml
├── docker-compose.dev.yml
├── docker-compose.prod.yml
├── package.json
└── package-lock.json
```

> `.env` is kept locally and should not be committed to the repository.

---

## ▶️ Running the Application

Build and start the complete stack:

```bash
docker compose up -d --build
```

Check running containers:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs
```

View logs for a specific service:

```bash
docker compose logs node-app
```

Stop the application:

```bash
docker compose down
```

---

## 🧪 Testing the Application

After starting the containers, the Node.js application can be accessed through:

```text
http://localhost:4000
```

Nginx can be accessed through:

```text
http://localhost:8080
```

The application should return:

```text
Hello from my Node.js app! hi
```

---

## 🎯 What I Am Learning

This project is part of my hands-on DevOps learning journey.

Through this project, I am gaining practical experience with:

- Linux
- Git & GitHub
- Docker
- Dockerfiles
- Docker Images & Containers
- `.dockerignore`
- Docker Volumes
- Docker Compose
- Development & Production environments
- Environment Variables
- Node.js containerization
- MongoDB with Docker
- Nginx Reverse Proxy
- GitHub Actions
- Continuous Integration (CI)
- Docker Layer Caching

---

## 🚀 Future Improvements

The project will be extended with additional DevOps and Cloud practices, including:

- Automated testing
- Docker image publishing
- AWS EC2 deployment
- SSH-based deployment
- Continuous Deployment (CD)
- Nginx HTTPS / SSL
- Health checks
- Docker image security scanning
- Monitoring
- Automated rollback
- Zero-downtime deployment
- Infrastructure as Code with Terraform
- Configuration management with Ansible
- Kubernetes
