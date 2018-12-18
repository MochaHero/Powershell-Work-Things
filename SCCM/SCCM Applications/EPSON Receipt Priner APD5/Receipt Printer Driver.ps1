<# Installation of APD 5 Receipt Printer
This script will uninstal any existing APD 4 or 5 Receipt printer installed on the computer and instal the most up to date drivers with the custom settings

Location for APD 5 install logs: C:\ProgramData\EPSON\EPSON Advanced Printer Driver 5\CopyInstallLog\CopyInstallLog.txt
Location for APD 4 install logs: "C:\Windows\Apd4Setup.log"

#>
#Set Variables for Get commands
$getprinter = Get-printer
$getprinterdriver = Get-PrinterDriver

#Script Locations
$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path $ScriptPath
$log      = "$ScriptDir\ADP5Receipt-Install.log"
$date     = Get-Date -Format "MM-dd-yyyy hh:mm:sstt"

#### Find Epson Program GUIDs ####
$installedprograms = get-wmiobject Win32_Product
$Epson = $installedprograms | Where-Object {$_.name -match "EPSON*"}
$EpsonGUIDs = $Epson | Select-Object IdentifyingNumber

"---------------------  Script started at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append

### Begin Uninstall Receipt printer with  (APD 5 Receipt printer install) ###
Write-Host "[INFO]`t Uninstalling Epson Advanced Printer Driver 5 if installed"
    "$date [INFO]`t Uninstalling Epson Advanced Printer Driver" | Out-File $log -Append
Start-Process "$ScriptDir\APD_510_T88V.exe" -ArgumentList "/s /uninstall /rN" -Verbose -wait | out-file $log -Append

### Begin Uninstall Receipt printer with  (APD 4 Receipt printer install) ###
Write-Host "[INFO]`t Uninstalling Epson Advanced Printer Driver 4 if installed"
    "$date [INFO]`t Uninstalling Epson Advanced Printer Driver" | Out-File $log -Append
Start-Process "$ScriptDir\APD_456dE.exe" -ArgumentList "/s /uninstall /rN" -Verbose -wait | out-file $log -Append



### Removing Print queue for Receipt Printer ### 
Write-Host "[INFO]`t Checking for Existing Receipt Printer queue"
    "$date [INFO]`t [INFO]`t Checking for Existing Receipt Printer queue" | Out-File $log -Append
if ($getprinter.name -match 'Receipt*'){
    Write-Host "[INFO]`t Found Receipt Printer queue. Removing..."
        "$date [INFO]`t Found Receipt Printer queue. Removing..." | Out-File $log -Append
    Remove-Printer 'Receipt*';
    Write-Host "[INFO]`t Successfully deleted Receipt printer Print queue"
        "$date [INFO]`t Successfully deleted Receipt printer Print queue" | Out-File $log -append
    }
    
    else{
        Write-Host "[INFO]`t Print queue does not exist $error"
            "$date [INFO]`t Print queue does not exist $error" | Out-File $log -append
        $error.Clear()
        }

### Removing Receipt Printer Driver ###    
Write-Host "[INFO]`t Checking for Existing EPSON Printer Driver"
    "$date [INFO]`t Checking for Existing EPSON Printer Driver" | Out-File $log -Append
if ($getprinterdriver.name -like '*EPSON TM*'){
    Write-Host "[INFO]`t Found EPSON Printer Driver. Removing..."
        "$date [INFO]`t Found Epson Printer Driver. Removing..." | Out-File $log -Append
    Remove-PrinterDriver -name *EPSON TM* ;
    Write-Host "[INFO]`t Successfully deleted EPSON Printer Driver"
        "$date [INFO]`t Successfully deleted EPSON Printer Driver" | Out-File $log -append
    }


#### Begin MSI Uninstall for each Epson Program ####
Write-Host "[INFO]`t Checking for existing EPSON Programs"
    "$date [INFO]`t Checking for existing EPSON Programs" | Out-File $log -Append
foreach ($EpsonProgram in $EpsonGUIDs.IdentifyingNumber){
        Write-Host "[INFO]`t Found EPSON Program. Uninstalling $EpsonProgram"
            "$date [INFO]`t Found EPSON Program. Uninstalling $EpsonProgram" | Out-File $log -Append
	Start-Process -filepath "MSIExec.exe" -ArgumentList "/x $EpsonProgram /qn /l*v .\'$EpsonProgram'.log /norestart" -wait
}


#### Begin New Receipt printer installation (APD 5 Receipt printer install) ####
Write-Host "[INFO]`t Begin Installation of new Receipt Printer"
    "$date [INFO]`t Begin Installation of new Receipt Printer" | Out-File $log -Append
Start-Process "$ScriptDir\Apd5 Receipt.exe" -Verbose -wait | out-file $log -Append
Write-Host "[INFO]`t Installation of new Receipt Printer Driver Complete"
    "$date [INFO]`t Installation of new Receipt Printer Driver Complete" | Out-File $log -Append

    $LASTEXITCODE | Out-File $log -Append
    Exit $LASTEXITCODE
    
     
"---------------------  Script finished at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append
