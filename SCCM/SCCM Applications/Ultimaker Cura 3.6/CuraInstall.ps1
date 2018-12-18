<###Installation for Ultimaker Cura 3.6.0###>
<#ChangeLog
12/4/18 - Created Script to install Ultimaker Cura 3.6.0
            --Script will import Driver Certificates into the computer for Arduino devices.
                Certs have to be under the "Arduino Certificates" folder on the root of the script location.
            --Driver installation will begin after certificates are imported. Driver installation under "arduino" folder on the root of the script location.
                Has to be done in order to prevent failure of installation. Driver Certificates have to be added to Trusted publishers or else drivers will not install.
            --Script will check if existing firewal rules for Cura is already there before adding new ones to avoid duplication.
            --Cura install will install silently. No messages will pop up.
#>

#Script Locations
$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path $ScriptPath
$log      = "$ScriptDir\UltiCura-3.6.0-install.log"
$date     = Get-Date -Format "MM-dd-yyyy hh:mm:sstt"

#Certificate Locations
$certPutLocation = "Cert:\LocalMachine\TrustedPublisher"
$certFile = (Get-ChildItem -Path "$ScriptDir\Arduino Certificates\*" -Filter *.cer)
$certFilecheck = (Test-Path -Path "$ScriptDir\Arduino Certificates\*" -Include *.cer)

#Finding Firewall Rules for Cura
$getUDPFirewall = Get-NetFirewallPortFilter -Protocol UDP | Get-netfirewallrule
$domainUDP = $getUDPFirewall.displayname -match 'cura' -and $getUDPFirewall.Profile -match 'Domain'
$publicUDP = $getUDPFirewall.displayname -match 'cura' -and $getUDPFirewall.Profile -match 'Public'

$getTCPFirewall = Get-NetFirewallPortFilter -Protocol TCP | Get-netfirewallrule
$domainTCP = $getTCPFirewall.displayname -match 'cura' -and $getTCPFirewall.Profile -match 'Domain'
$publicTCP = $getTCPFirewall.displayname -match 'cura' -and $getTCPFirewall.Profile -match 'Public'


"---------------------  Script started at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append

#### Import Driver Certs for Cura Software ####
Write-host "[INFO]`t Importing Driver certificates.."
    "$date [INFO]`t Importing Driver certificates.." | Out-File $log -Append

if ($certFilecheck -eq $true) 
{
     Foreach ($cert in $certFile){
        try{
            $cert | Import-Certificate -CertStoreLocation $certPutLocation | Out-File $log -Append
            Write-host "[INFO]`t $cert successfully imported."
                "$date [INFO]`t $cert successfully imported." | Out-File $log -Append
        }
        catch {
            Write-Error ("[ERROR]`t Error adding '$certfile' to '$certPutLocation': $error") -ErrorAction:Continue
                "$date [ERROR]`t Error adding '$certfile' to '$certPutLocation': $error" | Out-File $log -Append
                 $error.Clear()
        }
    }
    
}
else {
    Write-Host "[INFO]`t No Certificates found in specified directory"
        "$date [INFO]`t No Certificates found in specified directory" | Out-File $log -Append
}


#### Begin Arduino Driver Install ####
Write-host "[INFO]`t Begin Arduino Driver Install..."
    "$date [INFO]`t Begin Arduino Driver Install..." | Out-File $log -Append

    try {
        Start-Process "$ScriptDir\arduino\dpinst-amd64.exe" -ArgumentList "/S /F" -Verbose -Wait | Out-File $log -Append
    }
    catch {
         Write-Error ("[ERROR]`t Error installing Arduino Drivers. $error") -ErrorAction:Continue
            "$date [ERROR]`t Error installing Arduino Drivers. $error" | Out-File $log -Append
            $error.Clear()
    }

Write-Host "[INFO]`t Arduino Drivers Installed"


#### Installing Firewall Rules for Cura Software ####

