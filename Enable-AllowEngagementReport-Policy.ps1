#Import MicrosoftTeams module
Import-Module -Name MicrosoftTeams

#Get User Credential
Write-Host -F Cyan "Introduzca sus credenciales..."
$credential = Get-Credential -Credential $null #Show "No Message" in PowerShell

#Connect to Microsoft Teams
Write-Host -F Cyan -NoNewLine "Conectandose a Microsoft Teams. Por favor, espere..."
Connect-MicrosoftTeams -Credential $credential

#Connection to Skype for Business Online and import into Ps session
Write-Host -F Cyan "Abriendo sesion. Por favor, espere..."
$session = New-CsOnlineSession -Credential $credential
Import-PsSession $session
Enable-CsOnlineSessionForReconnection

#Show current status
Write-Host -F Cyan "Estado actual de la politica de informes para Teams"
Get-CsTeamsMeetingPolicy | Where { $_.Identity -eq "Global" } | Select AllowEngagementReport

#Enable AllowEngagementReport policy
Write-Host -F Cyan "Actualizando estado..."
Set-CsTeamsMeetingPolicy -Identity Global -AllowEngagementReport "Enabled"

Write-Host -F Green "Politica actualizada correctamente."
Write-Host

#Show updated status
Write-Host -F Cyan "Estado actualizado de la politica de informes para Teams"
Get-CsTeamsMeetingPolicy | Where { $_.Identity -eq "Global" } | Select AllowEngagementReport

#Close Ps session
Write-Host -F Cyan "Cerrando sesion. Por favor, espere..."
Remove-PsSession $session

Write-Host -F Green -NoNewLine "La sesion se ha desconectado correctamente. Ya puede cerrar la ventana."