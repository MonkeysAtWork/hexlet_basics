resource "kubernetes_secret" "cloudsql_db_credentials" {
  metadata {
    name = "cloudsql-db-credentials"
  }

  data = {
    DB_USERNAME = "${var.db_username}"
    DB_PASSWORD = "${var.db_password}"
  }
}

resource "kubernetes_secret" "cloudsql_instance_credentials" {
  metadata {
    name = "cloudsql-instance-credentials"
  }

  data = {
    "credentials.json" = "${base64decode(google_service_account_key.cloudsql_proxy.private_key)}"
  }
}

resource "kubernetes_secret" "cloudflare_credentials" {
  metadata {
    name = "cloudflare-credentials"
  }

  data = {
    CF_API_KEY   = "${var.cloudflare_api_key}"
    CF_API_EMAIL = "${var.cloudflare_email}"
  }
}

resource "kubernetes_secret" "cloudflare_credentials_kube_system" {
  metadata {
    name      = "cloudflare-credentials"
    namespace = "kube-system"
  }

  data = {
    CF_API_KEY   = "${var.cloudflare_api_key}"
    CF_API_EMAIL = "${var.cloudflare_email}"
  }
}

resource "kubernetes_secret" "sparkpost_credentials" {
  metadata {
    name = "sparkpost-credentials"
  }

  data = {
    SPARKPOST_SMTP_USERNAME = "${var.sparkpost_smtp_username}"
    SPARKPOST_SMTP_PASSWORD = "${var.sparkpost_smtp_password}"
    GUARDIAN_SECRET_KEY = "${var.guardian_secret_key}"
  }
}

resource "kubernetes_secret" "github_credentials" {
  metadata {
    name = "github-credentials"
  }

  data = {
    GITHUB_CLIENT_ID     = "${var.github_client_id}"
    GITHUB_CLIENT_SECRET = "${var.github_client_secret}"
  }
}

resource "kubernetes_secret" "facebook_credentials" {
  metadata {
    name = "facebook-credentials"
  }

  data = {
    FACEBOOK_CLIENT_ID     = "${var.facebook_client_id}"
    FACEBOOK_CLIENT_SECRET = "${var.facebook_client_secret}"
  }
}

resource "kubernetes_secret" "hexlet_basics_secrets" {
  metadata {
    name = "hexlet-basics-secrets"
  }

  data = {
    SECRET_KEY_BASE      = "${var.secret_key_base}"
    ROLLBAR_ACCESS_TOKEN = "${var.rollbar_access_token}"
  }
}

resource "kubernetes_config_map" "hexlet_basics_config_map" {
  metadata {
    name = "hexlet-basics-config-map"
  }

  data = {
    MIX_ENV      = "prod"
    PORT         = "4000"
    NODE_ENV     = "production"
    DB_HOSTNAME  = "pg-sqlproxy-gcloud-sqlproxy.default"
    DB_POOL_SIZE = "10"
    DB_NAME      = "hexlet_basics_prod"
    FORCE        = "11"
    APP_SCHEME   = "${var.app_scheme}"
    APP_HOST     = "${var.app_host}"
    APP_RU_HOST  = "${var.app_ru_host}"
  }
}

resource "kubernetes_cluster_role_binding" "cluster-admin" {
  metadata {
    name = "users-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind = "User"
    name = "alexander.v@hexlet.io"
  }

  subject {
    kind = "User"
    name = "kirill.m@hexlet.io"
  }
}
