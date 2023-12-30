##################################################################################
# VARIABLES
##################################################################################

variable "number_taken_from_file_auto_tfvars" {
  type = number
  # default = random_integer.random_int.result # Error: Variables not allowed. Variables may not be used here.
  # default = local.integer_randomized # Error: Variables not allowed. Variables may not be used here.
  # default = min(33,29,13,4,7,49) # Error: Function calls not allowed. Functions may not be called here.
  default = 0
}
