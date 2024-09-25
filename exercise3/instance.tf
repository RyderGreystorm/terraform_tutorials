#Uploading the key-pair to use for ssh auth
resource "aws_key_pair" "dev-key" {
  key_name   = "devkey"
  public_key = file("devkey.pub")
}


#Creating the AWS Instance and Launching our webpage on it
resource "aws_instance" "web-server" {
  ami                    = var.AMIS[var.REGION1]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.dev-key.key_name
  vpc_security_group_ids = [var.SG-ID]
  tags = {
    Name    = "Web-server 1"
    Project = "Web-project"
  }

  # Send our script to the server using file provisioner
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"

  }

  #Executing script on the remote server using REMOTE-EXEC provisioner
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  #connection details
  connection {
    type        = "ssh"
    user        = var.USER
    private_key = file("devkey")
    host        = self.public_ip
  }
}