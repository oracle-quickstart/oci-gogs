data cloudinit_config gogs {
  gzip          = false
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile(
      "./metadata.gogs.cloud-config",
      {
        GOGS_DB_NAME        = var.gogs_db_name,
        GOGS_DB_PASSWD      = var.gogs_db_passwd,
        GOGS_DB_ROOT_PASSWD = var.gogs_db_root_passwd,
        GOGS_DB_USER        = var.gogs_db_user,
        GOGS_SSH_PORT       = var.gogs_ssh_port,
      }
    )
  }
  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "./metadata.gogs.sh", {
        GOGS_SSH_PORT = var.gogs_ssh_port,
      }
    )
  }
}
