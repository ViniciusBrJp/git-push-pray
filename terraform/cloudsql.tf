# Cloud SQL はコスト削減のため 2026-05-29 に削除（decommission）しました。
# データは GCS にダンプを退避済み:
#   gs://git-push-pray-db-backup/git-push-pray-db-20260529.sql
#
# 復旧手順:
#   1. 下記のリソース定義をコメント解除して `terraform apply`（空のインスタンス再作成）
#   2. ダンプを取り込む:
#      gcloud sql import sql git-push-pray-db \
#        gs://git-push-pray-db-backup/git-push-pray-db-20260529.sql \
#        --database=git-push-pray
#   3. outputs.tf の db_connection_name と main.tf backend の depends_on も元に戻す
#
# ※ 復旧時は deletion_protection を true に戻すことを推奨します。

# resource "google_sql_database_instance" "main" {
#   name             = "git-push-pray-db"
#   database_version = "POSTGRES_18"
#   region           = var.region
#
#   settings {
#     tier = "db-f1-micro"
#
#     backup_configuration {
#       enabled = false
#     }
#
#     ip_configuration {
#       ipv4_enabled = true
#     }
#   }
#
#   deletion_protection = true
#
#   depends_on = [google_project_service.enabled_apis]
# }
#
# resource "google_sql_database" "app_db" {
#   name     = "git-push-pray"
#   instance = google_sql_database_instance.main.name
# }
#
# resource "google_sql_user" "app_user" {
#   name     = "appuser"
#   instance = google_sql_database_instance.main.name
#   password = var.db_password
# }
