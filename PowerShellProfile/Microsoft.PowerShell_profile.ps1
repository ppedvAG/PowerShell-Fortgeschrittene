
function Color-Console {
    $Host.ui.RawUI.BackgroundColor = "White"
    $Host.ui.RawUI.ForegroundColor = "Black"

    $hosttime = Get-Date
    $hostversion = "$($Host.Version.Major).$($Host.Version.Minor)"

    #aktuellen User bestimmen
    $IDentit�t = [System.Security.Principal.WindowsIdentity]::GetCurrent()

    #Prinzipal anlegen
    $prinzipal = New-Object System.Security.Principal.WindowsPrincipal $IDentit�t

    #pr�fen ob Admin
    $isAdmin = $prinzipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

    $Host.UI.RawUI.WindowTitle = "Elevated: $isAdmin PowerShell $hostversion ($hosttime) User: $($IDentit�t.Name)"

    Clear-Host
}

function Set-TokenColors
{
    Set-PSReadlineOption -TokenKind Command -ForegroundColor DarkBlue 
    Set-PSReadlineOption -TokenKind Comment -ForegroundColor DarkGreen
    Set-PSReadlineOption -TokenKind Parameter -ForegroundColor Blue
    Set-PSReadlineOption -TokenKind Number -ForegroundColor DarkRed
    Set-PSReadlineOption -TokenKind Member -ForegroundColor Magenta

}

function Prompt
{
    #aktuellen User bestimmen
    $IDentit�t = [System.Security.Principal.WindowsIdentity]::GetCurrent()

    #Prinzipal anlegen
    $prinzipal = New-Object System.Security.Principal.WindowsPrincipal $IDentit�t

    #pr�fen ob Admin
    $isAdmin = $prinzipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

    $cPath = Get-Location
    if($cPath.Path.Length -gt 25)
    {
        $splitpath = $cPath.Path.Split('\')
        $path = $splitpath[0] + "..." + $splitpath[$splitpath.Length-1] #-1 Da Array bei 0 beginnt zu z�hlen und length bei 1 beginnt
    }
    else
    {
        $path = $cPath.Path
    }

    if($isAdmin)
    {
        $prompt = "[Elevated]$path> "
    }
    else
    {
        $prompt = "[User]$(Get-Location)> "
    }

    $prompt
}
Color-Console
Set-TokenColors

