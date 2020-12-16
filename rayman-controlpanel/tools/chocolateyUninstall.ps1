Remove-Item $(Join-Path -Path "$([Environment]::GetFolderPath('CommonStartMenu'))" -ChildPath $("Programs" + [System.IO.Path]::DirectorySeparatorChar + "Rayman Control Panel™.lnk"))
