# Defining AWS as provisioning provider, value provided in terraform.tfvars
provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"

  # Instance region, default: ap-southeast-1 (singapore)
  region = "${var.AWS_REGION}"
}

# Defining keypair to be used as instance key
resource "aws_key_pair" "instance" {
  key_name = "instance-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEUpWiN3Mt+KPl2F2QooQoUgvp1Ik8+EjrDGMNKHN5lyLkOCgbOIYWgEjmYzqGJUr9bdq/BKBIOgvzQbGoz2etKP/aT35IfYSEkZWZwQ9CWpjVNR/a84mJB7AxZFQOW1+XdutgsySG/Tg/Rw2DuNcEaIOheeMSd7aZkVZV+uSlv/c8UyYYfrsmzf2GcZ2iUBx42TperA3QVlo3qhaqlLOoeyRNQSAss7p+nXta2P6er8ud3+/HkHjtqQorkb5FbUtba/WAVQ8ZZSzXtsseuFCYgM+P3B+L7tnnp3cTKpofGJ1sZtoGf+DLZOsukuAC7j1FNvbOLp/IIKn6rWbM2fW1 r4pbh1t3@R4pbh1t3-PC"
}

# Defining AWS instace to be created by terraform 
resource "aws_instance" "niagahoster_test" {

  # Total of instance to be created
  count = 3

  # AMI to be used by the instance
  ami   = "ami-0d058fe428540cd89"

  # Instance type to be created
  instance_type = "t2.micro"

  # Virtual Private Cloud
  vpc_security_group_ids = "${var.AWS_VPC_SG}"

  # Key pair used to access the instance, defined above
  key_name = aws_key_pair.instance.key_name

  # Defining instance's name
  tags = {
      Name = "instance-${count.index}"
  }

  # All the instance using the same key
  # Copying the same key and ssh config to every instance 
  # so it could communicate to each other from the get-go
  
  provisioner "file" {
    
    # Source of files to be copied
    source = "resource/"

    # Copy files target
    destination = "/home/ubuntu/.ssh"

    # Defining connection used to copy file via SSH
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("resource/instance.key")}"
      host = "${self.public_ip}"
    }
  }

  # Provisioning to secure the key
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/.ssh/instance.key",
    ]

    # Defining connection used to send command via SSH
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("resource/instance.key")}"
      host = "${self.public_ip}"
    }
  }
}