Function Write-NLogError { 
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )
    (Get-NLogLogger).Error($Message)
 }
