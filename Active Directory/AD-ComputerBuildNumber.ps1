##Finds OS Build number of a computer in Active Directory

$OU = ""
$DC1 = ""
$DC2 = ""

$serverFQDN = ""

$adcomputer = (Get-ADComputer -server $serverFQDN -Filter * -SearchBase "OU=$OU,DC=$DC1,DC=$DC2").name

get-wmiobject Win32_OperatingSystem -ComputerName $adcomputer -Credential $c |
Select-Object PSComputername, BuildNumber