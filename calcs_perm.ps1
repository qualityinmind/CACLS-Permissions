#calcs_perm.ps1

#starting path
$StartDir="folder_path" 

#rights for files/folders (can be F,C,R,W - FullAccess, Change, Read, Write) 
$Rights="rights_setting"

#filter for folder or file name, for wildcard use *
$Filter="folder_or_file_name"

#selecting principial in format: domain\user
$Principal="user_or_group"

#confirmation to run script
$Check=Read-Host `n "This will change permissions on all files and folders containing"$filter.ToUpper()"in the name" `n `
"for"$Principal.ToUpper()"with the new righs of"$Rights.ToUpper() `n `
"Continue? [Y/N]"

#loop if yes
if ($Check -eq "Y") {
#filtering files to apply the access rights by $entity    
  foreach ($file in $(Get-ChildItem -Path $StartDir -Recurse -Filter $filter)) {
    #ADD new permission with CACLS
    CACLS $file.FullName /E /P "${Principal}:${Rights}" >$NULL
    #display new permissions
    Write-Host "New Settings:"
    CACLS $file.FullName
    }
 }
 #loop if else - write message for bad choice.
 else {                                                                              
 Write-Host -foregroundcolor "Red" `
    `n "You have chosen"$Check.ToUpper()"- exiting script."`n
    exit
 }
