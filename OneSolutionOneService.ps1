[CmdletBinding()]

Param (
[Parameter (Mandatory=$true, Position=1)]
[string[]]$projects
)

$slnFiles = Get-ChildItem -Recurse -Include "*.sln"

$slnFiles | ForEach-Object { (Select-String -Pattern $projects -Path $_).Filename} | Select-Object -Unique