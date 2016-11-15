variable "username" {}
variable "api_key" {}

provider "softlayer" {
    username = "${var.username}"
    api_key = "${var.api_key}"
}

resource "softlayer_ssh_key" "test-key" {
    name = "test-key"
    public_key = "${file("terraform-test.pub")}"
}

resource "softlayer_virtual_guest" "terraform-test-01" {
    name = "test-01"
    domain = "example.com"
    ssh_keys = ["${softlayer_ssh_key.test-key.id}"]
    os_reference_code = "UBUNTU_14_64"
    region = "mex01"
    public_network_speed = 10
    hourly_billing = true
    cpu = 4
    ram = 1024
    provisioner "local-exec" {
        command = "echo ${softlayer_virtual_guest.terraform-test-01.ipv4_address} >> hosts"
    }

}

