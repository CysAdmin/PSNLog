<#
.SYNOPSIS
    Writes a fatal log message using the NLog logger.

.DESCRIPTION
    The `Write-NLogFatal` function logs a fatal-level message using the currently 
    configured NLog logger. This function is useful for logging critical error 
    information during the execution of scripts, which may indicate severe issues 
    that could lead to termination of the application or script.

.PARAMETER Message
    Specifies the fatal message to be logged. This parameter is mandatory and must 
    be provided by the user.

.EXAMPLE
    Write-NLogFatal -Message "A critical failure has occurred in the application."
    This example logs a fatal message saying "A critical failure has occurred in the application." 
    using the current NLog logger.
#>
Function Write-NLogFatal { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Log the fatal message using the currently configured NLog logger
    (Get-NLogLogger).Fatal($Message)
}
