variable "username" {}
variable "api_key" {}

provider "softlayer" {
    username = "${var.username}"
    api_key = "${var.api_key}"
}

resource "softlayer_ssh_key" "test-key" {
    label = "test-key"
    public_key = "${file("terraform-test.pub")}"
}

resource "softlayer_virtual_guest" "terraform-test-01" {
    hostname = "test-01"
    domain = "example.com"
    ssh_key_ids = ["${softlayer_ssh_key.test-key.id}"]
    os_reference_code = "UBUNTU_14_64"
    datacenter = "mex01"
    network_speed = 1000
    hourly_billing = true
    cores = 4
    memory = 1024
    provisioner "local-exec" {
        command = "echo ${softlayer_virtual_guest.terraform-test-01.ipv4_address} >> hosts"
    }

}

