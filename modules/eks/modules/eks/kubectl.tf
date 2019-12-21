resource "local_file" "kubeconfig" {
  content  = "${data.template_file.kubeconfig.rendered}"
  filename = "${var.config_output_path}kubeconfig_${var.cluster_name}"
  count    = "${var.write_kubeconfig ? 1 : 0}"
}

resource "null_resource" "copy-kubeconfig" {
  depends_on = ["local_file.kubeconfig"]

  provisioner "local-exec" {
    command = "mkdir -p ~/.kube && cp ${var.config_output_path}kubeconfig_${var.cluster_name} ~/.kube/${var.environment}.${var.base_domain}"
  }
}

resource "null_resource" "copy-kubeconfig_destroy" {
  provisioner "local-exec" {
    when = destroy

    command = <<EOF
      rm -rf ~/.kube/${var.environment}.${var.base_domain}
      true
    EOF
  }
}
