### Template for creating a script that will output a custom log file ###


#Script Locations
$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path $ScriptPath

#Name of log file
$log      = "$ScriptDir\log.log"

#Date format for log file
$date     = Get-Date -Format "MM-dd-yyyy hh:mm:sstt"

"---------------------  Script started at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append
#### Begin Script ####

Write-host "[INFO]`t Information output"
    "$date [INFO]`t Information output" | Out-File $log -Append


Write-Error ("[ERROR]`t Error output. $error") -ErrorAction:Continue
            "$date [ERROR]`t Error output. $error" | Out-File $log -Append
            $error.Clear()


"---------------------  Script finished at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append