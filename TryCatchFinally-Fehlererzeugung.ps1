try
{
    if((Test-Path -Path C:\fantasie -ErrorAction Stop) -ne $true) #Test-PAth liefert nur True oder False deswegen muss Fehler manuell ausgelöst werden
    {
       #nicht terminnierender Fehler Write-Error -Message "Pfad nicht vorhanden"
       throw "Pfad nicht vorhanden" #Terminierender Fehler
    }
}
catch
{
    
    Write-Host "Pfad nicht verfügbar" -ForegroundColor Red
}
finally
{
    Write-Host "Ich werde immer ausgeführt" -ForegroundColor Magenta
}