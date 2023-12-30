cd C:\Projects\PT_Demo_Terraform\src\demo2_vars-from-env-vars

$env:TF_VAR_number_taken_from_env_var=2023

dir env: # Check if TF_VAR_number_taken_from_env_var is in the list.

terraform destroy # Optional, if not first init.

terraform init

terraform plan

terraform apply

# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# output_number_taken_from_env_var = 2023

# TODO: Find a PowerShell command to delete the env var!

dir env: # Check if TF_VAR_number_taken_from_env_var is in the list.