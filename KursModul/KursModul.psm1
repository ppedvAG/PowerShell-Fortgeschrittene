function Get-LogonEvents
{
<#
    .SYNOPSIS
    Abfrage von AnmeldeEvents
    .DESCRIPTION
    Dieses Skript dient dazu Anmelde bezogene Events auf Remote oder lokalen Systemen abzufragen.
    .PARAMETER EventId
    Mit diesem Parameter gebe ich die abzufragenden EventID an. Folgende Werte sind möglich 4624, 4625, 4634
    .EXAMPLE
    Get-LogonEvents.ps1 -Computername localhost -EventId 4624


    ProviderName: Microsoft-Windows-Security-Auditing

    TimeCreated                     Id LevelDisplayName Message
    -----------                     -- ---------------- -------
    23.07.2020 10:36:43           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:43           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:05           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:05           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:05           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:05           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:05           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:35:05           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:34:50           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....
    23.07.2020 10:34:50           4624 Informationen    Ein Konto wurde erfolgreich angemeldet....

    Auf dem Computer localhost wird das Event 4624 aus dem Security Log abgefragt, welches das Event für eine erfolgreiche Anmeldung darstellt.
#>
[cmdletBinding()]
Param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Connection -ComputerName $PSItem -Quiet -Count 1})]
[string]$Computername,

[ValidateSet(4624,4625,4634)]
[int]$EventId = 4624,

[ValidateRange(5,20)]
[int]$Newest = 4
)


#Write Verbose zeigt eine Ausführliche Ausgabe an wenn Skript mit dem Parameter verbose aufgerufen wird
Write-Verbose -Message "Vor Ausführung des ersten cmdlets. Folgende Werte wurden angegeben. ComputerName:$ComputerName | EventID: $EventId | Newest: $Newest"

#Verbose wird hier auf false gelegt damit bei verbose nur unsere Verbose ausgabe ausgegeben wird
Get-WinEvent -ComputerName $Computername -FilterHashtable @{Logname='Security';ID=$EventId} -MaxEvents $Newest -Verbose:$false
}



