terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "test-app-namespace"
    labels = {
      name = "test-app-namespace"
    }
  }
}

resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_namespace.namespace]
  metadata {
    name      = "test-app-deployment"
    namespace = kubernetes_namespace.namespace.id
    labels = {
      app = "test-app"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "test-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "test-app"
        }
      }
      spec {
        container {
          name  = "test-app-container"
          image = "hanshal101/test-app:latest"
          image_pull_policy = "IfNotPresent"
          port {
            container_port = 3000
          }
          resources {
            requests = {
              memory = "64Mi"
              cpu    = "250m"
            }
            limits = {
              memory = "128Mi"
              cpu    = "500m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  depends_on = [kubernetes_deployment.deployment]
  metadata {
    name      = "test-app-service"
    namespace = kubernetes_namespace.namespace.id
    labels = {
      app = "test-app"
    }
  }
  spec {
    selector = {
      app = "test-app"
    }
    port {
      protocol    = "TCP"
      port        = 3000
      target_port = 3000
      node_port   = 30001
    }
    type = "NodePort"
  }
}
