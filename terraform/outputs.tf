output "eks_cluster_id" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_id
}

output "security_groups" {
  description = "The name of the EKS cluster."
  value       = module.eks.cluster_primary_security_group_id
}

output "namespace" {
  value = kubernetes_namespace.jenkins.metadata[0].name
}

#output "configure_kubectl" {
#  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
#  value       = module.eks.configure_kubectl
#}
