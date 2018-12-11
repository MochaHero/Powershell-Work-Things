## Used to check if a certain service is running ##

$remotenames = Get-Content -Path 'C:\powershell\PCnames.txt'

$Service = 'service'

foreach ($Server in $remotenames) {
    if (Get-WmiObject win32_service -ComputerName $Server | Where-Object {$_.name -eq $Service -and $_.state -eq 'Running'})
         {
         write-Host "$Server - service $service is running " -ForegroundColor Green
         }
         else {
         Write-Warning "$Server - service $service not running"
         }
}     