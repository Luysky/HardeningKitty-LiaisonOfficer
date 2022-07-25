param (	
	[string]$Choice = 'no selection',
    	[string]$date = $(Get-Date -Format "MM-dd-yyyy-HHmm-"),
    	[string]$list = "no selection",
    	[string]$hardenList = "no selection",
    	[string]$scanList = "no selection"
)

function Show-Menu
{
    param (
        [string]$Title = "HardeningKitty Liaison Officer"
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Scan."
    Write-Host "2: Harden."
    Write-Host "3: Audit."
    Write-Host "4: Backup."
    Write-Host "5: Export Logs, Reports and Backups."
    Write-Host "0: Press '0' to quit."

}

function Scan
{
    Set-ExecutionPolicy Bypass -Force
    Set-Location C:\Users\Administrator\Hardening\HardeningKitty
    Import-Module C:\Users\Administrator\Hardening\HardeningKitty\Invoke-HardeningKitty.ps1 -Force

    Get-ChildItem -Path C:\Users\Administrator\Hardening\HardeningKitty\lists -Name
    Write-Host "`n"

    Write-Host "Please write the name of the desired finding list followed by .csv"
    $scanList = Read-Host

    Set-Location C:\Users\Administrator\Hardening\HardeningKitty
    Invoke-HardeningKitty -FileFindingList .\lists\$scanList

    pause

    Set-Location C:\Users\Administrator\Hardening
}

function Harden
{
    Set-ExecutionPolicy Bypass -Force
    Set-Location C:\Users\Administrator\Hardening\HardeningKitty
    Import-Module C:\Users\Administrator\Hardening\HardeningKitty\Invoke-HardeningKitty.ps1 -Force


    Get-ChildItem -Path C:\Users\Administrator\Hardening\HardeningKitty\lists -Name
    Write-Host "`n"

    Write-Host "Please write the name of the desired finding list followed by .csv"
    $hardenList = Read-Host

    Set-Location C:\Users\Administrator\Hardening\HardeningKitty
    Invoke-HardeningKitty -Mode HailMary -Log -Report -FileFindingList .\lists\$hardenList

    pause

    Set-Location C:\Users\Administrator\Hardening
}


function Audit
{

    param (
    	[string]$fileName = $( Read-Host "Input file name, please" ),
    	[string]$logName = $fileName+'-log',
    	[string]$reportName = $fileName+'-report',
    	[string]$auditDate = $(Get-Date -Format "MM-dd-yyyy-HHmm-"),
    	[string]$log = $auditDate+$logName,
    	[string]$report = $auditDate+$reportName
    )

    Set-ExecutionPolicy Bypass -Force
    Set-Location C:\Users\Administrator\Hardening\HardeningKitty

    Import-Module C:\Users\Administrator\Hardening\HardeningKitty\Invoke-HardeningKitty.ps1 -Force

    Get-ChildItem -Path C:\Users\Administrator\Hardening\HardeningKitty\lists -Name
    Write-Host "`n"

    Write-Host "Please write the name of the desired finding list followed by .csv"
    $list = Read-Host

    Set-Location C:\Users\Administrator\Hardening\HardeningKitty
    Invoke-HardeningKitty -FileFindingList .\lists\$list -Mode Audit -Log -Report -LogFile .\logsNreports\$log.txt -ReportFile .\logsNreports\$report.csv

    pause

    Set-Location C:\Users\Administrator\Hardening
}


function Backup
{
    param (
    	[string]$backupName = $( Read-Host "Input backup name, please" ),
    	[string]$backupDate = $(Get-Date -Format "MM-dd-yyyy-HHmm-"),
    	[string]$backup = $backupDate+$backupName
    )

    Set-ExecutionPolicy Bypass -Force
    Set-Location C:\Users\Administrator\Hardening\HardeningKitty

    Import-Module C:\Users\Administrator\Hardening\HardeningKitty\Invoke-HardeningKitty.ps1 -Force
    Invoke-HardeningKitty -Mode Config -Backup -BackupFile C:\Users\Administrator\Hardening\HardeningKitty\backups\$backup.csv

    Set-Location C:\Users\Administrator\Hardening\HardeningKitty
    Copy-Item -Path ".\backups\$backup.csv" -Destination "C:\Users\Administrator\Hardening\HardeningKitty\lists\$backup.csv"

    Set-Location C:\Users\Administrator\Hardening\
}

function Export
{
    param (
    	[string]$user = $( Read-Host "Input MASTER Username, please" ),
    	[string]$ipAddress = $( Read-Host "Input MASTER IP Address, please" )
    )

    Write-Host "Loading HardeningKitty Liaison Officer in progress"

    Write-Host "Export logsNReports"
    scp -r .\HardeningKitty\logsNreports "${user}@${ipAddress}:c:/users/administrator/Hardening-Reports"

    Write-Host "Export backups"
    scp -r .\HardeningKitty\backups "${user}@${ipAddress}:c:/users/administrator/Hardening-Backups"

    Write-Host "*******************************************"
    Write-Host "Logs, reports and backups transfered"
    Write-Host "*******************************************"
}


do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)

     {
         '1' {
		Write-Host "`n"
             'SCAN'
		  Scan

         } '2' {
		Write-Host "`n"
             'HARDEN'
		 Harden

         } '3' {
		Write-Host "`n"
             'AUDIT'
		Audit

         }'4' {
		Write-Host "`n"
             'BACKUP'
		Backup
         }'5' {
		Write-Host "`n"
             'EXPORT'
		Export
         }
     }

     if($selection -ne '0') {		
     Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); 
     Clear-Host
     }

	
 }
 until ($selection -eq '0')
	Write-Host "`n"
	Write-Host "==================================="
	Write-Host "Type exit twice to end remote connection"
	Write-Host "==================================="
	Write-Host "`n"