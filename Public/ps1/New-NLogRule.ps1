Function New-NLogRule {
    param(
        [Parameter(Mandatory = $true)]
        [NLog.Targets.Target]$Target,

        [string]$LogToTargetName = "*"
    )

    $newRule = [NLog.Config.LoggingRule]::new($LogToTargetName, [NLog.LogLevel]::Trace, $Target)
    return $newRule
}