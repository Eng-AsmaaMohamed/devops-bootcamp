# 🚀 Node.js DevOps Project — Docker, Compose & CI

A hands-on DevOps project demonstrating how to containerize a Node.js application, manage multiple services with Docker Compose, enable development hot reload, connect the application to MongoDB, configure Nginx, and automate the build process using GitHub Actions.

---

## 📌 Project Overview

This project was created as a practical implementation of core DevOps concepts using a simple Node.js application.

The project gradually evolves from running a Node.js application locally to running it in a multi-container environment with:

- Node.js application
- MongoDB database
- Nginx reverse proxy
- Docker & Docker Compose
- Development hot reload
- GitHub Actions CI workflow

The main goal is to understand how these technologies work together in a real-world development and deployment workflow.

---

## 🛠️ Technologies Used

- **Node.js**
- **Express.js**
- **MongoDB**
- **Mongoose**
- **Docker**
- **Docker Compose**
- **Nginx**
- **Git & GitHub**
- **GitHub Actions**

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

### 🔄 Workflow

1. The developer pushes changes to the GitHub repository.
2. GitHub Actions starts a workflow on a GitHub runner.
3. The workflow builds the Docker image.
4. Docker Compose runs the application environment.
5. Nginx receives incoming requests and forwards them to the Node.js application.
6. The Node.js application communicates with MongoDB for database operations.

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

## 🔄 CI with GitHub Actions

The project includes a GitHub Actions workflow to automate the CI process.

The workflow is triggered when changes are pushed to the repository and is used to automatically build the Docker image.

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
    │ docker build
    ▼
Docker Image
```

---

## 📚 DevOps Concepts Practiced

Throughout this project, the following concepts were practiced:

- Linux command-line basics
- Git & GitHub
- Docker images and containers
- Dockerfiles
- `.dockerignore`
- Port mapping
- Bind mounts
- Volumes
- Docker Compose
- Multi-container applications
- Container networking
- Development environments
- Hot reload
- MongoDB containerization
- Nginx reverse proxy
- Continuous Integration
- GitHub Actions

---

## 🎯 Project Goals

The project focuses on gaining practical experience with the DevOps workflow rather than only learning individual commands.

The main objectives are to:

1. Containerize a Node.js application.
2. Understand how Docker images and containers work.
3. Use Docker Compose to manage multiple services.
4. Create a development environment with hot reload.
5. Connect a containerized application to MongoDB.
6. Introduce Nginx as a reverse proxy.
7. Automate part of the workflow using GitHub Actions.
8. Practice managing the project with Git and GitHub.

---

## 🚀 Future Improvements

Possible next steps for the project include:

- Building a production-ready Docker setup.
- Improving the CI pipeline.
- Adding automated tests.
- Pushing Docker images to a container registry.
- Deploying the application to AWS.
- Adding a complete CI/CD pipeline.

---

## 👩‍💻 Author

**Asmaa Mohamed**

Communication Engineer | Aspiring DevOps & Cloud Engineer

---

⭐ This project is part of my practical journey into **DevOps & Cloud Engineering**, where I am continuously building and improving hands-on projects.
