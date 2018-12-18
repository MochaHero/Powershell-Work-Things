$filepath = "C:\PATH"

$driversCollection = (Get-ChildItem -Path $filepath -Filter "*.inf" -Recurse -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Fullname)

foreach($driver In $driversCollection){
    # Add and install driver package
    pnputil.exe -i -a $driver
} 