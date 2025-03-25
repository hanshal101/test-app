output "namespace_name" {
  description = "This is the name of the namespace created"
  value = kubernetes_namespace.namespace
}

output "deployment_name" {
    description = "This is the name of the deployment created"
    value = kubernetes_deployment.deployment
}

output "service_name" {
    description = "This is the name of the deployment created"
    value = kubernetes_service.service
}
