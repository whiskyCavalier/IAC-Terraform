output "default_hostname" { value = azurerm_linux_function_app.fn.default_hostname }
output "url" { value = "https://${azurerm_linux_function_app.fn.default_hostname}/api/ping" }
