Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

# Install Starship prompt

if (!(Get-Command starship -ErrorAction SilentlyContinue))
{
    Write-Host "Starship is not installed. Installing via winget..."
    winget install --id Starship.Starship --accept-source-agreements --accept-package-agreements
    Write-Host "Starship has been installed successfully."
}

# Install modules from https://www.powershellgallery.com/

$modules = @('PSReadline')

foreach ($module in $modules)
{
    if (!(Get-Module -ListAvailable -Name $module))
    {
        Write-Host "$module is not installed. Will start soon."
        Install-Module -Name $module    
        Write-Host "$module has been installed successfully."
    }
}

$currentPath = (Get-Location).Path
# Set PowerShell profile

New-Item -ItemType symboliclink -Path "$env:USERPROFILE\Documents\PowerShell" -name Microsoft.PowerShell_profile.ps1 -Value (Join-Path -Path $currentPath -ChildPath "posh\Microsoft.PowerShell_profile.ps1") -Force

# Prepare .dotfiles

# Starship config
$starshipConfigDir = "$env:USERPROFILE\.config"
if (!(Test-Path $starshipConfigDir)) { New-Item -ItemType Directory -Path $starshipConfigDir -Force }

New-Item -ItemType symboliclink -Path $starshipConfigDir -Name starship.toml -Value (Join-Path -Path $currentPath -ChildPath "posh\starship.toml") -Force
New-Item -ItemType symboliclink -Path $starshipConfigDir -Name starship-gitstatus.ps1 -Value (Join-Path -Path $currentPath -ChildPath "posh\starship-gitstatus.ps1") -Force

if (!(Test-Path "$env:USERPROFILE\.vimrc"))
{
    New-Item -ItemType symboliclink -Path "$env:USERPROFILE" -Name .vimrc -Value (Join-Path -Path $currentPath -ChildPath "vim\.vimrc" )
}

if (!(Test-Path "$env:USERPROFILE\.ideavimrc"))
{
    New-Item -ItemType symboliclink -Path "$env:USERPROFILE" -Name .ideavimrc -Value (Join-Path -Path $currentPath -ChildPath ".\vim\.ideavimrc")
}

# Generate gh completion script

if (Get-Command gh -ErrorAction SilentlyContinue)
{
    $ghCompletionScript = "$env:USERPROFILE\.gh.completion.ps1"
    if (!(Test-Path $ghCompletionScript))
    {
        Write-Host "Generating gh completion script..."
        gh completion -s powershell | Out-File $ghCompletionScript -Encoding utf8
        (Get-Item $ghCompletionScript).Attributes += 'Hidden'
        Write-Host "gh completion script has been generated and set as hidden."
    }
}
else
{
    Write-Host "GitHub CLI (gh) is not installed. Skipping gh completion setup."
}