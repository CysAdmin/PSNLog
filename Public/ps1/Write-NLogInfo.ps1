<#
.SYNOPSIS
    Writes an informational log message using the NLog logger.

.DESCRIPTION
    The `Write-NLogInfo` function logs an informational message using the currently 
    configured NLog logger. This function is useful for logging general information 
    during the execution of scripts, which can provide context and status updates 
    during processing.

.PARAMETER Message
    Specifies the informational message to be logged. This parameter is mandatory 
    and must be provided by the user.

.EXAMPLE
    Write-NLogInfo -Message "The process has started successfully."
    This example logs an informational message saying "The process has started successfully." 
    using the current NLog logger.

#>
Function Write-NLogInfo { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Log the informational message using the currently configured NLog logger
    (Get-NLogLogger).Info($Message)
}
