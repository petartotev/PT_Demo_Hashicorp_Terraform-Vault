# One can associate provisioners that aren't directly associated with a specific resource using a null_resource.
resource "null_resource" "command-executer" {
  # local-exec provisioner invokes a local executable after a resource is created.
  # This invokes a process on the machine running Terraform, not on the resource.
  provisioner "local-exec" {
    command     = "mkdir C:\\Users\\petar\\Desktop\\local-exec-provisioner-folder"
    interpreter = ["PowerShell", "-Command"] # optional, if not set => OS's default.
  }
}