<#
.SYNOPSIS
    Retrieves the name of the calling script or indicates that it was called from the console.

.DESCRIPTION
    The `Get-CallingScriptName` function is used to identify the script from which it was called. 
    It inspects the PowerShell call stack to determine the calling script's location. 
    If the script was executed from the console or an interactive session, it returns "Console?". 
    Otherwise, it extracts and returns the filename of the calling script (without the file extension).

.EXAMPLE
    Get-CallingScriptName

    This example retrieves the name of the script that called this function.
    If the function was called from the console, it will return "Console".

#>
Function Get-CallingScriptName {
    # Output the second-to-last element in the call stack (i.e., the calling script)
    Write-Host (Get-PSCallStack)[-2]

    # Get the calling script's location from the call stack
    $callingScriptName = (Get-PSCallStack)[-2]

    # Check if the calling script is from a file or from an interactive session (console)
    if ($callingScriptName -and ($callingScriptName.Location -contains "<No file>")) {
        # Extract the script name (without extension) if it was from a file
        $callingScriptName = $callingScriptName.Location.split(".")[0]
    } else {
        # If the script was called from the console, return "Console?"
        $callingScriptName = "Console"
    }

    # Return the calling script's name or "Console?"
    return $callingScriptName
}
