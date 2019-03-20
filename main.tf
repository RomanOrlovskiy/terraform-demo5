provider "aws" {
  region     = "us-west-2"
}

resource "aws_instance" "tomcat_server" {

  #ami           = "ami-032509850cf9ee54e" #default amazon ami 2
  ami = "ami-005bdb005fb00e791" #Ubuntu
  instance_type = "t2.micro"
  subnet_id = "subnet-06c186774ef4fc15a"
  key_name = "WebServer01"
  count = 1

  vpc_security_group_ids = [
    "sg-02ea87bfde9b85560"
  ]

  tags = {
    Name = "Ubu_Tomcat_Server"
  }
}

resource "aws_instance" "tomcat_server_2" {

  #ami = "ami-032509850cf9ee54e" #default amazon ami 2
  ami = "ami-005bdb005fb00e791" #Ubuntu
  instance_type = "t2.micro"
  subnet_id = "subnet-06c186774ef4fc15a"
  key_name = "WebServer01"
  count = 2
  iam_instance_profile = "S3-Admin-Access"

  #Lab-Web-SG
  vpc_security_group_ids = [
    "sg-02ea87bfde9b85560"
  ]

  tags = {
    Name = "Ubu_Tomcat_Server_2"
  }
}


resource "aws_instance" "nginx" {

  ami = "ami-032509850cf9ee54e" #default amazon ami 2
  #ami = "ami-005bdb005fb00e791" #Ubuntu
  instance_type = "t2.micro"
  subnet_id = "subnet-06c186774ef4fc15a"
  key_name = "WebServer01"

  #sg-07afbdae19872b30c - Lab-Web-SG
  vpc_security_group_ids = [
    "sg-02ea87bfde9b85560"
  ]

  tags = {
    Name = "Centos_Nginx"
  }
}

resource "aws_instance" "mysql_server" {

  ami = "ami-032509850cf9ee54e" #default amazon ami 2
  #ami = "ami-005bdb005fb00e791" #Ubuntu
  instance_type = "t2.micro"
  subnet_id = "subnet-06c186774ef4fc15a"
  key_name = "WebServer01"
  # count = "2"

  #My-RDS-SG
  vpc_security_group_ids = [
    "sg-02ea87bfde9b85560"
  ]

  tags = {
    Name = "Centos_Mysql_Server"
  }
}

output "Tomcat EC2 instance public IP:" {
  value = "${aws_instance.tomcat_server.public_ip}"
}

output "Tomcat 2 test instances public IP:" {
  value = "${aws_instance.tomcat_server_2.*.public_ip}"
}

output "Nginx instance public IP:" {
  value = "${aws_instance.nginx.public_ip}"
}

output "Mysql instance public IP:" {
  value = "${aws_instance.mysql_server.public_ip}"
}
