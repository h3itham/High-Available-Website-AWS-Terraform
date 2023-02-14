resource "aws_launch_configuration" "web" {
  name_prefix = "web-"
  image_id = "ami-0557a15b87f6559cf" 
  instance_type = "t2.micro"
   key_name = "haithamkey"
  security_groups = [ aws_security_group.allow_http.id ]
  associate_public_ip_address = true
  user_data = <<-EOF
             #!/bin/bash 
             sudo apt update 
             sudo apt install nginx -y 
             systemctl start nginx 
             EOF

  lifecycle {
    create_before_destroy = true
  }
}
