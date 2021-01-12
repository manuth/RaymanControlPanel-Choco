$shortcutFileName = [string]::Join([System.IO.Path]::DirectorySeparatorChar, @([Environment]::GetFolderPath("CommonStartMenu"), "Programs", "Rayman Control Panel™.lnk"));

if (Test-Path $shortcutFileName) {
    Remove-Item $shortcutFileName;
}
