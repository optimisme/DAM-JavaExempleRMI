$folderDevelopment = "Project"
$folderRelease = "Release"

# Get into the development directory
Set-Location $folderDevelopment

# Remove any existing .class files from the bin directory
if (Test-Path -Path "./bin") {
    Remove-Item -Recurse -Force -Path "./bin"
}

# Create the bin directory if it doesn't exist
New-Item -ItemType Directory -Force -Path ./bin | Out-Null

# Copy the assets directory to the bin directory
if (Test-Path -Path "./assets") {
    Copy-Item -Recurse -Force ./assets ./bin/assets
}

# Compile the Java source files and place the .class files in the bin directory
javac -d ./bin/ ./src/*.java

# Create the Project.jar file with the specified manifest file and the contents of the bin directory
$jarExePath = Get-ChildItem -Path C:\ -Recurse -Filter "jar.exe" -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
$manifestFile = "Manifest.txt"
$jarFile = Join-Path -Path $folderRelease -ChildPath "Project.jar"
$jarArgs = @("cfm", "`"$jarFile`"", "`"$manifestFile`"", "-C", "bin", ".")
Start-Process -FilePath $jarExePath -ArgumentList $jarArgs -Wait -WorkingDirectory $PWD

# Remove any .class files from the bin directory
Remove-Item -Recurse -Force ./bin

# Get out of the development directory
Set-Location ..
<#
# Move the Project.jar file to the release directory
Remove-Item -Recurse -Force ./$folderRelease
New-Item -ItemType Directory -Force -Path ./$folderRelease | Out-Null
Move-Item ./$folderDevelopment/Project.jar ./$folderRelease/Project.jar

# Create the 'run.ps1' file
@"
java -jar Project.jar
"@ | Set-Content -Path ./$folderRelease/run.ps1 -Encoding UTF8

# Create the 'run.sh' file
@"
#!/bin/bash
java -jar Project.jar
"@ | Set-Content -Path ./$folderRelease/run.sh -Encoding UTF8

# Run the Project.jar file
Set-Location ./$folderRelease
./run.ps1
Set-Location ..
#>