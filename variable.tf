variable "region" {
    description = "region where ec2 instance will be created"
    default = "eu-north-1"
  }

variable "ami" {
    description = "The ami value at which ec2 will be created / OS "
    default = "ami-0c4fc5dcabc9df21d"
  

}

variable "instance_type" {
    description = "type of instances which will be created "
    default =  "t3.micro"
  
}