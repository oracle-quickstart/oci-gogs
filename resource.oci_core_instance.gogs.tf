resource "oci_core_instance" "gogs" {
  agent_config {
    is_management_disabled = false
    is_monitoring_disabled = false
  }
  availability_domain = var.server_ad
  compartment_id      = var.server_compartment_ocid
  create_vnic_details {
    assign_public_ip = var.public_ip
    hostname_label   = "gogs"
    subnet_id        = var.subnet_ocid
  }
  display_name = "gogs"
  fault_domain = var.server_fd
  launch_options {
    boot_volume_type        = "PARAVIRTUALIZED"
    firmware                = "UEFI_64"
    network_type            = "PARAVIRTUALIZED"
    remote_data_volume_type = "PARAVIRTUALIZED"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data           = data.cloudinit_config.gogs.rendered
  }
  shape = var.server_shape
  source_details {
    boot_volume_size_in_gbs = var.server_boot_volume
    source_id               = var.image_oraclelinux_7[var.region]
    source_type             = "image"
  }
}
