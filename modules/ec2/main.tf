resource "aws_instance" "bastion_host" {
  ami           = var.ami
  instance_type = var.instance_type
   security_groups = var.security_group
   subnet_id = var.subnet_id
  key_name = var.key_name

  tags = {
    Name = "${var.env}-${var.project_name}_ec2"
  }
}
