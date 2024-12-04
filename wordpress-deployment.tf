provider "kubernetes" {
  config_path = "kubeconfig.yaml"
}

resource "local_file" "kubeconfig" {
  filename = "kubeconfig.yaml"
  content  = module.eks.kubeconfig
}

provider "helm" {
  kubernetes {
    config_path = local_file.kubeconfig.filename
  }
}

resource "helm_release" "wordpress" {
  name       = "wordpress"
  namespace  = "default"
  chart      = "bitnami/wordpress"
  repository = "https://charts.bitnami.com/bitnami"

  values = [
    <<EOF
wordpressUsername: admin
wordpressPassword: admin_password
wordpressEmail: admin@example.com
mariadb:
  auth:
    rootPassword: root_password
    database: wordpress
    username: user
    password: user_password
service:
  type: LoadBalancer
EOF
  ]
}
