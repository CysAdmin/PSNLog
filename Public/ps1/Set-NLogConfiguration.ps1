Function Set-NLogConfiguration { 
    param(  
        [Parameter(Mandatory = $true, ParameterSetName = "CustomTarget")]
        [NLog.Config.LoggingRule]$Rule
    )

    $config = [NLog.LogManager]::Configuration
    return [NLog.LogManager]::Configuration
    $config.AddRule($Rule)
    [NLog.LogManager]::Configuration = $config
}