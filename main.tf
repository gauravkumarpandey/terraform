/*
 Tells terraform that we are going to use aws as provide
 and we wish to deploy our infrastructure in ap-south-1 
*/
provider "aws"{
    region = "ap-south-1"
}

resource "aws_security_group" "allow-http" {
   name = "allow-http"

    ingress{
    description      = "HTTP anywhere"
    from_port        = 0
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "FirstTf" {
   ami = "ami-052cef05d01020f1d"
   instance_type = "t2.micro"
   vpc_security_group_ids   = ["${aws_security_group.allow-http.id}"]

   user_data = <<-EOF
               #!/bin/bash
               # Use this for your user data (script from top to bottom)
               # install httpd (Linux 2 version)
               sudo su
               yum update -y
               yum install -y httpd
               systemctl start httpd
               systemctl enable httpd
               echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
            EOF

   tags = {
       Name = "tf-example"
   }
}



