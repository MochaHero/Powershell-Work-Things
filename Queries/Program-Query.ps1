## Finds application and checks version number

$remotenames = Get-Content -Path 'C:\powershell\computers.txt'

$programname = 'Program Name'

Get-WmiObject win32_product -ComputerName $remotenames | 
    Where-Object {$_.name -imatch $programname} | 
    select-object PSComputername, Name, Version
