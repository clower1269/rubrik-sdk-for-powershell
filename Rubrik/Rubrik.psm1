#Get public and private function definition files.
    $Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
    $Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
    Foreach($import in @($Public + $Private))
    {
        Try
        {
            . $import.fullname
        }
        Catch
        {
            Write-Error -Message "Failed to import function $($import.fullname): $_"
        }
    }

# Export the Public modules
Export-ModuleMember -Function $Public.Basename -Alias *

# Check for existance of options file
if (-not (Test-Path $Home\rubrik_sdk_for_powershell_options.json)) {
    Write-Host "Options file doesn't exist, creating default"
    Copy-Item -Path $PSScriptRoot\templates\rubrik_sdk_for_powershell_options.json -Destination $Home\
}
else {
    Write-Host "Options is there whoopiee"
}