#Query computers in Active Directory to get information "Name, Serial, Model" - Exports to powershell folder in C Drive

$OU = ""
$DC1 = ""
$DC2 = ""

$serverFQDN = ""

$adcomputer = (Get-ADComputer -server $serverFQDN -Filter * -SearchBase "OU=$OU,DC=$DC1,DC=$DC2").name


Get-WmiObject -Class win32_computersystemproduct -ComputerName $adcomputer | 

Where-Object -FilterScript {
                    ($_.SID -notcontains 'S-1-5-20') -and 
                    ($_.SID -notcontains 'S-1-5-19') -and 
                    ($_.SID -notcontains 'S-1-5-18')
                    } | 

Select-Object PSComputerName, IdentifyingNumber, Name |

Export-Csv C:\Powershell\Serial.csv -NoTypeInformation -Append

