locals {
    somefile_formatted = templatefile("./sometemplatefile.sh", { test = "testotev" })
}