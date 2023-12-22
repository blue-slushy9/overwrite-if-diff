# This is a PS script that will copy items from a source directory to a
# destination directory, only if the item is not already present in the 
# destination, or if the item is present but is an older version of the file;

# Create your first dictionary, for the source drive, that will store your 
# checksum values for the first drive;
$dictionary1 = [Ordered]@{}

# Create your second dictionary, for the destination drive, that will store
# your checksum values for your second drive;
#$dictionary2 = [Ordered]@{}

function calc-chksums($path) {
  Get-ChildItem $path -Recurse | ForEach-Object {
    if ($_.PSIsContainer) {  # If it's a directory
      if "$($_.FullName[0])" != ".") {
        calc-chksums $_.FullName  # Recursively call the function
      } else {
      # The key will be the full filepath of the file;
      #$dictionary1.Add(key = $($_.FullName))

        $hash = (Get-FileHash -Path $($_.FullName) -Algorithm MD5)

        # The value will be the MD5 checksum for the file;
        $dictionary1.Add("$_.FullName", "$hash")
      }
    } 
  }
}

# Call the function that calculates the checksums, enter the letter of your first drive; 
calc-chksums "E:\"

Write-Host "$dictionary1"

<#
# Call the function that calculates the checksums, enter the letter of your second drive;
calc-chcksums "E:\"

for file in dictionary1 {
  if file not in dictionary2:
    Copy-Item file -Force
  else if file in dictionary2:
    if file[value1] != file[value2]
      Copy-Item file -Force
    else do-nothing

}
#>