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
if ($env:TERM_PROGRAM -eq "vscode") { . "$(code --locate-shell-integration-path pwsh)" }

$gh_completion_script = "$env:USERPROFILE\.gh.completion.ps1"
if (Test-Path -Path $gh_completion_script -PathType Leaf)
{
	. $gh_completion_script
}
