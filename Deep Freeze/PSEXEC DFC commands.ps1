# Must have PStools
# Using PSexec to run Deep freeze commands on the remote computer

& .\psexec.exe \\COMPUTERNAME1,COMPUTERNAME2 -s -d C:\windows\SysWOW64\dfc.exe <password> /bootthawed

<# Deep Freeze Console Commands
DFC password /BOOTTHAWED
    Restarts computer in a Thawed state; only works on Frozen computers.

DFC password /THAWNEXTBOOT
    Sets computer to restart Thawed the next time it restarts; only works on Frozen computers and does not force computer to restart.

DFC password /BOOTFROZEN
    Restarts computer into a Frozen state; only works on Thawed computers.

DFC password /FREEZENEXTBOOT
    Sets up computer to restart Frozen the next time it restarts; only works on Thawed computers and does not force computer to restart

DFC get /ISFROZEN
    Queries computer if it is Frozen. Returns 0 if Thawed. Returns 1 if Frozen.

DFC password /CFG=[path] depfrz.rdx
    Replaces Deep Freeze configuration information. Works on Thawed or Frozen computers. Password changes are effective immediately. Other changes require restart.

DFC get /version
    Displays Deep Freeze version number.

DFC password /UPDATE=[path to installer file]
    Sets up computer to restart in a Thawed state and install a Deep Freeze update

DFC password /LOCK 
    Disables keyboard and mouse on workstation. Works on Frozen or Thawed computers and does not require a restart.

DFC password /UNLOCK
    Enables keyboard and mouse on computer. Works on Frozen or Thawed workstation and does not require a restart

DFC password /THAWLOCKNEXTBOOT
    Sets up computer to restart in a Thawed state with keyboard and mouse disabled; only works on Frozen computers.

DFC password /BOOTTHAWEDNOINPUT
    Restarts computer in a Thawed state with keyboard and mouse disabled; only works on Frozen computers.

DFC get /LICENSESTATUS 
    Displays the status of the license and the expiry date of the license (if any). The different possible types of license and the associated return codes are: 
        111: Unlicensed — Deep Freeze is not licensed and will operate in Evaluation mode for 30 days since installation. 
        112: Evaluation — licensed for evaluation with a fixed expiry date. 
        113: Licensed — licensed with no expiry date. 
        114: Expired — The Evaluation period has expired.

DFC get /LICENSETYPE 
    Displays the status of the license and the expiry date of the license (if any). The different possible types of license and the associated return codes are: 
        111: None (Unlicensed) — Deep Freeze is not licensed and will operate in Evaluation mode for 30 days since installation. 
        112: Evaluation — licensed for evaluation with a fixed expiry date. 
        113: Standard (Licensed) — licensed with no expiry date. 
        114: Not for Resale — Licensed with no expiry date.

DFC password /LICENSE=licensekey 
    Changes the License Key. 
        password is the Deep Freeze Administrator password. 
        licensekey is the License Key for Deep Freeze. 
    If there is an error, the following error codes are displayed: 
        101: The License Key is not valid 
        102: The License Key provided has already expired.
#>
