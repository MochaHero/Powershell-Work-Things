$ADMerror.clear()
$checkADM = Get-HotFix -Id KB2693643 -ErrorAction silentlycontinue -ErrorVariable ADMerror | out-null
$checkADM;
    if ($ADMerror){
        Write-Output "RSAT Tools are not installed. Please install RSAT tools from the Microsoft Website"
    }
    else {
        Write-Output "RSAT Tools are installed. Continuing..."

    }

$checkMSOerror.clear()
$CheckMSO = Get-installedModule -Name MSOnline -ErrorAction SilentlyContinue -ErrorVariable CheckMSOerror | Out-Null
$checkMSO
    if ($checkMSOerror) {
        Write-Output 'Not Installed, Installing MSOnline Module needed for Office 365 License assignment'
        Install-Module MSOnline -Force
        }
    else{
    write-output "MSOnline module is installed. Continuing..."
    }


