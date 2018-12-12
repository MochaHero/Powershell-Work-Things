# Sign powershell script with certificate
# Must have certificate Key to work

$myCert = (Get-ChildItem Cert:\CurrentUser\my\ -CodeSigningCert)

$filelocation = "C:\"

Set-AuthenticodeSignature $filelocation -Certificate $myCert -IncludeChain all -TimestampServer 'http://timestamp.comodoca.com'
