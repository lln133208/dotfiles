[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
oh-my-posh init pwsh --config "$env:USERPROFILE\.mytheme.omp.json" | Invoke-Expression
function Set-PoshGitStatus {
    $global:GitStatus = Get-GitStatus
    $env:POSH_GIT_STRING = Write-GitStatus -Status $global:GitStatus
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-PoshGitStatus' -Scope Global -Force

$PSOption = @{
	EditMode = 'Vi'
	PredictionSource = 'History'
	PredictionViewStyle = 'ListView'
}

Set-PSReadlineOption @PSOption
Set-PSReadlineKeyHandler -key Tab -Function MenuComplete
