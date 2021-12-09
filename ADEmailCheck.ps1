<#
THINGS TO DO:
Pull each User account in a selected OU, check if Email attribute is filled
Compile list of users without an email, likely Out-File .csv

THINGS NOT TO DO
Replace/fix emails, tool is only informational
#>



Clear-Host
Write-Host "eTop Technology AD Email Tool" -ForegroundColor Yellow
Write-Verbose "Version 1.0"
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "Available options:"
Write-Host "(1) Export CSV with users that do not have the Email attribute filled"
Write-Host "(2) Export CSV with all users and corresponding Email attribute values"
Write-Host "(3) Perform both tasks"
$CheckType = Read-Host "Please enter the number corresponding with what you would like to do"
Write-Verbose "Option selected: $CheckType"

If ($CheckType -eq "1") {
    Write-Verbose "Exporting list to $ENV:UserProfile\Desktop\AccountsMissingEmails.csv"
    Get-ADUser -Filter {(Mail -NOTLIKE "*") -and (enabled -eq $true)} | Select-Object Name | Export-Csv $ENV:UserProfile\Desktop\AccountsMissingEmails.csv
    Read-Host "All set, you can find the list in $ENV:UserProfile\Desktop\AccountsMissingEmails.csv. Press Enter to exit"
} elseif ($CheckType -eq "2") {
    Write-Verbose "Exporting list to $ENV:UserProfile\Desktop\CurrentEmails.csv"
    Get-ADUser -Filter * -Properties DisplayName, EmailAddress | Select-Object DisplayName, EmailAddress | Export-CSV $ENV:UserProfile\Desktop\CurrentEmails.csv
    Read-Host "All set, you can find the list in $ENV:UserProfile\Desktop\CurrentEmails.csv. Press Enter to exit"
} elseif ($CheckType -eq "3") {
    Write-Verbose "Exporting list to $ENV:UserProfile\Desktop\AccountsMissingEmails.csv"
    Get-ADUser -Filter {(Mail -NOTLIKE "*") -and (enabled -eq $true)} | Select-Object Name | Export-Csv $ENV:UserProfile\Desktop\AccountsMissingEmails.csv
    Write-Verbose "Exporting list to $ENV:UserProfile\Desktop\CurrentEmails.csv"
    Get-ADUser -Filter * -Properties DisplayName, EmailAddress | Select-Object DisplayName, EmailAddress | Export-CSV $ENV:UserProfile\Desktop\CurrentEmails.csv
    Read-Host "All set, you can find the lists in $ENV:UserProfile\Desktop. Press Enter to exit"
} else {
    Read-Host "Invalid selection. Press enter to try again"
}