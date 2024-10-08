Function Write-NLogWarn { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    (Get-NLogLogger).Warn($Message)
 }
