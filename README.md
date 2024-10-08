# PowerShell NLog Module

## Overview
The PowerShell NLog Module provides a simple and flexible way to integrate NLog logging into your PowerShell scripts. It allows users to log messages at various levels (Debug, Info, Warn, Error, Fatal) and manage logging configurations easily.

## Features
- **Logging Levels**: Supports multiple logging levels (Trace, Debug, Info, Warn, Error, Fatal).
- **Custom Targets**: Create and manage custom logging targets (currently file & console implemented).
- **Dynamic Configuration**: Load configurations from files or create rules on-the-fly.
- **Easy Integration**: Simple functions to log messages without complex setups.

## Installation
To install the module, clone this repository and import the module into your PowerShell session.

### Clone the Repository
```bash
git clone https://github.com/CysAdmin/PSNLog
```

## Usage
### Geting Started
#### If no config set before calling the Write-Nlog* Functions, a default Config will be used (see config\default.config)
```powershell
Write-NLogError -Message "This Is A Error Message!"
```

### Update Configuration (Add new File Target)
```powershell
$newTarget = New-NLogTarget -FileName "c:\logs\myLog.log"
$newRule = New-NLogRule -Target $newTarget
Set-NLogConfiguration -Rule $newRule
```

### Change Logger Name
```powershell
Set-NLogLoggerName -LoggerName "MynewLogger"
```

### Apply New Configuration From Config File
```powershell
New-NLogConfiguration -Path "c:\path\to\config"
```

### Apply New Configuration From Code
```powershell
$newTarget = New-NLogTarget -FileName "c:\logs\myLog.log"
$newRule = New-NLogRule -Target $newTarget
New-NLogConfiguration -Target $newTarget -Rule $newRule
```



