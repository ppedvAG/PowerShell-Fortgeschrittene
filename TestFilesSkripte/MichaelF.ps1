<#
.Synopsis
   Erstellt einen Ordner "TestFiles" gefüllt mit beliebig vielen Ordnern und 
   füllt diese mit beliebig vielen Txt dateien, solange beliebig <=10

.EXAMPLE
skirpt1.ps1 -path C:\Testfiles\ -dircount 1 -filecount 0
Erstellt unter dem Pfad TestFiles einen ORdner TestFiles mit einem Ordner und Null Dateien
Ausgabe:
Verzeichnis: C:\Testfiles


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       23.07.2020     12:02                TestFile


    Verzeichnis: C:\Testfiles\TestFiles


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       23.07.2020     12:02                Ordner1
#>

[cmdletBinding()]

Param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -isValid})]
[string] $path,

[ValidateRange(0,10)]
[int] $dircount = 3,

[ValidateRange(0,10)]
[int] $filecount = 3
)

Write-Debug -Message "Vor Pfaderstellung"
$path = $path + "\TestFiles"
Write-Debug -Message "Nach Pfaderstellung"
if(Test-Path -Path $path)
{
    Remove-Item -Path $path -Force -Recurse
}

New-Item -Path $path -ItemType Directory

for($i = 0; $i -lt $dircount; $i++)
{
    New-Item -Path $path -Name "\Ordner$i" -ItemType Directory 
        for($j = 0; $j -ne $filecount; $j++)
        {
            $tempi = $path + "\Ordner$i\Datei$j.txt"
            New-Item -Path $tempi -ItemType File 
        }
}


for($j = 0; $j -ne $filecount; $j++)
{         
      New-Item -Path $path -Name "Datei$j.txt" -ItemType File 
}


