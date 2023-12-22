# This is a PS script that will copy items from a source directory to a
# destination directory, only if the item is not already present in the 
# destination, or if the item is present but is an older version of the file;



function calc-chksums($path) {
  Get-ChildItem $path -Recurse | ForEach-Object {
    if ($_.PSIsContainer) {  # If it's a directory
      Process-Directory $_.FullName  # Recursively call the function
    } else {
      # Process the file
      Write-Host "Processing file: $($_.FullName)"
      # Calculate the checksum for the file
      Get-FileHash -Path $($_.FullName) [-Algorithm MD5]

    }
  }
}

# Create your first dictionary that will store your checksum values for the first drive;
$dictionary1 = [Ordered]@

# Call the function that calculates the checksums, enter the letter of your first drive; 
calc-chksums "D:\"

# Create your second dictionary that will store your checksum values for your second drive;
$dictionary2 = [Ordered]@

# Call the function that calculates the checksums, enter the letter of your second drive;
calc-chcksums "E:\"

