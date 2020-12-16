$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$toolsPath = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$url32 = 'https://github.com/RayCarrot/RayCarrot.RCP.Metro/releases/download/10.3.1/Rayman.Control.Panel.exe'
$checksum32 = '68d6164d9e350a5b216c0c14ae8076cfe548f987fde872fe363b3a4d17c21555'

$packageArgs = @{
    fileFullPath = $(Join-Path -Path $toolsPath -ChildPath "rayman-cp.exe")
    packageName = $packageName
    url = $url32
    checksum = $checksum32
    checksumType = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

# $exeFiles = Get-ChildItem $toolsPath -Recurse -Filter *.exe
# $entryPoints = @()

# foreach ($exeFile in $exeFiles) {
#     if (-not $entryPoints.Contains($exeFile.FullName)) {
#         New-Item -ItemType File "$($exeFile.FullName).ignore"
#     }
# }

Install-ChocolateyShortcut `
  -ShortcutFilePath $(Join-Path -Path "$([Environment]::GetFolderPath('CommonStartMenu'))" -ChildPath $("Programs" + [System.IO.Path]::DirectorySeparatorChar + "Rayman Control Panel™.lnk")) `
  -TargetPath $packageArgs.fileFullPath
