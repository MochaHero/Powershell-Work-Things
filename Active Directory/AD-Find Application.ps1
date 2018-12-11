## Used to search for a certain application in computers located in multiple OUs 
# Will list Computer Name, Application Name, and Version Number

$programname = '<Name of application>'

# OUs to get computer names from
$OU = "ou1", "ou2", "ou3", "ou4"

$DC1 = "dc1"
$DC2 = "dc2"

$serverFQDN = "<server>"

FOREACH($branch in $OU){
    $adcomputer = (Get-ADComputer -Filter * -Server $serverFQDN -SearchBase "OU=WKRM,OU=$OU,DC=$DC1,DC=$DC2").name

    Foreach($computer in $adcomputer){
        Get-WmiObject win32_product -ComputerName $adcomputer | 
            Where-Object {$_.name -imatch $ProgramName} | 
            select-object PSComputername, Name, Version  |
            Export-csv C:\~Powershell\TrapsVersionquery.csv -NoTypeInformation
    }
}