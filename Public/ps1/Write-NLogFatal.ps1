Function Write-NLogFatal { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    (Get-NLogLogger).Fatal($Message)
 }
