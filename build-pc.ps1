# Build an optimized release APK on Windows. Requires Node.js 20+ and Android SDK.
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error "Install Node.js 20+ first: https://nodejs.org/"
}

$sdk = $env:ANDROID_HOME
if (-not $sdk) {
    $defaultSdk = Join-Path $env:LOCALAPPDATA "Android\Sdk"
    if (Test-Path $defaultSdk) {
        $sdk = $defaultSdk
        $env:ANDROID_HOME = $sdk
    }
}

if ($sdk) {
    "sdk.dir=$($sdk -replace '\\', '/')" | Set-Content -Path "android\local.properties" -Encoding ASCII
}

npm install
npx cap sync android

Push-Location android
try {
    if ($IsWindows -or $env:OS -match "Windows") {
        .\gradlew.bat assembleRelease
    } else {
        ./gradlew assembleRelease
    }
} finally {
    Pop-Location
}

$apk = "android\app\build\outputs\apk\release\app-release.apk"
if (Test-Path $apk) {
    Write-Host ""
    Write-Host "Built: $apk"
    Get-Item $apk | Format-List FullName, Length, LastWriteTime
} else {
    throw "Build finished but APK not found at $apk"
}
