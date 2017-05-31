#icacls_perm.ps1

#starting path
$StartDir="path_to_dir" 

#rights for files/folders (F (full access) M (modify access) RX (read and execute access) R (read-only access) W (write-only access)) 
$Rights="RX"

#filter for folder or file name, for wildcard use *
$Filter="filter_goes_here"

#selecting principial in format: domain\user
$Principal="domain\user"

#confirmation to run script
$Check=Read-Host `n "This will change permissions on all files and folders containing"$filter.ToUpper()"in the name" `n `
"for"$Principal.ToUpper()"with the new righs of"$Rights.ToUpper() `n `
"Continue? [Y/N]"

#loop if yes
if ($Check -eq "Y") {
#filtering files to apply the access rights by $entity    
  foreach ($file in $(Get-ChildItem -Path $StartDir -Recurse -Filter $filter)) {
    #ADD new permission with iCACLS
    iCACLS $file.FullName /grant "${Principal}:$Rights" /T >$NULL  #switch /t (tree)updates all files and container
    #display new permissions
    Write-Host "New Settings:"
    iCACLS $file.FullName
    }
 }
 #loop if else - write message for bad choice.
 else {                                                                              
 Write-Host -foregroundcolor "Red" `
    `n "You have chosen"$Check.ToUpper()"- exiting script."`n
    exit
 }
