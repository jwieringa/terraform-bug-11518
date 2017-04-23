variable "volume_id" {}

data "aws_ami" "coreos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CoreOS-stable-*-hvm"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["595879546273"] # CoreOS
}

resource "aws_launch_configuration" "main" {
  name_prefix   = "main"
  image_id      = "${data.aws_ami.coreos.id}"
  instance_type = "t2.micro"
  user_data     = "${data.ignition_config.example.rendered}"
}

data "template_file" "env" {
  template = "${file("${path.module}/default.env")}"

  vars {
    VOLUME_ID = "${var.volume_id}"
  }
}

data "ignition_file" "env" {
  filesystem = "root"
  path       = "/etc/default.env"

  content {
    content = "${data.template_file.env.rendered}"
  }
}

data "ignition_systemd_unit" "hello" {
  name    = "hello.service"
  content = "[Service]\nType=oneshot\nExecStart=/usr/bin/echo Hello Fbar World\n\n[Install]\nWantedBy=multi-user.target"
}

data "ignition_config" "example" {
  systemd = [
    "${data.ignition_systemd_unit.hello.id}",
  ]

  files = [
    "${data.ignition_file.env.id}",
  ]
}
