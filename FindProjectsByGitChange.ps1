$changedFiles = git diff --name-only featue/branch2 master
$changedProj = $changedFiles | Foreach-Object { $_.Split("/")[1] } | Where-Object {$_ -ne $null } | Where-Object { $_.Trim().Length -gt 0 }

$slnFiles = Get-ChildItem -Recurse -Include "*.sln"

$slnFiles | ForEach-Object { (Select-String -Pattern $changedProj -Path $_).Filename} | Select-Object -Unique