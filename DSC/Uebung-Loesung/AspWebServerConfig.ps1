configuration AspWebServer
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node ("Member1")
    {
        # Ressourcenanbieter aufrufen
        # Beispiel: WindowsFeature, File
        WindowsFeature WebServer
        {
           Ensure = "Present"
           Name   = "web-server"
        }
        WindowsFeature Asp
        {
           Ensure = "Present"
           Name   = "Web-Asp-Net45"
           DependsOn = "[WindowsFeature]WebServer"
        }

        Group IIS-Users
        {
            GroupName = "IIS-Users"
            Ensure = "Present"
        }      
    }
}