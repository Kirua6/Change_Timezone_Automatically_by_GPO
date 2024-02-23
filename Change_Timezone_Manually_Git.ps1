Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Création fenêtre principale 
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select Time Zone'
$form.Size = New-Object System.Drawing.Size(500,400) # Taille augmentée
$form.StartPosition = 'CenterScreen'

# Création + conf liste déroulante all continents
$comboBoxContinent = New-Object System.Windows.Forms.ComboBox
$comboBoxContinent.Location = New-Object System.Drawing.Point(10,10)
$comboBoxContinent.Size = New-Object System.Drawing.Size(460,50) # Taille augmentée
$comboBoxContinent.Font = New-Object System.Drawing.Font("Arial", 14) # Police plus grande

# Création + conf liste déroulante all pays
$comboBoxCountry = New-Object System.Windows.Forms.ComboBox
$comboBoxCountry.Location = New-Object System.Drawing.Point(10,70)
$comboBoxCountry.Size = New-Object System.Drawing.Size(460,50) # Taille augmentée
$comboBoxCountry.Font = New-Object System.Drawing.Font("Arial", 14) # Police plus grande
$comboBoxCountry.Enabled = $false

# Création bouton confirmation
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10,130)
$button.Size = New-Object System.Drawing.Size(460,50) # Taille augmentée
$button.Text = 'Confirm'
$button.Font = New-Object System.Drawing.Font("Arial", 14) # Police plus grande
$button.Enabled = $false

# Ajout contrôles fenêtre
$form.Controls.Add($comboBoxContinent)
$form.Controls.Add($comboBoxCountry)
$form.Controls.Add($button)

# Ma signature intégrée en ASCII Art
$asciiArt = @"
.-. .-')       ('-.   _  .-')   
\  ( OO )    _(OO  )_( \( -O )  
,--. ,--.,--(_/   ,. \,------.  
|  .'   /\   \   /(__/|   /'. ' 
|      /, \   \ /   / |  /  | | 
|     ' _) \   '   /, |  |_.' | 
|  .   \    \     /__)|  .  '.' 
|  |\   \    \   /    |  |\  \  
'--' '--'     '-'     '--' '--' 
"@

# Création TextBox pour afficher ASCII Art
$textBoxAscii = New-Object System.Windows.Forms.TextBox
$textBoxAscii.Multiline = $true
$textBoxAscii.Text = $asciiArt
$textBoxAscii.Font = New-Object System.Drawing.Font("Courier New", 8)
$textBoxAscii.Size = New-Object System.Drawing.Size(460, 150) # Taille ajustée pour l'art ASCII
$textBoxAscii.Location = New-Object System.Drawing.Point(10, 190)
$textBoxAscii.ScrollBars = 'Vertical'
$textBoxAscii.ReadOnly = $true
$textBoxAscii.TextAlign = 'Center' # Centrer le texte

# Ajout TextBox fenetre
$form.Controls.Add($textBoxAscii)

# Dictionnaire {continents + pays} = fuseaux horaires
$continents = @{
    "Europe" = @{
        "France" = "Romance Standard Time";
        "Germany" = "W. Europe Standard Time";
        "Poland" = "Central European Standard Time";
        "Italy" = "W. Europe Standard Time";
        "Spain" = "Romance Standard Time";
        "United Kingdom" = "GMT Standard Time";
    };
    "Africa" = @{
        "Morocco" = "Morocco Standard Time";
        "Tunisia" = "W. Central Africa Standard Time";
        "Nigeria" = "W. Central Africa Standard Time";
        "South Africa" = "South Africa Standard Time";
        "Egypt" = "Egypt Standard Time"
    };
    "Asia" = @{
        "China" = "China Standard Time";
        "India" = "India Standard Time";
        "Japan" = "Tokyo Standard Time";
        "South Korea" = "Korea Standard Time";
        "Thailand" = "SE Asia Standard Time"
    };
    "North America" = @{
        "United States" = "Eastern Standard Time";
        "Canada" = "Eastern Standard Time";
        "Mexico" = "Central Standard Time";
        "Panama" = "SA Pacific Standard Time";
        "Jamaica" = "SA Pacific Standard Time"
    };
    "South America" = @{
        "Brazil" = "E. South America Standard Time";
        "Argentina" = "Argentina Standard Time";
        "Colombia" = "SA Pacific Standard Time";
        "Chile" = "Pacific SA Standard Time";
        "Peru" = "SA Pacific Standard Time"
    };
    "Oceania" = @{
        "Australia" = "AUS Eastern Standard Time";
        "New Zealand" = "New Zealand Standard Time";
        "Fiji" = "Fiji Standard Time";
        "Papua New Guinea" = "West Pacific Standard Time";
        "Samoa" = "Samoa Standard Time"
    };
    "Antarctica" = @{
        "McMurdo" = "New Zealand Standard Time";
        "Casey" = "W. Australia Standard Time";
        "Davis" = "Central Asia Standard Time";
        "Mawson" = "West Asia Standard Time";
        "Palmer" = "Pacific SA Standard Time"
    }
}

# Remplissage liste continents
$comboBoxContinent.Items.AddRange($continents.Keys)

# Gestion événements
$comboBoxContinent.Add_SelectedIndexChanged({
    $comboBoxCountry.Items.Clear()
    $selectedContinent = $comboBoxContinent.SelectedItem
    $comboBoxCountry.Items.AddRange($continents[$selectedContinent].Keys)
    $comboBoxCountry.Enabled = $true
    $button.Enabled = $false
})

$comboBoxCountry.Add_SelectedIndexChanged({
    $button.Enabled = $true
})

$button.Add_Click({
    $selectedCountry = $comboBoxCountry.SelectedItem
    $timeZoneId = $continents[$comboBoxContinent.SelectedItem][$selectedCountry]
    try {
        Set-TimeZone -Id $timeZoneId
        [System.Windows.Forms.MessageBox]::Show("Time zone set to $timeZoneId for $selectedCountry.")
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error setting time zone.")
    }
})

# Afficher fenêtre
$form.ShowDialog()

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