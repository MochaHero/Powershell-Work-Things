#Query computers to get information "Name, Serial, Model" - Exports to powershell folder in C Drive

$remotenames = Get-Content -Path 'C:\Users\michael.mclehany\OneDrive - Harris County Public Library\Powershell\remotenames.txt'

Get-WmiObject -Class win32_computersystemproduct -Credential $c -ComputerName 10.116.40.20 | 
Select-Object PSComputerName, IdentifyingNumber, Name
#Export-Csv C:\~Powershell\Serial.csv -NoTypeInformation -APPEND
