Function Write-NLogDebug { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    (Get-NLogLogger).Debug($Message)
 }
