Function New-NLogConfiguration {
    param(        
        [Parameter(Mandatory = $true, ParameterSetName = "FromConfigFile")]
        [string]$Path,

        [Parameter(Mandatory = $true, ParameterSetName = "CustomTarget")]
        [NLog.Targets.Target]$Target,

        [Parameter(Mandatory = $true, ParameterSetName = "CustomTarget")]
        [NLog.Config.LoggingRule]$Rule
    )
    switch ($PSCmdlet.ParameterSetName) {
        "FromConfigFile" {
            [NLog.LogManager]::LoadConfiguration($Path)
        }
        "CustomTarget"{
            # Append Current Config
            $config = [NLog.Config.LoggingConfiguration]::new()
            $config.AddRule($Rule)
            [NLog.LogManager]::Configuration = $config
        }
    }
}