##################################################################################
# LOCALS
##################################################################################

locals {
  integer_min        = min(33, 29, 13, 4, 7, 49)
  integer_randomized = random_integer.random_int.result
  string_formatted = format("%s...%s...%s", "dev", "load", "prod")
  string_fromfile = file("./sometext.txt")
  string_tolower = lower("TroLoLo")
}