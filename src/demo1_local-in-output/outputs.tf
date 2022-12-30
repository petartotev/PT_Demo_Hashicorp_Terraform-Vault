##################################################################################
# OUTPUTS
##################################################################################

# LOCALS
output "output_local_integer_min" {
  value       = local.integer_min
  description = "The value of local output_local_integer_min"
}

output "output_local_integer_randomized" {
  value       = local.integer_randomized
  description = "The value of local output_local_integer_randomized"
}

output "output_local_string_formatted" {
  value       = local.string_formatted
  description = "The value of local output_local_string_formatted"
}

output "output_local_string_fromfile" {
  value       = local.string_fromfile
  description = "The value of local output_local_string_fromfile"
}

output "output_local_string_tolower" {
  value       = local.string_tolower
  description = "The value of local output_local_string_tolower"
}
