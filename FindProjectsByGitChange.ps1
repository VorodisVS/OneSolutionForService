$changedFiles = git diff --name-only feature/branch2 master
$changedProj = $changedFiles | Foreach-Object { $_.Split("/")[1] }

$slnFiles = Get-ChildItem -Recurse -Include "*.sln"

$slnFiles | ForEach-Object { (Select-String -Pattern $changedProj -Path $_).Filename} | Select-Object -Unique