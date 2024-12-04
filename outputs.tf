# output "wordpress_url" {
#   value = helm_release.wordpress.status.load_balancer.ingress[0].ip
# }

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
