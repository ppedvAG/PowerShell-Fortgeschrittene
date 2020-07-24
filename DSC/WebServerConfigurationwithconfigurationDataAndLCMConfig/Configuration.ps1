configuration WebServerConfiguration
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node $AllNodes.NodeName
    {
        #Konfigurieren des LCM (Local Configuration Manager)
        LocalConfigurationManager
        {
            #ConfigurationMode hat folgende Werte: ApplyandAutorCorrect, ApplyandMonitor, ApplyOnly
            ConfigurationMode = "ApplyAndAutoCorrect" 
            ConfigurationModeFrequencyMins = 15 #standardwert Wertbereich in Minuten 15 bis 44640
        }

        ForEach($Feature in $Node.WindowsFeature)
        {
            WindowsFeature $Feature.Name
            {
                Name = $Feature.Name
                Ensure = $Feature.Ensure
            }
        }          
    }
}

#Erzeugen der MOF Files durch ausführen der configuration. Wichtig hier muss dann eine ConfigurationData Datei mit der passenden Konfiguration angegeben werden
WebServerConfiguration -OutputPath C:\Kursbeispiele\DSC\WebServerConfigurationwithconfigurationDataAndLCMConfig -ConfigurationData C:\Kursbeispiele\DSC\WebServerConfigurationwithconfigurationDataAndLCMConfig\ConfigurationData.psd1