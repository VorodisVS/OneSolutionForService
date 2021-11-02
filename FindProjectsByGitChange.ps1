[CmdletBinding()]

Param (
[Parameter (Mandatory=$true, Position=1)]
[string[]]$TargetBranch
)
$curBranch = git branch --show-current
$changedFiles = git diff --name-only $curBranch $TargetBranch
$changedProj = $changedFiles | Foreach-Object { $_.Split("/")[1] } | Where-Object {$_ -ne $null } | Where-Object { $_.Trim().Length -gt 0 }

$slnFiles = Get-ChildItem -Recurse -Include "*.sln"

$slnFiles | ForEach-Object { (Select-String -Pattern $changedProj -Path $_).Filename} | Select-Object -Unique