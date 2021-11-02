[CmdletBinding()]

Param (
    [Parameter (Mandatory=$true, Position=1)]
    [string[]]$Directory,
    [Parameter() ]
    [int]$MaxLevel
)


function Show-Tree([System.IO.DirectoryInfo]$directory)
{
   $curLevel = ($directory.FullName).Split("\").Count - $script:globalInitLevel;
   if($curLevel -gt $script:MaxLevel){return} 
   WriteIntend($curLevel)
   Write-Host "├──┬" $directory.Name

   Get-ChildItem -Path ($directory.FullName+"\*") -File -Include "*sln","*csproj" | ForEach-Object {
        WriteIntend($curLevel+1)
       Write-Host "├───[" $_.Name 
   }

   Get-ChildItem -Path ($directory.FullName) -Directory -Exclude ".vs","bin","obj","wwwroot","Pages" ,"Properties"|  ForEach-Object { 
       Show-Tree($_)
   }


}

function WriteIntend([int]$count){
    $i = 0
       
        while($i -lt $count)
        {
            [console]::Write("├  ")
            $i++
        }
}

$dir = Get-Item -Path $Directory
Write-Host "Executed for " + $dir.FullName + $dir.GetType()
$globalInitLevel = ($dir.FullName).Split("\").Count;
Show-Tree -directory $dir