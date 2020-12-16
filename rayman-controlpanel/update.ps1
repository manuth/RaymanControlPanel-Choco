Import-Module au

function global:au_SearchReplace {
    @{
        "./tools/chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $latestReleaseEndpoint = 'https://api.github.com/repos/RayCarrot/RayCarrot.RCP.Metro/releases/latest'
    $latestRelease = Invoke-RestMethod $latestReleaseEndpoint -UseBasicParsing
    $version = $latestRelease.tag_name
    $url32 = $latestRelease.assets[0].browser_download_url

    Write-Host $version
    Write-Host $url32

    return @{ URL32 = $url32; Version = $version }
}

function global:au_AfterUpdate ($Package)  {
    Set-DescriptionFromReadme $Package
}

Update-Package
