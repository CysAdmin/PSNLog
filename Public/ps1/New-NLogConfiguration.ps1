<#
.SYNOPSIS
    Creates or loads an NLog configuration from a file or custom targets and rules.

.DESCRIPTION
    The `New-NLogConfiguration` function allows users to create a new NLog configuration 
    either by loading it from a specified configuration file or by defining custom targets 
    and logging rules. Depending on the parameter set used, the function either loads 
    an existing configuration or initializes a new one with specified logging rules and targets.

.PARAMETER Path
    Specifies the path to the configuration file from which to load the NLog settings. 
    This parameter is mandatory when using the "FromConfigFile" parameter set.

.PARAMETER Target
    Specifies the target to be added to the configuration. This should be an instance 
    of `NLog.Targets.Target`, such as a file target or console target. This parameter 
    is mandatory when using the "CustomTarget" parameter set.

.PARAMETER Rule
    Specifies the logging rule to be added to the configuration. This should be an 
    instance of `NLog.Config.LoggingRule`, which defines the levels, targets, and logger 
    name pattern for the logging behavior. This parameter is also mandatory when using 
    the "CustomTarget" parameter set.

.EXAMPLE
    New-NLogConfiguration -Path "C:\Path\To\NLog.config"
    This example loads the NLog configuration from the specified file.

.EXAMPLE
    $fileTarget = New-NLogTarget -FileName "C:\Logs\mylog.txt" -EnableArchiving
    $rule = New-NLogRule -Target $fileTarget -LogToTargetName "MyNamespace.*"
    New-NLogConfiguration -Target $fileTarget -Rule $rule
    This example creates a new logging target and rule, then initializes a new NLog 
    configuration with those settings.
#>
Function New-NLogConfiguration {
    param(        
        [Parameter(Mandatory = $true, ParameterSetName = "FromConfigFile")]
        [string]$Path,

        [Parameter(Mandatory = $true, ParameterSetName = "CustomTarget")]
        [NLog.Targets.Target]$Target,

        [Parameter(Mandatory = $true, ParameterSetName = "CustomTarget")]
        [NLog.Config.LoggingRule]$Rule
    )

    # Switch to determine which parameter set is being used
    switch ($PSCmdlet.ParameterSetName) {
        "FromConfigFile" {
            # Load NLog configuration from the specified file
            [NLog.LogManager]::LoadConfiguration($Path)
        }
        "CustomTarget" {
            # Create a new logging configuration and add the custom rule
            $config = [NLog.Config.LoggingConfiguration]::new()
            $config.AddRule($Rule)
            [NLog.LogManager]::Configuration = $config
        }
    }
}
