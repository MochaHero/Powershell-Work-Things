## Only for Package deployments in SCCM. Must Run the script to connect to your site from SCCM
# Used to create multiple deployments at a time for multiple collections
# Fill out "Create_PackageDeployments.csv" with collections and software names to deploy
# Everything must be located within the script's directory unless changed in this script


# Determine script location
$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path $ScriptPath
$CSVFile  = "$ScriptDir\Create_PackageDeployments.csv"
$log      = "$ScriptDir\Create_PackageDeployments.log"
$date     = Get-Date -Format "dd-MM-yyyy hh:mm:ss"


"---------------------  Script started at $date (DD-MM-YYYY hh:mm:ss) ---------------------" + "`r`n" | Out-File $log -append

$vars=Import-CSV $CSVFile

foreach ($var in $vars)
{

 $CollectionName=$var.CollectionName
 $ProgramName=$var.ProgramName
 $PackageID=$var.PackageID
 $AvailableDateTime=$var.AvailableDateTime
 $DeployPurpose=$var.DeployPurpose
 


New-CMPackageDeployment `
    -StandardProgram `
    -CollectionName $CollectionName `
    -ProgramName $ProgramName `
    -PackageID $PackageID `
    -AvailableDateTime $AvailableDateTime `
    -DeployPurpose $DeployPurpose `
    -RerunBehavior RerunIfFailedPreviousAttempt `
    -RunFromSoftwareCenter $false `
    -ScheduleEvent AsSoonAsPossible `
    -SendWakeupPacket $true `
    -SystemRestart $false `
    -UseUtcForAvailableSchedule $false `
    -FastNetworkOption DownloadContentFromDistributionPointAndRunLocally `
    -SlowNetworkOption DownloadContentFromDistributionPointAndLocally | 
    Out-Null


if ($error) {
Write-Host "[ERROR]`t Could not create Package Deployment $($ProgramName) for Collection: $($CollectionName) at $($AvailableDateTime). $error"
            "$date [ERROR]`t Could not create Package Deployment $($ProgramName) for Collection: $($CollectionName) at $($AvailableDateTime). $error"| Out-File $log -append
            $error.Clear()
            }
    else {                    
    Write-Host "[INFO]`t Created Package Deployment $($ProgramName) for Collection: $($CollectionName) at $($AvailableDateTime)"
            "$date [INFO]`t Created Package Deployment $($ProgramName) for Collection: $($Collectionname) at $($AvailableDateTime)" | Out-File $log -append
         }
	}
  "---------------------  Script finished at $date (DD-MM-YYYY hh:mm:ss) ---------------------" + "`r`n" | Out-File $log -append