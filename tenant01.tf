

resource "softlayer_virtual_guest" "terraform-test-02" {
    name = "test-01"
    domain = "example.com"
    ssh_keys = ["${softlayer_ssh_key.test-key.id}"]
    image = "UBUNTU_14_64"
    region = "mex01"
    local_disk = true
    public_network_speed = 10
    hourly_billing = true
    cpu = 4
    ram = 1024
    provisioner "local-exec" {
        command = "echo ${softlayer_virtual_guest.terraform-test-02.ipv4_address} >> hosts"
    }

}

