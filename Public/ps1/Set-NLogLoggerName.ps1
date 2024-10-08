<#
.SYNOPSIS
    Sets the name of the NLog logger by retrieving it with the specified name.

.DESCRIPTION
    The `Set-NLogLoggerName` function updates the name of the NLog logger. It forces 
    the `Get-NLogLogger` function to create or update the logger instance with the 
    specified name. This function is useful for scenarios where the logger's name needs 
    to be changed dynamically.

.PARAMETER LoggerName
    Specifies the name of the logger to set. This parameter is mandatory and must be 
    provided by the user.

.EXAMPLE
    Set-NLogLoggerName -Name "MyNewLogger"
    This example sets the name of the NLog logger to "MyNewLogger". If the logger 
    already exists, it will be updated with this new name.
#>
Function Set-NLogLoggerName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$LoggerName
    )

    # Get-NLogLogger will also update the script scope variable with the new logger name
    Get-NLogLogger -Force -LoggerName $LoggerName | Out-Null
}
