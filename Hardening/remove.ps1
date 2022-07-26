param (
    [string]$user = $( Read-Host "Input Username, please" ),
    [string]$ipAddress = $( Read-Host "Input IP Address, please" )
 )

ssh "${user}@${ipAddress}" rmdir /s C:\Users\$user\Hardening

Write-Host "HardeningKitty has been fully removed."