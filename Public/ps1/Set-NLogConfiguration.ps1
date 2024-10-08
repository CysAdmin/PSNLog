<#
.SYNOPSIS
    Sets a new logging rule in the NLog configuration.

.DESCRIPTION
    The `Set-NLogConfiguration` function updates the NLog configuration by adding a new logging rule.
    This function requires a `LoggingRule` object that specifies the logging level, target(s), 
    and the logger name pattern. The updated configuration is applied immediately, allowing logging to 
    reflect the new settings.

.PARAMETER Rule
    Specifies the logging rule to be added. This should be an instance of 
    `NLog.Config.LoggingRule`, which defines the levels, targets, and logger name pattern 
    for the logging behavior.

.EXAMPLE
    $rule = New-Object NLog.Config.LoggingRule("MyNamespace.*", [NLog.LogLevel]::Info, "ConsoleTarget")
    Set-NLogConfiguration -Rule $rule

    This example creates a new logging rule for all loggers in the namespace "MyNamespace" 
    with an Info level that logs to the "ConsoleTarget" and sets it in the NLog configuration.
#>
Function Set-NLogConfiguration { 
    param(  
        [Parameter(Mandatory = $true, ParameterSetName = "CustomTarget")]
        [NLog.Config.LoggingRule]$Rule
    )

    # Retrieve the current NLog configuration
    $config = [NLog.LogManager]::Configuration
    
    # Add the new rule to the configuration
    $config.AddRule($Rule)
    
    # Apply the updated configuration back to NLog
    [NLog.LogManager]::Configuration = $config

    # Return the updated configuration (optional)
    return $config
}
