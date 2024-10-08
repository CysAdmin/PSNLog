# Load NLog Library
$nlogModule = [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object {$_.ManifestModule.Name -eq "NLog.dll"}
if(!$nlogModule){
    try {
        $localLibPath = "$($PSScriptRoot)\lib\NLog.5.3.4\lib\net45\NLog.dll"
        Add-Type -Path $localLibPath    
    }
    catch {
        Write-Error -Message "Cant Load NLog.dll!"
        return
    }    
}

Get-ChildItem -Path "$PSScriptRoot\Public\ps1" -Filter *.ps1 | ForEach-Object { . $_.FullName; Export-ModuleMember $_.BaseName }
Get-ChildItem -Path "$PSScriptRoot\Private\ps1" -Filter *.ps1 | ForEach-Object { . $_.FullName }

# Call to initialize the Logger Config
Get-NLogLogger 


