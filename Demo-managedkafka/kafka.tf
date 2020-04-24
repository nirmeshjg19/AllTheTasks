

resource "aws_kms_key" "kms" {
  description = "example"
}

resource "aws_cloudwatch_log_group" "test" {
  name = "msk_broker_logs"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "demo-mks-terraform"
  acl    = "private"
}
resource "aws_security_group" "sg" {
  vpc_id = "${aws_vpc.app-vpc.id}"
}

resource "aws_kinesis_firehose_delivery_stream" "test_stream" {
  name        = "terraform-kinesis-firehose-msk-broker-logs-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${aws_s3_bucket.bucket.arn}"
  }

  tags = {
    LogDeliveryEnabled = "placeholder"
  }

  lifecycle {
    ignore_changes = [
      tags["LogDeliveryEnabled"],
    ]
  }
}


resource "aws_msk_cluster" "msk-demo" {
  cluster_name           = "msk-demo"
  kafka_version          = "2.2.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    ebs_volume_size = 10
    client_subnets = [
      "${aws_subnet.app-vpc-public.id}",
      "${aws_subnet.app-vpc-public-1.id}",
    ]
    security_groups = ["${aws_security_group.allow-traffic.id}"]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = "${aws_kms_key.kms.arn}"
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = "${aws_cloudwatch_log_group.test.name}"
      }
      firehose {
        enabled         = true
        delivery_stream = "${aws_kinesis_firehose_delivery_stream.test_stream.name}"
      }
      s3 {
        enabled = true
        bucket  = "${aws_s3_bucket.bucket.id}"
        prefix  = "logs/msk-"
      }
    }
  }

  
}

