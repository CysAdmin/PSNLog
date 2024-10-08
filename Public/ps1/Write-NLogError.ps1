<#
.SYNOPSIS
    Writes an error log message using the NLog logger.

.DESCRIPTION
    The `Write-NLogError` function logs an error-level message using the currently 
    configured NLog logger. This function is useful for logging error information 
    during the execution of scripts, which can help in troubleshooting and monitoring.

.PARAMETER Message
    Specifies the error message to be logged. This parameter is mandatory and must 
    be provided by the user.

.EXAMPLE
    Write-NLogError -Message "An error occurred while processing the data."
    This example logs an error message saying "An error occurred while processing the data." 
    using the current NLog logger.
#>
Function Write-NLogError { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Log the error message using the currently configured NLog logger
    (Get-NLogLogger).Error($Message)
}
