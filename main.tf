####### test file just for f

resource "null_resource" "sp" {

  provisioner "local-exec" {
      command = "printf \"hello from top level actions\""
  }
}
