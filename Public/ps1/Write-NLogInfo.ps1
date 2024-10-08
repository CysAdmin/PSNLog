Function Write-NLogInfo { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    (Get-NLogLogger).Info($Message)
 }
