[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
oh-my-posh init pwsh --config "$env:USERPROFILE\.mytheme.omp.json" | Invoke-Expression
function Set-PoshGitStatus {
    $global:GitStatus = Get-GitStatus
    $env:POSH_GIT_STRING = Write-GitStatus -Status $global:GitStatus
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-PoshGitStatus' -Scope Global -Force


Import-Module PSReadLine

function SupportAdvancedTerminalFeatures
{
	try
	{
		$isConsole = [System.Console]::IsOutputRedirected -eq $false
		$supportVirtualTerminal = $null -ne [System.Console]::TreatControlCAsInput
		return $isConsole -and $supportVirtualTerminal 
	}
	catch
	{
		return $false
	}
}

if (SupportAdvancedTerminalFeatures)
{
	$PSOption = @{
		EditMode = 'Vi'
		PredictionSource = 'History'
		PredictionViewStyle = 'ListView'
	}
	Set-PSReadlineOption @PSOption
	Set-PSReadlineKeyHandler -key Tab -Function MenuComplete
}
else
{
	Write-Host "Advanced terminal features are not supported in this terminal."
}


Register-ArgumentCompleter -Native -CommandName az -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $completion_file = New-TemporaryFile
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    $env:_ARGCOMPLETE_SUPPRESS_SPACE = 0
    $env:_ARGCOMPLETE_IFS = "`n"
    $env:_ARGCOMPLETE_SHELL = 'powershell'
    az 2>&1 | Out-Null
    Get-Content $completion_file | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
    }
    Remove-Item $completion_file, Env:\_ARGCOMPLETE_STDOUT_FILENAME, Env:\ARGCOMPLETE_USE_TEMPFILES, Env:\COMP_LINE, Env:\COMP_POINT, Env:\_ARGCOMPLETE, Env:\_ARGCOMPLETE_SUPPRESS_SPACE, Env:\_ARGCOMPLETE_IFS, Env:\_ARGCOMPLETE_SHELL
}

# shell integration
if ($env:TERM_PROGRAM -eq "vscode") {
    $shellIntegrationPath = & code --locate-shell-integration-path pwsh 2>$null
    if ($shellIntegrationPath -and (Test-Path $shellIntegrationPath)) {
        . $shellIntegrationPath
    }
}

$gh_completion_script = "$env:USERPROFILE\.gh.completion.ps1"
if (Test-Path -Path $gh_completion_script -PathType Leaf)
{
	. $gh_completion_script
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

# load local PowerShell profile
$localProfile = Join-Path $PSScriptRoot "Micrsoft.PowerShell_Profile.local.ps1"
if (Test-Path $localProfile)
{
    . $localProfile
}

# rmux fix: rmux 转发 win32 键事件时把 Backspace 与 Ctrl+Backspace 对调了
#   物理 Backspace      -> PSReadLine 收到 'Ctrl+Backspace'
#   物理 Ctrl+Backspace -> PSReadLine 收到 'Backspace'
# 必须放在文件末尾(EditMode 设置之后),否则会被 Set-PSReadLineOption -EditMode 重置。
# 只在 rmux 会话生效,直连 PowerShell 不受影响。
if ($env:RMUX)
{
    Set-PSReadLineKeyHandler -Chord 'Ctrl+Backspace' -Function BackwardDeleteChar
    Set-PSReadLineKeyHandler -Chord 'Backspace'      -Function BackwardKillWord
}
