Function Get-NLogLogger { 
    param(
        [string]$LoggerName = "DefaultLoggerName",
        [switch]$Force
    )
    if(!$Script:logger){
        $Script:logger = [NLog.LogManager]::GetLogger($LoggerName)
        # Set Default Config
        New-NLogConfiguration -Path "$($PSScriptRoot)\..\..\config\default.config" | Out-Null
    }elseif($Force){
        # Force Switch to change Logger Name (Create a new Logger)
        $Script:logger = [NLog.LogManager]::GetLogger($LoggerName)
    }
    return $Script:logger
 }
