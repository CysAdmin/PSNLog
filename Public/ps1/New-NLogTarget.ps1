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

            if($EnableArchiving){
                $archivPath = (Split-Path -Path $FileName) + "\archive"
                $archiveFileName = (Split-Path -Path $FileName -Leaf)
                $newTarget.ArchiveFileName = "$($archivPath)\$($archiveFileName)" + '.{#}'
                $newTarget.ArchiveAboveSize = $ArchiveAboveSize
                $newTarget.MaxArchiveFiles = $MaxArchiveFiles
                $newTarget.ArchiveNumbering = 'Sequence'
            }            
        }

        "ConsoleTarget"{
            $newTarget = [NLog.Targets.ConsoleTarget]::new($Targetname)
            $newTarget.Layout = $Layout
        }
        default {
            throw "something went wrong - change this log to something better"
        }
    }

    return $newTarget
}