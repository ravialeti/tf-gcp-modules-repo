#VM module to create multiple instances using subnet
resource "google_compute_instance" "wp-vm" {
  count         = var.num_instances
  #name          = var.instance_name
  name = "vm001-${count.index}"
  machine_type  = var.vm_type
  zone          = var.vm_zone
  tags          = var.tags
  metadata_startup_script = file("${var.startup_script}")
  #metadata_startup_script = file("./apache2.sh")
  boot_disk {
    initialize_params {
     image = var.vm_image
     size  = var.vm_size
    }
  }
   network_interface {
    subnetwork = var.subnet_name
    access_config {
      // Ephemeral IP
    }
  }
  allow_stopping_for_update = true
}
