# Install oh-my-posh

if (!(Test-Path "$env:USERPROFILE\AppData\Local\Programs\oh-my-posh\bin\oh-my-posh.exe"))
{   
    Write-Host "oh-my-posh is not installed. Will start soon."
    Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    Write-Host "oh-my-posh has been installed successfully."
}

# Install modules from https://www.powershellgallery.com/

$modules = @('posh-git', 'PSReadline')

foreach ($module in $modules)
{
    if (!(Get-Module -ListAvailable -Name $module))
    {
        Write-Host "$module is not installed. Will start soon."
        Install-Module -Name $module    
        Write-Host "$module has been installed successfully."
    }
}

# Set PowerShell profile

New-Item -ItemType symboliclink -Path "$env:USERPROFILE\Documents\PowerShell" -name Microsoft.PowerShell_profile.ps1 -Value ./posh/Microsoft.PowerShell_profile.ps1 -Force

# Prepare .dotfiles

if (!(Test-Path "$env:USERPROFILE\.mytheme.omp.json"))
{
    New-Item -ItemType symboliclink -Path "$env:USERPROFILE" -Name .mytheme.omp.json -Value ./posh/.mytheme.omp.json
}

if (!(Test-Path "$env:USERPROFILE\.vimrc"))
{
    New-Item -ItemType symboliclink -Path "$env:USERPROFILE" -Name .vimrc -Value ./vim/.vimrc
}

if (!(Test-Path "$env:USERPROFILE\.ideavimrc"))
{
    New-Item -ItemType symboliclink -Path "$env:USERPROFILE" -Name .ideavimrc -Value ./vim/.ideavimrc
}
