resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = merge(
    var.common_tags,
    {
      Name = var.name
    }
  )
}
