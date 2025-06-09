# EC2 Instances
resource "aws_instance" "main" {
  count = length(var.instances)

  ami                    = var.ami_id
  instance_type          = var.instances[count.index].instance_type
  subnet_id              = var.instances[count.index].subnet_id
  vpc_security_group_ids = var.instances[count.index].security_group_ids
  key_name               = var.key_name
  iam_instance_profile   = var.instances[count.index].iam_instance_profile


  # User data script
  user_data = var.instances[count.index].user_data_file != null ? file("${path.module}/${var.instances[count.index].user_data_file}") : null

  # Root block device configuration
  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
    encrypted   = true
    
    tags = merge(
      var.instances[count.index].tags,
      {
        Name = "${var.instances[count.index].name}-root"
      }
    )
  }

  # Enable detailed monitoring
  monitoring = true

  # Instance metadata options (IMDSv2)
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  # Enable termination protection for production
  disable_api_termination = var.environment == "prod" ? true : false

  # Enable stop protection for production
  disable_api_stop = false

  # EBS optimization
  ebs_optimized = true

  # Credit specification for T3 instances
  credit_specification {
    cpu_credits = "standard"
  }

  # Maintenance options
  maintenance_options {
    auto_recovery = "default"
  }

  tags = merge(
    var.instances[count.index].tags,
    {
      Name = var.instances[count.index].name
    }
  )

  # Ensure proper order of resource creation
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ami]  # Ignore AMI changes to prevent unexpected replacements
  }
}

# Elastic IPs (optional)
resource "aws_eip" "main" {
  count = var.assign_elastic_ips ? length(var.instances) : 0

  instance = aws_instance.main[count.index].id
  domain   = "vpc"

  tags = merge(
    var.instances[count.index].tags,
    {
      Name = "${var.instances[count.index].name}-eip"
    }
  )

  depends_on = [aws_instance.main]
}

# EIP Association (if using pre-allocated EIPs)
resource "aws_eip_association" "main" {
  count = length(var.elastic_ip_allocation_ids)

  instance_id   = aws_instance.main[count.index].id
  allocation_id = var.elastic_ip_allocation_ids[count.index]

  depends_on = [aws_instance.main]
}

# Route53 A Records for private IPs
resource "aws_route53_record" "private" {
  count = var.create_dns_records && var.route53_zone_id != null ? length(var.instances) : 0

  zone_id = var.route53_zone_id
  name    = "${var.instances[count.index].name}.${var.route53_zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.main[count.index].private_ip]

  lifecycle {
    create_before_destroy = true
  }
}

# Route53 A Records for public IPs (if using EIPs)
resource "aws_route53_record" "public" {
  count = var.create_dns_records && var.route53_zone_id != null && var.assign_elastic_ips ? length(var.instances) : 0

  zone_id = var.route53_zone_id
  name    = "${var.instances[count.index].name}-public.${var.route53_zone_name}"
  type    = "A"
  ttl     = 300
  records = [aws_eip.main[count.index].public_ip]

  lifecycle {
    create_before_destroy = true
  }
}

# CloudWatch Alarms for instance monitoring
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count = var.enable_monitoring ? length(var.instances) : 0

  alarm_name          = "${var.instances[count.index].name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold
  alarm_description   = "This metric monitors EC2 cpu utilization"
  treat_missing_data  = "notBreaching"

  dimensions = {
    InstanceId = aws_instance.main[count.index].id
  }

  alarm_actions = var.alarm_actions

  tags = var.instances[count.index].tags
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count = var.enable_monitoring ? length(var.instances) : 0

  alarm_name          = "${var.instances[count.index].name}-status-check-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"
  alarm_description   = "This metric monitors instance status check"
  treat_missing_data  = "breaching"

  dimensions = {
    InstanceId = aws_instance.main[count.index].id
  }

  alarm_actions = concat(
    var.alarm_actions,
    ["arn:aws:automate:${data.aws_region.current.name}:ec2:recover"]  # Auto-recover instance
  )

  tags = var.instances[count.index].tags
}

# EBS Volume attachments (for additional volumes)
resource "aws_ebs_volume" "additional" {
  for_each = { for vol in var.additional_volumes : "${vol.instance_index}-${vol.device_name}" => vol }

  availability_zone = aws_instance.main[each.value.instance_index].availability_zone
  size              = each.value.size
  type              = each.value.type
  encrypted         = true
  kms_key_id        = var.kms_key_id

  tags = merge(
    aws_instance.main[each.value.instance_index].tags,
    {
      Name = "${aws_instance.main[each.value.instance_index].tags.Name}-${each.value.device_name}"
    }
  )
}

resource "aws_volume_attachment" "additional" {
  for_each = { for vol in var.additional_volumes : "${vol.instance_index}-${vol.device_name}" => vol }

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.additional[each.key].id
  instance_id = aws_instance.main[each.value.instance_index].id
}

# Data sources
data "aws_region" "current" {}
