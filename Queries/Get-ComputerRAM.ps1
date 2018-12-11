#Query computers to get information "Name, Model, Memory" 

$remotenames = Get-Content -Path 'C:\powershell\remotenames.txt'

Get-WmiObject -Class win32_computersystem -cn $remotenames -ErrorAction Silentlycontinue | 
Select-Object Name, Model, TotalPhysicalMemory -ErrorAction SilentlyContinue
