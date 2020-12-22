Clear-Host
if (-not $( Get-Module Pester -ListAvailable ))
{
    Install-Module Pester
} else{
    Write-Host "Pester installed"
}

