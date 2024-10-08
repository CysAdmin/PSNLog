<#
.SYNOPSIS
    Creates a new NLog target for logging, either to a file or the console.

.DESCRIPTION
    The `New-NLogTarget` function allows the user to define a new logging target using NLog.
    It supports two types of targets: a file target with optional archiving and a console target.
    Users can specify parameters such as the file name, archiving options, encoding, and layout for the logs.

.PARAMETER FileName
    Specifies the name of the log file for the FileTarget. This parameter is mandatory for the FileTarget.

.PARAMETER EnableArchiving
    Indicates whether archiving of log files is enabled. When set, log files will be archived based on the specified size.

.PARAMETER ArchiveAboveSize
    Specifies the size in bytes above which the log file will be archived. The default value is 5,000,000 bytes (5 MB).

.PARAMETER MaxArchiveFiles
    Sets the maximum number of archived log files to keep. The default is 5 files.

.PARAMETER Encoding
    Specifies the encoding to be used for the log file. Common options include UTF-8, ASCII, or UTF-16. The default is UTF-8.

.PARAMETER KeepFileOpen
    Indicates whether to keep the log file open for writing. If specified, it will ensure the file remains open until the process is terminated.

.PARAMETER Targetname
    Specifies the name of the logging target. The default name is "NewTarget".

.PARAMETER Layout
    Defines the layout format for log messages. The default layout includes the date, log level, logger name, and message.

.EXAMPLE
    $fileTarget = New-NLogTarget -FileName "C:\Logs\mylog.txt" -EnableArchiving -MaxArchiveFiles 10 -Encoding [System.Text.Encoding]::UTF8
    This example creates a new FileTarget with archiving enabled, specifying a maximum of 10 archived log files.

.EXAMPLE
    $consoleTarget = New-NLogTarget -Targetname "ConsoleLoggingTarget" -Layout "${longdate} [${level}] ${message}"
    This example creates a new ConsoleTarget with a custom layout for the log messages.
#>
Function New-NLogTarget {
    [CmdletBinding(DefaultParameterSetName = "ConsoleTarget")]
    param(
        # Currently Defaults to ConsoleTarget
        [Parameter(Mandatory = $true, ParameterSetName = "FileTarget")]
        [string]$FileName,

        [Parameter(ParameterSetName = "FileTarget")]
        [switch]$EnableArchiving,

        [Parameter(ParameterSetName = "FileTarget")]
        [int]$ArchiveAboveSize = 5000000, # 5 MB

        [Parameter(ParameterSetName = "FileTarget")]
        [int]$MaxArchiveFiles = 5,

        [Parameter(ParameterSetName = "FileTarget")]
        [System.Text.Encoding]$Encoding = [System.Text.Encoding]::UTF8, # "utf-8", "ascii" or "utf-16"

        [Parameter(ParameterSetName = "FileTarget")]
        [switch]$KeepFileOpen,

        [Parameter(ParameterSetName = "FileTarget")]
        [Parameter(ParameterSetName = "ConsoleTarget")]
        [string]$Targetname = "NewTarget",

        [Parameter(ParameterSetName = "FileTarget")]
        [Parameter(ParameterSetName = "ConsoleTarget")]
        [string]$Layout = '${longdate} [${level:uppercase=true}] ${logger}: ${message}'
    )

    switch ($PSCmdlet.ParameterSetName){
        "FileTarget"{
            $newTarget = [NLog.Targets.FileTarget]::new($Targetname)
            $newTarget.Layout = $Layout
            $newTarget.FileName = $FileName
            $newTarget.Encoding = $Encoding
            $newTarget.KeepFileOpen = $KeepFileOpen # Ensure the file is closed after each write
            $newTarget.ConcurrentWrites = $true

            if ($EnableArchiving) {
                $archivPath = (Split-Path -Path $FileName) + "\archive"
                $archiveFileName = (Split-Path -Path $FileName -Leaf)
                $newTarget.ArchiveFileName = "$($archivPath)\$($archiveFileName)" + '.{#}'
                $newTarget.ArchiveAboveSize = $ArchiveAboveSize
                $newTarget.MaxArchiveFiles = $MaxArchiveFiles
                $newTarget.ArchiveNumbering = 'Sequence'
            }
        }

        "ConsoleTarget" {
            $newTarget = [NLog.Targets.ConsoleTarget]::new($Targetname)
            $newTarget.Layout = $Layout
        }

        default {
            throw "Something went wrong - change this log to something better"
        }
    }

    return $newTarget
}
