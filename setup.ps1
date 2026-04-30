$ErrorActionPreference = "Stop"

Write-Host "=== Roblox Plugin Setup ===" -ForegroundColor Cyan
Write-Host ""

$name = Read-Host "Enter your plugin name (e.g. my-cool-plugin)"
if ([string]::IsNullOrWhiteSpace($name)) {
    Write-Host "No name provided. Exiting." -ForegroundColor Red
    exit 1
}

$displayName = Read-Host "Enter a display name for Studio (e.g. My Cool Plugin)"
if ([string]::IsNullOrWhiteSpace($displayName)) {
    $displayName = $name
}

Write-Host ""
Write-Host "Updating config files..." -ForegroundColor Yellow

$projectJson = Get-Content "default.project.json" -Raw
$projectJson = $projectJson -replace '"template-plugin"', "`"$name`""
Set-Content "default.project.json" $projectJson -NoNewline

$wallyToml = Get-Content "wally.toml" -Raw
$wallyToml = $wallyToml -replace 'your-username/template-plugin', "your-username/$name"
Set-Content "wally.toml" $wallyToml -NoNewline

$buildRule = Get-Content ".cursor/rules/plugin-build.mdc" -Raw
$buildRule = $buildRule -replace 'template-plugin\.rbxmx', "$name.rbxmx"
Set-Content ".cursor/rules/plugin-build.mdc" $buildRule -NoNewline

$source = Get-Content "src/init.server.luau" -Raw
$source = $source -replace 'local PLUGIN_NAME = "Template Plugin"', "local PLUGIN_NAME = `"$displayName`""
Set-Content "src/init.server.luau" $source -NoNewline

Write-Host "Installing toolchain..." -ForegroundColor Yellow
aftman install

Write-Host "Installing packages..." -ForegroundColor Yellow
wally install

Write-Host "Building plugin..." -ForegroundColor Yellow
rojo build --plugin "$name.rbxmx"

Write-Host ""
Write-Host "Done! Open Roblox Studio to find your plugin in the Plugins toolbar." -ForegroundColor Green
