## Only for Application deployments in SCCM. Must Run the script to connect to your site from SCCM
# Used to create multiple deployments at a time for multiple collections
# Fill out "Create_ApplicationDeployments.csv" with collections and software names to deploy
# Everything must be located within the script's directory unless changed in this script


# Determine script location
$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path $ScriptPath
$CSVFile  = "$ScriptDir\Create_ApplicationDeployments.csv"
$log      = "$ScriptDir\Create_ApplicationDeployments.log"
$date     = Get-Date -Format "MM-dd-yyyy hh:mm:sstt"
"---------------------  Script started at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append

$vars=Import-CSV $CSVFile

foreach ($var in $vars)
{

 $CollectionName=$var.CollectionName
 $SoftwareName=$var.SoftwareName
 $AvailableDateTime=$var.AvailableDateTime
 $DeadlineDateTime=$var.DeadlineDateTime
 $DeployAction=$var.DeployAction
 $DeployPurpose=$var.DeployPurpose
 $TimeBaseOn=$var.TimeBaseOn
 $UserNotification=$var.UserNotification



New-CMApplicationDeployment -CollectionName $CollectionName -Name $SoftwareName `
-AvailableDateTime $AvailableDateTime -DeadlineDateTime $DeadlineDateTime `
-DeployAction $DeployAction -DeployPurpose $DeployPurpose -TimeBaseOn $TimeBaseOn -UserNotification $UserNotification `
-SendWakeupPacket $True  -OverrideServiceWindow $false -PreDeploy $false -UpdateSupersedence $false `
-UseMeteredNetwork $False | out-null

## Only needed if DeployPurpose is "Available" 
#       -ApprovalRequired $False


if ($error) {
Write-Host "[ERROR]`t Could not create Application Deployment $($SoftwareName) for $($CollectionName) at $($AvailableDateTime). $error"
            "$date [ERROR]`t Could not create Application Deployment $($SoftwareName) for $($CollectionName) at $($AvailableDateTime). $error"| Out-File $log -append
            $error.Clear()
            }
    else {                    
    Write-Host "[INFO]`t Created Application Deployment $($SoftwareName) for Collection : $($CollectionName) at $($AvailableDateTime)"
            "$date [INFO]`t Created Application Deployment $($SoftwareName) for Collection : $($Collectionname) at $($AvailableDateTime)" | Out-File $log -append
         }
	}
  "---------------------  Script finished at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append