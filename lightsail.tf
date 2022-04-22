resource "aws_lightsail_key_pair" "lg_key_pair" {
  name = "lg_key_pair"
}

resource "local_file" "foo" {
    content  = aws_lightsail_key_pair.lg_key_pair.private_key
    filename = "id_rsa.pem"
    file_permission = "0600"
}

resource "aws_lightsail_instance" "srv" {
  name              = "ftp_server"
  availability_zone = "ap-southeast-2a"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "nano_2_2"
  key_pair_name = aws_lightsail_key_pair.lg_key_pair.id
  user_data = file("build_script.sh")
}


resource "aws_lightsail_instance_public_ports" "test" {
  instance_name = aws_lightsail_instance.srv.name

  port_info {
    protocol  = "all"
    from_port = 0
    to_port   = 65535 
  }
}


output "ipv4_address" { value = aws_lightsail_instance.srv.public_ip_address }
