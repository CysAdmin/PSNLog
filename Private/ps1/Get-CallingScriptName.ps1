Function Get-CallingScriptName {
    write-host (Get-PSCallStack)[-2]
    $callingScriptName = (Get-PSCallStack)[-2]
    if($callingScriptName -and ($callingScriptName.Location -contains "<No file>")){
        # Get the Filename
        $callingScriptName = $callingScriptName.Location.split(".")[0]
    }else{
        $callingScriptName = "Console?"
    }
    return $callingScriptName
}