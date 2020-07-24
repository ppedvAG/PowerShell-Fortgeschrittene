configuration WebServerConfiguration
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node $AllNodes.NodeName
    {
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
#WebServerConfiguration -OutputPath .\WebServerConfigurationwithconfigurationData -ConfigurationData .\WebServerConfigurationwithconfigurationData\ConfigurationData.psd1