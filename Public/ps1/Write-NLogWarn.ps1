<#
.SYNOPSIS
    Writes a warning log message using the NLog logger.

.DESCRIPTION
    The `Write-NLogWarn` function logs a warning-level message using the currently 
    configured NLog logger. This function is useful for logging potential issues 
    or cautionary messages during the execution of scripts, which may require 
    attention but do not necessarily indicate an error.

.PARAMETER Message
    Specifies the warning message to be logged. This parameter is mandatory and must 
    be provided by the user.

.EXAMPLE
    Write-NLogWarn -Message "This is a warning about potential issues."
    This example logs a warning message saying "This is a warning about potential issues." 
    using the current NLog logger.
#>
Function Write-NLogWarn { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Log the warning message using the currently configured NLog logger
    (Get-NLogLogger).Warn($Message)
}
