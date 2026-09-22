# Defines an output value that Terraform will display after applying the configuration

output "ec2_public_ip" {

  # Gets the public IPv4 address assigned to our EC2 instance
  value = aws_instance.app.public_ip
}


#لو عملنا apply حقيقي، Terraform ممكن يعرض:
#ec2_public_ip = "54.xx.xx.xx"
#لو عايزين نعرف بعد إنشاء السيرفر إيه الـ IP اللي نستخدمه للوصول إليه