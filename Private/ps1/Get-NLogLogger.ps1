<#
.SYNOPSIS
    Retrieves an NLog logger instance, creating it if necessary.

.DESCRIPTION
    The `Get-NLogLogger` function is used to obtain an instance of an NLog logger 
    based on the specified logger name. If the logger does not already exist, it is 
    created and initialized with a default configuration. The function also supports 
    a `Force` switch that allows the user to create a new logger instance, even if 
    one already exists.

.PARAMETER LoggerName
    Specifies the name of the logger to retrieve. If no name is provided, the default 
    value "DefaultLoggerName" is used.

.PARAMETER Force
    When specified, this switch forces the creation of a new logger instance with the 
    provided logger name, even if an existing logger instance is already present.

.EXAMPLE
    $logger = Get-NLogLogger -LoggerName "MyLogger"
    This example retrieves the logger instance named "MyLogger". If it doesn't exist, 
    it will be created using the default configuration.

.EXAMPLE
    $logger = Get-NLogLogger -LoggerName "MyLogger" -Force
    This example retrieves a new logger instance named "MyLogger", even if there is 
    already a logger instance in the script.
#>
Function Get-NLogLogger { 
    param(
        [string]$LoggerName = "DefaultLoggerName",
        [switch]$Force
    )

    # Check if the logger instance has already been created
    if (!$Script:logger) {
        # Create a new logger instance and set the default configuration
        $Script:logger = [NLog.LogManager]::GetLogger($LoggerName)
        New-NLogConfiguration -Path "$($PSScriptRoot)\..\..\config\default.config" | Out-Null
    } elseif ($Force) {
        # Force switch to change the logger name (create a new logger)
        $Script:logger = [NLog.LogManager]::GetLogger($LoggerName)
    }

    # Return the logger instance
    return $Script:logger
}
