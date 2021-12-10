/*
 Tells terraform that we are going to use aws as provide
 and we wish to deploy our infrastructure in ap-south-1 
*/
provider "aws"{
    region = "ap-south-1"
}

resource "aws_instance" "FirstTf" {
   ami = "ami-052cef05d01020f1d"
   instance_type = "t2.micro"

   tags = {
       Name = "tf-example"
   }
}


