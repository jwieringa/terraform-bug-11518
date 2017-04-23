## Replication of GH issue https://github.com/hashicorp/terraform/issues/11518

```
$ terraform get
Get: file:///tf-11518/module
$ terraform apply
data.ignition_systemd_unit.hello: Refreshing state...
data.aws_ami.coreos: Refreshing state...
aws_ebs_volume.main: Creating...
  availability_zone: "" => "us-east-1a"
  encrypted:         "" => "true"
  iops:              "" => "<computed>"
  kms_key_id:        "" => "<computed>"
  size:              "" => "1"
  snapshot_id:       "" => "<computed>"
  type:              "" => "gp2"
aws_ebs_volume.main: Still creating... (10s elapsed)
aws_ebs_volume.main: Creation complete (ID: vol-076b4950513b670ed)
module.example.data.template_file.env: Refreshing state...
module.example.data.ignition_file.env: Refreshing state...
module.example.data.ignition_config.example: Refreshing state...
Error applying plan:

1 error(s) occurred:

* module.example.data.ignition_config.example: data.ignition_config.example: invalid systemd unit "4ff28b9094f7fdeda095e0e45d14e3b15706cba72526783ea8fc114e139d85f3", unknown systemd unit id

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.
```
