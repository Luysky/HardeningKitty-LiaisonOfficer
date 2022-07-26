param (
    [string]$user = $( Read-Host "Input Username, please" ),
    [string]$ipAddress = $( Read-Host "Input IP Address, please" )
 )

Write-Host "Loading HardeningKitty Liaison Officer in progress"
scp -r .\HK-LiaisonOfficer "${user}@${ipAddress}:c:/users/$user/Hardening"

Write-Host "`n"
Write-Host "*******************************************"
Write-Host "Welcome to HardeningKitty Liaison Officer!"
Write-Host "*******************************************"

ssh "${user}@${ipAddress}"