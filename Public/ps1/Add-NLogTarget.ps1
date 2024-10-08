Function Add-NLogTarget {
    param(
        [NLog.Targets.Target]$Target
    )

    $config = [NLog.LogManager]::Configuration
    $rules = [NLog.LogManager]::Configuration.LoggingRules
    $config.AddTarget($Target)

    foreach($rule in $rules){
        $rule.Targets.Add($Target)
    }

    [NLog.LogManager]::Configuration = $config
}