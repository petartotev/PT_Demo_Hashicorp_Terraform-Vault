cd C:\Projects\PT_Demo_Terraform\src\demo2_vars-from-cmd-apply

terraform destroy # Optional, if not first init.

terraform init

terraform plan

terraform apply -var="number_overridden_by_apply_command=55"

# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# output_number_overridden_by_apply_command = 55