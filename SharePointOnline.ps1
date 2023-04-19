# Install
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
#Import
Import-Module Microsoft.Online.SharePoint.PowerShell 

# All cmdlet nouns begin with SPO
Connect-SPOService -Url https://oratoria-admin.sharepoint.com

################ Groups and permissions ################
# Full Control, Design, Edit, Approve, Contribute, Read
# SharePoint groups are specific to the site in which they were created
New-SPOSiteGroup -Group Parlamentares -PermissionLevels Contribute -Site https://oratoria.sharepoint.com/sites/Parlamento
# List Groups for a Site
Get-SPOSiteGroup -Site https://oratoria.sharepoint.com/sites/Parlamento
# Modify Permissions of a Group
Set-SPOSiteGroup -Site https://oratoria.sharepoint.com/sites/Parlamento -Group MarketingUsersParlamentares -PermissionLevelsToAdd Approve
Set-SPOSiteGroup -Site https://oratoria.sharepoint.com/sites/Parlamento -Group MarketingUsersParlamentares -PermissionLevelsToRemove Contribute

################ Users ################
# # To give permissions to Azure AD users, you must make them members of a SharePoint group.
# Add Azure AD user
Add-SPOUser -Site https://oratoria.sharepoint.com/sites/Parlamento -Group Parlamento -LoginName CalistoEloi@deputados.com
# Remove AD user from single site group
Remove-SPOUser -Site https://oratoria.sharepoint.com/sites/Parlamento -Group Parlamento -LoginName CalistoEloi@deputados.com
# Remove AD user from all site groups
Remove-SPOUser -Site https://oratoria.sharepoint.com/sites/Parlamento -LoginName CalistoEloi@deputados.com
# Set AD user as site administrator
Set-SPOUser -Site https://oratoria.sharepoint.com/sites/Parlamento -LoginName CalistoEloi@deputados.com -IsSiteCollectionAdmin $true

################ Sites ################
# Add new site, sets owner and storage quota (all parameters are mandatory)
New-SPOSite -Url https://oratoria.sharepoint.com/sites/CidadaosDeMiranda -Owner CalistoEloi@deputados.com -StorageQuota 256
# Add new site, sets owner and storage quota (mandatory) and template
New-SPOSite -Url https://oratoria.sharepoint.com/sites/CidadaosDeMiranda -Owner CalistoEloi@deputados.com -StorageQuota 256 -Template "STS#0"
# Get list of all available templates
Get-SPOWebTemplate
# Modify existing site
Set-SPOSite -Identity https://oratoria.sharepoint.com/sites/CidadaosDeMiranda -Title "Calisto Eloi Fans" 

# List all sites on tenant
Get-SPOSite
# List properties of a single site
Get-SPOSite -Identity https://oratoria.sharepoint.com/sites/CidadaosDeMiranda | Format-List
# Remove a site (send to recycle bin)
Remove-SPOSite -Identity https://oratoria.sharepoint.com/sites/CidadaosDeMiranda
# Restore site from recycle bin
Restore-SPODeletedSite -Identity https://oratoria.sharepoint.com/sites/CidadaosDeMiranda
# Delete site from recycle bin (must be SharePoint adminn or global admin)
Remove-SPODeletedSite -Identity https://oratoria.sharepoint.com/sites/CidadaosDeMiranda

# Set site sharing capabilities
# ExternalUserAndGuestSharing, ExternalUserSharingOnly, ExistingExternalUserSharingOnly, Disabled
Set-SPOSite -https://adatum.sharepoint.com/sites/Marketing -SharingCapability Disabled