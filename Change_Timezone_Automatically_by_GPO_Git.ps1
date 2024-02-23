# Localisation géo avec ip via api Geolocation --> free
function Get-CurrentLocation {
    try {
        $response = Invoke-RestMethod -Uri 'http://ip-api.com/json/'
        return $response.country
    } catch {
        Write-Host "Erreur lors de la récupération de la localisation : $_"
        return $null
    }
}

# Mappage pays + fuseaux horaires
$timeZoneMap = @{
    "France" = "Romance Standard Time";
    "Morocco" = "Morocco Standard Time";
    "Tunisia" = "W. Central Africa Standard Time";
    "Germany" = "W. Europe Standard Time";
    "Poland" = "Central European Standard Time";
    "Italy" = "W. Europe Standard Time";
    "United States" = "Eastern Standard Time";
    "Canada" = "Eastern Standard Time";
    "Brazil" = "E. South America Standard Time";
    "United Kingdom" = "GMT Standard Time";
    "India" = "India Standard Time";
    "Japan" = "Tokyo Standard Time";
    "Australia" = "AUS Eastern Standard Time";
    "Russia" = "Russian Standard Time";
    "China" = "China Standard Time";
    "South Africa" = "South Africa Standard Time";
    "Mexico" = "Central Standard Time (Mexico)";
    "Spain" = "Romance Standard Time";
    "Sweden" = "W. Europe Standard Time";
    "Netherlands" = "W. Europe Standard Time";
    "Argentina" = "Argentina Standard Time";
    # j'en ai déjà mis pas mal, voir si besoin d'en rajouter
}

# Obtention localisation actuelle
$currentLocation = Get-CurrentLocation

if ($currentLocation -ne $null) {
    $timeZone = $timeZoneMap[$currentLocation]
    if ($timeZone -ne $null) {
        Set-TimeZone -Id $timeZone
        Write-Host "Fuseau horaire mis à jour pour $currentLocation : $timeZone"
    } else {
        Write-Host "Aucun fuseau horaire trouvé pour la localisation : $currentLocation"
    }
} else {
    Write-Host "La localisation n'a pas pu être déterminée."
}

#####################################
#  .-. .-')       (`-.   _  .-')    #
#  \  ( OO )    _(OO  )_( \( -O )   #
#  ,--. ,--.,--(_/   ,. \,------.   #
#  |  .'   /\   \   /(__/|   /`. '  #
#  |      /, \   \ /   / |  /  | |  #
#  |     ' _) \   '   /, |  |_.' |  #
#  |  .   \    \     /__)|  .  '.'  #
#  |  |\   \    \   /    |  |\  \   #
#  `--' '--'     `-'     `--' '--'  #
#####################################