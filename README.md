# app Application Deployment and Containerization

## Overview
This project demonstrates the **containerization** of the app application and its **deployment on Kubernetes** using a **CI/CD pipeline** through GitHub Actions. The end goal is to have an automated system that builds the Docker image, pushes it to a container registry, and deploys it to Kubernetes.

## Tasks Completed

### 1. **Dockerization**
- Created a `Dockerfile` to containerize the app application.
- The Dockerfile defines the necessary steps to package the app into a Docker image, including setting up dependencies and copying source files into the container.

### 2. **Kubernetes Deployment**
- Created the necessary Kubernetes manifest files to deploy the application, including:
  - `deployment.yaml` 
  - `service.yaml`
  - `ingress.yaml`

### 3. **CI/CD Pipeline Implementation (GitHub Actions)**
- Set up a **GitHub Actions** workflow that automatically:
  - Builds the Docker image for the app app.
  - Pushes the Docker image to **Docker Hub** for accessibility.
  
  The **continuous deployment (CD)** portion, which would automatically deploy the app to Kubernetes after the Docker image is pushed, has been omitted for this workflow due to the use of **Minikube**.

### 4. **TLS Implementation (Optional Challenge Goal)**
- For security, the application is configured to run with **TLS communication**. This includes using secure protocols for any web traffic.

---

## TLS Configuration for Secure Communication

The **app Application** is secured with **TLS** (HTTPS) using **cert-manager** and **Let's Encrypt** to automate the process of acquiring and renewing SSL/TLS certificates. The setup is as follows:

### **TLS Ingress Configuration (`tls-configuration.yaml`)**

This configuration sets up an **Ingress** resource to route traffic securely to the application via HTTPS using TLS certificates issued by **Let’s Encrypt**.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  tls:
  - hosts:
    - app.local
    secretName: app-tls
  rules:
  - host: app.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: app-service
            port:
              number: 80
