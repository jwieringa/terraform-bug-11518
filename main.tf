module "example" {
  source    = "module"
  volume_id = "${aws_ebs_volume.main.id}"
}

resource "aws_ebs_volume" "main" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp2"
  encrypted         = true
}
