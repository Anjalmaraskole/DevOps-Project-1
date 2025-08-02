DevOps Project: Django Application Deployment using Jenkins, Docker, and Kubernetes

📌 Project Objective

To automate the build and deployment of a Django application using Jenkins CI/CD pipeline, Docker for containerization, and Kubernetes (Minikube) for orchestration, all hosted on an Ubuntu EC2 instance.

🔧 Tech Stack

Backend: Python, Django

Containerization: Docker

CI/CD: Jenkins

Orchestration: Kubernetes (Minikube)

Hosting: AWS EC2 (Ubuntu)

Database: SQLite (default), can be replaced with PostgreSQL

✅ Project Flow

1. 🔐 SSH into EC2

ssh -i "your-key.pem" ubuntu@<public-ip>

2. ⚙️ Install Dependencies

Docker

Minikube (with --container-runtime=docker)

kubectl

Jenkins

Python & pip

cri-dockerd

3. 🧱 Django Project Setup

Created Django project using:

django-admin startproject myproject

Verified manage.py, settings.py, urls.py, and wsgi.py

4. 🐳 Dockerize the Project

Created Dockerfile with following content:

FROM python:3.12
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

Built Docker image:

docker build -t my-django-app:latest .

5. ⚙️ Jenkins Setup

Installed Jenkins & unlocked using /var/lib/jenkins/secrets/initialAdminPassword

Created pipeline using Jenkinsfile:

pipeline {
    agent any
    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Anjalmaraskole/DevOps-Project-1.git'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t my-django-app:latest .'
            }
        }
        stage('Run') {
            steps {
                sh 'docker run -d -p 8000:8000 my-django-app:latest'
            }
        }
    }
}

6. ☸️ Kubernetes Deployment

Created django-deployment.yaml and service.yml

Deployed using:

kubectl apply -f django-deployment.yaml
kubectl apply -f service.yml

7. 🌐 Access Admin Panel

Created Superuser:

python3 manage.py createsuperuser

Handled DisallowedHost by updating ALLOWED_HOSTS in settings.py

Ran migrations:

python3 manage.py migrate

Access via http://<public-ip>:<NodePort>/admin

❗ Common Errors & Fixes

Error

Cause

Fix

DisallowedHost

Missing IP in ALLOWED_HOSTS

Added IP in settings.py

no such table: auth_user

DB not migrated

Ran python manage.py migrate

Jenkins not opening

Service down

sudo systemctl start jenkins

Port already in use

Duplicate container

Stopped old container

Superuser login failed

Data lost after image rebuild

Created superuser again

📂 Directory Structure (Simplified)

.
├── Dockerfile
├── Jenkinsfile
├── manage.py
├── requirements.txt
├── myproject/
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
├── django-deployment.yaml
├── service.yml

📌 Future Improvements

Use PostgreSQL instead of SQLite

Add volume for data persistence

Setup monitoring with Prometheus + Grafana

Deploy using EKS instead of Minikube

🙋‍♀️ Author

Anjali Nainsingh MaraskoleGitHub

🔁 This project was built from scratch with continuous debugging and real-time learning of DevOps lifecycle.