Write-host "[INFO]`t Adding Firewal rules as needed..."
    "$date [INFO]`t Adding Firewal rules as needed..." | Out-File $log -Append

    ## DomainUDP Rule
        if ($domainUDP -eq $true){
            Write-Host "[INFO]`t Firewall Rule Already Exists"
                "$date [INFO]`t Firewall Rule Already Exists" | Out-File $log -Append
        }
            else{
                Write-Host "[INFO]`t Firewall Rule does not exist. Adding New Rule"
                    "$date [INFO]`t Firewall Rule does not exist. Adding New Rule" | Out-File $log -Append
                New-NetFirewallRule -DisplayName cura -Profile Domain -Enabled True -Action Allow -Program 'C:\Program Files\Ultimaker Cura 3.6\Cura.exe'-Protocol UDP | Out-File $log -Append
            }
    ## PublicUDP Rule
        if ($publicUDP -eq $true){
            Write-Host "[INFO]`t Firewall Rule Already Exists"
                "$date [INFO]`t Firewall Rule Already Exists" | Out-File $log -Append
        }
            else{
                Write-Host "[INFO]`t Firewall Rule does not exist. Adding New Rule"
                    "$date [INFO]`t Firewall Rule does not exist. Adding New Rule" | Out-File $log -Append
                New-NetFirewallRule -DisplayName cura -Profile Public -Enabled True -Action Block -Program 'C:\Program Files\Ultimaker Cura 3.6\Cura.exe'-Protocol UDP | Out-File $log -Append
            }
    ## DomainTCP Rule
        if ($domainTCP -eq $true){
            Write-Host "[INFO]`t Firewall Rule Already Exists"
                "$date [INFO]`t Firewall Rule Already Exists" | Out-File $log -Append
        }
            else{
                Write-Host "[INFO]`t Firewall Rule does not exist. Adding New Rule"
                    "$date [INFO]`t Firewall Rule does not exist. Adding New Rule" | Out-File $log -Append
                New-NetFirewallRule -DisplayName cura -Profile Domain -Enabled True -Action Allow -Program 'C:\Program Files\Ultimaker Cura 3.6\Cura.exe'-Protocol TCP | Out-File $log -Append
            }
    ## PublicTCP Rule
        if ($publicTCP -eq $true){
            Write-Host "[INFO]`t Firewall Rule Already Exists"
                "$date [INFO]`t Firewall Rule Already Exists" | Out-File $log -Append
        }
            else{
                Write-Host "[INFO]`t Firewall Rule does not exist. Adding New Rule"
                    "$date [INFO]`t Firewall Rule does not exist. Adding New Rule" | Out-File $log -Append
                New-NetFirewallRule -DisplayName cura -Profile Public -Enabled True -Action Block -Program 'C:\Program Files\Ultimaker Cura 3.6\Cura.exe'-Protocol TCP | Out-File $log -Append
            }

Write-Host "[INFO]`t Firewall Rules added successfully"
    "$date [INFO]`t Firewall Rules added successfully" | Out-File $log -Append


#### Begin Install for Ultimaker Cura 3.6.0 ####
Write-Host "[INFO]`t Begin Ultimaker Cura 3.6.0 installation"
    "$date [INFO]`t Begin Ultimaker Cura 3.6.0 installation" | Out-File $log -Append

    try {
        Start-Process "$ScriptDir\Ultimaker_Cura-3.6.0-win64.exe" -ArgumentList "/S"  -Verbose -Wait | Out-File $log -Append
    }
        catch {
            Write-Error ("[ERROR]`t Error installing Ultimaker Cura 3.6.0. $error") -ErrorAction:Continue
                "$date [INFO]`t Error installing Arduino Drivers. $error" | Out-File $log -Append
                $error.Clear()
        }


Write-Host "[INFO]`t Ultimaker Cura 3.6.0 installation completed"
    "$date [INFO]`t Ultimaker Cura 3.6.0 installation completed" | Out-File $log -Append

$LASTEXITCODE | Out-File $log -Append
Exit $LASTEXITCODE
    
     
"---------------------  Script finished at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append


