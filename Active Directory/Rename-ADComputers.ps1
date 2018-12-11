#Rename computer through the domain

$oldname = ""
$newname = ""

Rename-computer -computername $oldname -newname $newname -force -passthru -restart
