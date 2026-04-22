$s = git status --porcelain 2>$null
$r = ""
if ($s) {
    $lines = @($s)
    $staged = @($lines | Where-Object { $_ -match "^[MADRCT]" }).Count
    $modified = @($lines | Where-Object { $_ -match "^.[MD]" }).Count
    $deleted = @($lines | Where-Object { $_ -match "^D.|^.D " }).Count
    $untracked = @($lines | Where-Object { $_ -match "^\?\?" }).Count
    if ($staged -gt 0) { $r += "+$staged " }
    if ($modified -gt 0) { $r += "~$modified " }
    if ($deleted -gt 0) { $r += "-$deleted " }
    if ($untracked -gt 0) { $r += "?$untracked " }
}
$stashList = git stash list 2>$null
$stash = if ($stashList) { @($stashList).Count } else { 0 }
if ($stash -gt 0) { $r += "S$stash " }
try {
    $ab = git rev-list --left-right --count "HEAD...@{upstream}" 2>$null
    if ($ab) {
        $parts = $ab.Trim() -split "\s+"
        if ([int]$parts[0] -gt 0) { $r += "$([char]0x21e1)$($parts[0]) " }
        if ([int]$parts[1] -gt 0) { $r += "$([char]0x21e3)$($parts[1]) " }
    }
} catch {}
$r = $r.TrimEnd()
if ($r) { Write-Host -NoNewline "[$r]" }
