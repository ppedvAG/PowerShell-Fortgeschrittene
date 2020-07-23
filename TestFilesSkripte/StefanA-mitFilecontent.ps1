[cmdletBinding()] #Importiert erweiterte Parameterfunktionen 
Param(
[Parameter (Mandatory=$true)]
[ValidateScript({Test-Path -IsValid -Path $PSItem})] #Der Parameter -isValid prüft ob die Syntax des PFades richtig ist, ohne das die Bestandteile des PFades vorhanden sein müssen
[string]$TestFileFolderpath,

[ValidateRange(1,10)]
[int]$SubFolderCount = 1,

[ValidateRange(1,10)]
[int]$FileCount = 1,

[ValidateSet("None","IPConfig","DateTime")]
[string]$Filecontent,

[switch]$force
)

if($force -and (Test-Path -Path $TestFileFolderpath))
{
    Remove-Item -Path $TestFileFolderpath -Force -Recurse
}
elseif(Test-Path -Path $TestFileFolderpath)
{
    Write-Host "Der Pfad ist schon vorhanden"
    break
}

#FileContent Erstellen
switch($Filecontent)
{
    "None" {$Content = ""}
    "IPConfig" {$Content = Get-NetIPConfiguration | Out-String}
    "DateTime" {$Content = Get-Date | Out-String}
}


Write-Verbose -Message "Vor Variablenwerte Ausführung:TestFileFolder: $TestFileFolder, SubFolderCount: $SubFolderCount, FileCount: $FileCount"
# Hauptordner erstellen
New-Item -Path $TestFileFolderpath -ItemType "directory"
# Files erstellen im Hauptordner
for ($i = 1; $i -le $FileCount; $i=$i+1) 
{
    $filenumber = "{0:D2}" -f $i #Decimale Formatierung um führende Nullen zu erhalten 
    New-Item -Path "$TestFileFolderpath\" -Name "File$filenumber.txt" -ItemType "file" -Value $Content 
}


# Unterordner erstellen
for ($i = 1; $i -le $SubFolderCount; $i=$i+1) 
{ 
    New-Item -Path $TestFileFolderpath -Name "Ordner$i" -ItemType "directory"
    for ($f = 1; $f -le $FileCount; $f=$f+1) 
    { 
        New-Item -Path "$TestFileFolderpath\Ordner$i\" -Name "File$f.txt" -ItemType "file" -Value $Content
    }      
}
 