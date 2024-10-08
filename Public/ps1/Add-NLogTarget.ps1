<#
.SYNOPSIS
    Adds a new target to the NLog configuration and associates it with existing logging rules.

.DESCRIPTION
    The `Add-NLogTarget` function allows users to add a new logging target to the NLog configuration. 
    Once a target is added, it is associated with all existing logging rules, allowing log messages 
    to be sent to the new target. This function does not replace existing targets; instead, it 
    extends the functionality of the existing rules.

.PARAMETER Target
    Specifies the target to be added. This should be an instance of `NLog.Targets.Target`, 
    such as a file target, console target, etc.

.EXAMPLE
    $fileTarget = New-NLogTarget -FileName "C:\Logs\mylog.txt" -EnableArchiving
    Add-NLogTarget -Target $fileTarget

    This example creates a new file target and adds it to the NLog configuration, 
    associating it with all existing logging rules.
#>
Function Add-NLogTarget {
    param(
        [Parameter(Mandatory = $true)]
        [NLog.Targets.Target]$Target
    )

    # Retrieve the current NLog configuration
    $config = [NLog.LogManager]::Configuration
    
    # Get existing logging rules
    $rules = $config.LoggingRules

    # Add the new target to the NLog configuration
    $config.AddTarget($Target)

    # Associate the new target with all existing logging rules
    foreach ($rule in $rules) {
        $rule.Targets.Add($Target)
    }

    # Apply the updated configuration back to NLog
    [NLog.LogManager]::Configuration = $config
}
