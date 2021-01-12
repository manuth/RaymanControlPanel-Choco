$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName;
$toolsPath = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)";
$url32 = 'https://github.com/RayCarrot/RayCarrot.RCP.Metro/releases/download/10.3.1/Rayman.Control.Panel.exe';
$checksum32 = '68d6164d9e350a5b216c0c14ae8076cfe548f987fde872fe363b3a4d17c21555';
$fileFullPath = Join-Path $toolsPath -ChildPath "rayman-cp.exe";

$packageArgs = @{
    fileFullPath = $fileFullPath
    packageName = $packageName
    url = $url32
    checksum = $checksum32
    checksumType = 'sha256'
};

Get-ChocolateyWebFile @packageArgs;

$exeFiles = Get-ChildItem $toolsPath -Recurse -Filter *.exe;
$entryPoints = @($fileFullPath);

foreach ($exeFile in $exeFiles) {
    if (-not $entryPoints.Contains($exeFile.FullName)) {
        $ignoreFileName = $exeFile.FullName + ".ignore";

        if (-not $(Test-Path $ignoreFileName)) {
            New-Item -ItemType File $ignoreFileName;
        }
    }
}

Install-ChocolateyShortcut `
  -ShortcutFilePath $([string]::Join([System.IO.Path]::DirectorySeparatorChar, @([Environment]::GetFolderPath("CommonStartMenu"), "Programs", "Rayman Control Panel™.lnk"))) `
  -TargetPath $fileFullPath
