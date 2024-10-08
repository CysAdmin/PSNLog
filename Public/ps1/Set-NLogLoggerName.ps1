Function Set-NLogLoggerName {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    # Get-NLogLogger will also Udpate the Script Scope Variable
    Get-NLogLogger -Force -LoggerName $Name | Out-Null
}