<#
.SYNOPSIS
    Writes a debug log message using the NLog logger.

.DESCRIPTION
    The `Write-NLogDebug` function logs a debug-level message using the currently 
    configured NLog logger. This function is useful for logging debug information 
    during the execution of scripts, which can help in troubleshooting and monitoring.

.PARAMETER Message
    Specifies the debug message to be logged. This parameter is mandatory and must 
    be provided by the user.

.EXAMPLE
    Write-NLogDebug -Message "This is a debug message."
    This example logs a debug message saying "This is a debug message." using the 
    current NLog logger.
#>
Function Write-NLogDebug { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Log the debug message using the currently configured NLog logger
    (Get-NLogLogger).Debug($Message)
}
