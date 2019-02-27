param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

'running with full privileges'

While($true)
    { 
		Clear-Host
        Write-Host "DNS Changer"
        Write-Host "1. Change to 1.1.1.1"
        Write-Host "2. Reset to Default"
        $dns = Read-Host -Prompt 'Enter your option: '
        if($dns -eq 1){
            Write-Host "`n`nChanging DNS to 1.1.1.1 | Please wait....`n`n"
			Set-DnsClientServerAddress -InterfaceAlias Wi-Fi -ServerAddresses "1.1.1.1","1.0.0.1"
			Write-Host "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
        }elseif($dns -eq 2){
            Write-Host "`n`nResetting DNS setting to default | Please Wait...`n`n"
			Set-DnsClientServerAddress -InterfaceAlias wi-fi -ResetServerAddresses			
			Write-Host "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
        }else{
            Write-Host "`n`nEnter Valid Option`n`n"
			Write-Host "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
        }  
    }
