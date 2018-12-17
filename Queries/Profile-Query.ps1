#Query User profiles - will show Computer Name, Path, and SID

$remotenames= Get-Content -Path 'C:\powershell\remotenames.txt'

Get-WmiObject win32_userprofile -ComputerName $remotenames -ErrorAction SilentlyContinue | 

Where-Object -FilterScript {
                ($_.SID -notcontains 'S-1-5-20') -and 
                ($_.SID -notcontains 'S-1-5-19') -and 
                ($_.SID -notcontains 'S-1-5-18')
                } | 

Select-Object PSComputerName, SID, LocalPath | Format-table -AutoSize
 