cd C:\Projects\PT_Demo_Terraform\src\demo1_local-in-output

terraform destroy # optional, if not first init

terraform init

terraform plan

terraform apply

# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# output_local_integer_min = 4
# output_local_integer_randomized = 90
# output_local_string_tolower = "trololo"