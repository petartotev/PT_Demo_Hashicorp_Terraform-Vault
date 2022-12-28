cd C:\Projects\PT_Demo_Terraform\src\demo2_vars-from-file-myfile-tfvars

terraform destroy # Optional, if not first init.

terraform init

terraform plan

terraform apply -var-file="myfile.tfvars"

# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# output_number_taken_from_file_myfile_tfvars = 501