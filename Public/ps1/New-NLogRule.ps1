<#
.SYNOPSIS
    Creates a new logging rule for NLog that directs log messages to a specified target.

.DESCRIPTION
    The `New-NLogRule` function constructs a new logging rule for NLog, which defines how 
    log messages are processed and where they are sent. The rule specifies the logger name pattern 
    and the logging level, along with the target that will receive the log messages. 
    By default, the logger name pattern is set to "*", which matches all loggers.

.PARAMETER Target
    Specifies the logging target to which the log messages will be sent. This should be 
    an instance of `NLog.Targets.Target`, such as a file target, console target, etc.

.PARAMETER LogToTargetName
    Specifies the logger name pattern that the rule applies to. The default value is "*", 
    which means all loggers will be matched. You can provide a more specific pattern if needed.

.EXAMPLE
    $fileTarget = New-NLogTarget -FileName "C:\Logs\mylog.txt" -EnableArchiving
    $rule = New-NLogRule -Target $fileTarget -LogToTargetName "MyNamespace.*"
    
    This example creates a new logging rule for all loggers in the "MyNamespace" namespace 
    that directs log messages to a file target.
#>
Function New-NLogRule {
    param(
        [Parameter(Mandatory = $true)]
        [NLog.Targets.Target]$Target,

        [string]$LogToTargetName = "*"
    )

    # Create a new logging rule with the specified target and logger name pattern
    $newRule = [NLog.Config.LoggingRule]::new($LogToTargetName, [NLog.LogLevel]::Trace, $Target)
    
    # Return the newly created logging rule
    return $newRule
}
