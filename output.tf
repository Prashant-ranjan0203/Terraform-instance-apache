output "aws_instance_public_id" {
   value = aws_instance.my-instance.public_ip
  
}

output "instance_url" {
    value = "http://${aws_instance.my-instance.public_ip}"
  
}