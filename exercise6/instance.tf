#Create a keypair for our ec2 resource
resource "aws_key_pair" "devkey" {
  key_name   = "dovekey"
  public_key = file(var.PUB_KEY)
}


resource "aws_instance" "web-server" {
  ami                    = var.AMIS[var.REGION1]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.pub_sub1.id
  key_name               = aws_key_pair.devkey.key_name
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    Name = "webserver"
  }


  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"

  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file(var.PRIV_KEY)
    host        = self.public_ip
  }

}

#Setting up EBS Volume
resource "aws_ebs_volume" "web-ebs" {
  availability_zone = var.ZONE1
  size              = 3

  tags = {
    Name = "Webserver_volumet"
  }
}

#Attaching volume to webserver
resource "aws_volume_attachment" "ebs_att_web" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web-ebs.id
  instance_id = aws_instance.web-server.id
}


output "Public_ip" {
  value = aws_instance.web-server.public_ip
}