#============================
# Zip Git Directories
# 
# Compresses folders containing .git in a directory recursively.
#
# Author: Neko Boi Nick
# License: MIT
#============================

$path="C:\Users\user1\source"
$7zip="C:\Program Files\7-Zip\7z.exe"


Function DoIt($item) {
  Write-Host "Done with ${$item.Name}"
  Start-Process -Wait -FilePath $7zip -ArgumentList "a", "-mx0", "-t7z", "-r", "${$item.Name}.7z", "${item.FullName}\*.*";
  #Remove-item -Path $item.FullName -Recurse -Force
}

$sub_folders = Get-ChildItem $path -Recurse -Directory |
Where-Object {
  if ((Get-ChildItem -Path $_.FullName -Directory).Length -gt 0) {
    (Get-ChildItem -Path $_.FullName -Directory)[0].Name -Contains ".git"
  }
}
Write-Host "Done with "

foreach ($s in $sub_folders) {
  $path = $s
  $path > $null
  Set-Location $path.parent.FullName > $null

  $fullpath = $path.FullName
  $pathName = $path.BaseName

  $items = "${pathName}\*.*"

  $OutputFolder = $path.parent
  Write-Host "Done with ${OutputFolder}"

  Start-Process -Wait -FilePath $7zip -ArgumentList "a", "-mx0", "-t7z", "-r", "${pathName}.7z", "${items}";
  Remove-item -Path $path.FullName -Recurse -Force
}

Write-host $_.FullName
