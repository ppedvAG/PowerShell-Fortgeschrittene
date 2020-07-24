[cmdletBinding()]
param(
    [string]$Path)

try
{
(Get-ChildItem -Path $Path -File -ErrorAction Stop  | Measure-Object).Count
}
catch
{
    Write-Verbose -Message $Error[0]
    Write-Host "Es ist ein Fehler aufgetreten" -ForegroundColor Red    
}