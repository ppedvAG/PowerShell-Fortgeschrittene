@{
    AllNodes = @(
        @{
            NodeName = "Member1"
            WindowsFeature = @(
                @{
                    Name = "Web-Server"
                    Ensure = "Present"
                },
                @{
                    Name = "Web-Mgmt-Tools"
                    Ensure = "Present"
                }
            )
          }         
    )
}
# Speichert ConfigurationData in einer Datei mit der Dateierweiterung "PSD1".