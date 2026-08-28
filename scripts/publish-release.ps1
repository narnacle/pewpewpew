param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^v\d+\.\d+\.\d+$')]
    [string] $Version,

    [string] $Repo = 'narnacle/pewpewpew',

    [string] $ExePath = '.\PewPewPew.exe',

    [string] $Target = 'main'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $ExePath)) {
    throw "Executable not found: $ExePath"
}

$credentialInput = "protocol=https`nhost=github.com`n`n"
$credentialText = $credentialInput | git credential fill
$token = ($credentialText | Where-Object { $_ -like 'password=*' } | Select-Object -First 1) -replace '^password=', ''

if (-not $token) {
    throw 'No GitHub token returned by the Git credential helper.'
}

$headers = @{
    Authorization = "Bearer $token"
    Accept = 'application/vnd.github+json'
    'X-GitHub-Api-Version' = '2022-11-28'
}

$releaseBody = @{
    tag_name = $Version
    target_commitish = $Target
    name = "PewPewPew $Version"
    body = "Windows executable release for PewPewPew $Version."
    draft = $false
    prerelease = $false
} | ConvertTo-Json

$release = Invoke-RestMethod `
    -Method Post `
    -Uri "https://api.github.com/repos/$Repo/releases" `
    -Headers $headers `
    -Body $releaseBody `
    -ContentType 'application/json'

$assetName = Split-Path -Leaf $ExePath
$uploadUri = ($release.upload_url -replace '\{.*$', '') + "?name=$assetName"

$asset = Invoke-RestMethod `
    -Method Post `
    -Uri $uploadUri `
    -Headers $headers `
    -InFile $ExePath `
    -ContentType 'application/octet-stream'

[pscustomobject]@{
    release_url = $release.html_url
    asset_name = $asset.name
    asset_size = $asset.size
    asset_download_url = $asset.browser_download_url
} | ConvertTo-Json
