<#
Active Directory Reset Password and Change at Login.
.Description
This script resets users passwords to a common password, and requires them to change it at next logon
.How to use
Must be run on a domain controller. Modify the 'P@ssword123!' string to whatever you'd like. Also modify the searchbase OU structure to match your environment.
.Created by
Nathan Studebaker
#>

#Import the ad module
import-module activedirectory

#define the new password
$newpwd = ConvertTo-SecureString -String "P@ssword123!" -AsPlainText –Force

#get the users in ad. we can filter by OU
$users = get-aduser -filter * -searchbase "OU=test,OU=testnb users,DC=testnb,DC=local" | select Surname

#Logic to reset password
ForEach($user in $users)
{
$username = $user.samaccountname
Set-ADAccountPassword -Identity $username -NewPassword $newpwd –Reset -PassThru | Set-Aduser -changepasswordatlogon $True
}
