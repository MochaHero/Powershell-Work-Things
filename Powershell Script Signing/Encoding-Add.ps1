# Define your script as a script-block, with full functional syntax highlighting and line feeds
$script = {

Write-host "Hello!"

}

# Convert your script to a string
$command = $script.ToString()

# Use the conversion from the bottom of "Get-Help about_powershell.exe"
$bytes = [System.Text.Encoding]::Unicode.GetBytes( $command )
$encodedCommand = [Convert]::ToBase64String( $bytes )

$encodedCommand
