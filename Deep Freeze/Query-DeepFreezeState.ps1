#### Used to check if Deep Freeze is Frozen or Thawed on Public computers ####
##Computers must have PSRemoting Enabled

$computers = "SM-PUB01"

$command = "& C:\windows\syswow64\DFC.exe get /ISFROZEN"


foreach ($computer in $computers){

    Invoke-Command -ComputerName $computer -scriptblock {
        $command
            If ($LASTEXITCODE -eq 0){
            write-host "$env:COMPUTERNAME is Thawed"
        }
            else{
            write-host "$env:COMPUTERNAME is Frozen"
            }

    }

}
