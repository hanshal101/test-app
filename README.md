# Test-App: A Simple Node.js Application with Docker and Kubernetes Deployment

This repository contains a simple Node.js application, containerized with Docker and deployed to Kubernetes. It demonstrates the use of Infrastructure as Code (IaC) principles for managing the deployment and includes a CI/CD pipeline using GitHub Actions.

## Application Overview

The application is a basic "Hello, World!" web server built with Node.js and Express. It listens on port 3000 and responds to GET requests on the root path (`/`).

### Prerequisites

*   **kubectl:** The Kubernetes command-line tool must be installed.
*   **Kind or Minikube Cluster:** If you don't have a Kubernetes cluster, you can use Minikube or Kind to set up a local cluster.

### Steps

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/hanshal101/test-app.git
    cd test-app
    ```

2.  **Apply Kubernetes Configurations:**

    ```bash
    kubectl apply -f deployment/
    ```

3.  **Verify the Deployment:**

    *   **Check Pod Status:**

        ```bash
        kubectl get pods -n test-app-namespace
        ```

        You should see two pods in the `Running` state.
    *   **Check Service Status:**

        ```bash
        kubectl get service -n test-app-namespace
        ```
        You should see the `test-app-service` with a `NodePort` exposed.
    *   **Access the Application:**

        ```bash
        kubectl port-forward svc/test-app-service -n test-app-namespace 3000:3000
        ```
        
        Then, you can test the application by either using a curl command or by accessing the application in your browser using `http://localhost:3000`. You should see "Hello, World!".
        ```bash
        curl http://localhost:3000
        ```

### Cleanup

To remove the deployed resources:

```bash
kubectl delete -f deployment/
```