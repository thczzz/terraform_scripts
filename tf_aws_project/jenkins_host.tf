resource "aws_instance" "vprofile-jenkins-host" {
  ami                         = lookup(var.AMIS, var.AWS_REGION)
  instance_type               = "t2.small"
  key_name                    = aws_key_pair.tfkey.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  count                       = var.instance_count
  vpc_security_group_ids      = [aws_security_group.vprofile-jenkins-sg.id]
  associate_public_ip_address = "true"

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name    = "vprofile-jenkins-host"
    PROJECT = "vprofile"
  }

  provisioner "file" {
    content = templatefile("templates/application.properties_deploy.tmpl",
      {
        db_host        = aws_db_instance.vprofile-rds.address,
        dbuser         = var.dbuser,
        dbpass         = var.dbpass,
        memcached_host = aws_elasticache_cluster.vprofile-cache.cluster_address,
        rmq_host       = aws_mq_broker.vprofile-rmq.instances.0.ip_address,
        rmq_port       = 5671,
        rmq_username   = var.rmquser,
        rmq_password   = var.rmqpass
      }
    )
    destination = "application.properties"
  }

  provisioner "file" {
    source      = "scripts/jenkins_setup.sh"
    destination = "/tmp/jenkins_setup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/jenkins_setup.sh",
      "/tmp/jenkins_setup.sh"
    ]
  }

  connection {
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }

  depends_on = [
    aws_db_instance.vprofile-rds,
    aws_elasticache_cluster.vprofile-cache,
    aws_mq_broker.vprofile-rmq,
    aws_elastic_beanstalk_environment.vprofile-bean-prod
  ]
}
