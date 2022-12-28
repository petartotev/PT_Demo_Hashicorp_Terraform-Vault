##################################################################################
# LOCALS
##################################################################################

locals {
  string_tolower = lower("TroLoLo")
  integer_min        = min(33, 29, 13, 4, 7, 49)
  integer_randomized = random_integer.random_int.result
}