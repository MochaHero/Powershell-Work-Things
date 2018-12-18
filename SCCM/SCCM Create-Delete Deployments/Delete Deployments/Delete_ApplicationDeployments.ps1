## Must Run the script to connect to your site from SCCM
# Used to delete Application and Package deployments in SCCM
# Fill out "Delete_ApplicationDeployments.csv" with collections that you need to clear deployments from 
# Everything must be located within the script's directory unless changed in this script


# Determine script location
$ScriptPath = $MyInvocation.MyCommand.Path
$ScriptDir = Split-Path $ScriptPath
$CSVFile  = "$ScriptDir\Delete_ApplicationDeployments.csv"
$log      = "$ScriptDir\Delete_ApplicationDeployments.log"
$date     = Get-Date -Format "MM-dd-yyyy hh:mm:sstt"


"---------------------  Script started at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append

$vars=Import-CSV $CSVFile 

foreach ($var in $vars)
{

 $CollectionName=$var.CollectionName

## Deleting Application Deployments
Get-CMDeployment -CollectionName $CollectionName -FeatureType Application | Remove-CMDeployment -Force

if ($error) {
Write-Host "[ERROR]`t Could not delete Application Deployments for $($CollectionName). $error"
            "$date [ERROR]`t Could not delete Application Deployments for $($CollectionName). $error"| Out-File $log -append
            $error.Clear()
            }
    else {                    
    Write-Host "[INFO]`t Deleted Application Deployments for Collection : $($CollectionName)"
            "$date [INFO]`t Deleted Application Deployments for Collection : $($Collectionname)" | Out-File $log -append
         }

## Deleting Package Deployments
Get-CMDeployment -CollectionName $CollectionName -FeatureType Package | Remove-CMDeployment -Force


if ($error) {
Write-Host "[ERROR]`t Could not delete Package Deployments for $($CollectionName). $error"
            "$date [ERROR]`t Could not delete Application and/or Package Deployments for $($CollectionName). $error"| Out-File $log -append
            $error.Clear()
            }
    else {                    
    Write-Host "[INFO]`t Deleted Package Deployments for Collection : $($CollectionName)"
            "$date [INFO]`t Deleted Package Deployments for Collection : $($Collectionname)" | Out-File $log -append
         }
	}
  "---------------------  Script finished at $date (MM-dd-yyyy hh:mm:sstt) ---------------------" + "`r`n" | Out-File $log -append