resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id

  tags = merge(
    var.common_tags,
    { Name = var.name }
  )
}
