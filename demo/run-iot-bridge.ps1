param(
    [string]$Port = "COM3",
    [string]$Backend = "https://epicare-api-production.up.railway.app",
    [string]$Patient = "demo-patient",
    [string]$Device = "proteus-01",
    [switch]$WriteCommand
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$backendDir = Join-Path $repoRoot "backend"
$writeCommandValue = $WriteCommand.IsPresent.ToString().ToLowerInvariant()

Set-Location $backendDir

dotnet run --project src\EpiCare.IoTBridge -- `
    --port $Port `
    --backend $Backend `
    --patient $Patient `
    --device $Device `
    --write-command $writeCommandValue
