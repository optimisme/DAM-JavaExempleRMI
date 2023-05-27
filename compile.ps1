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

# Create a temporary directory for the JAR contents
$tempDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

# Move the compiled class files to the temporary directory
Move-Item -Path ./bin/* -Destination $tempDir

# Create the JAR file using Java's JarOutputStream
$jarFile = Join-Path -Path $folderRelease -ChildPath "Project.jar"
$manifestFile = "Manifest.txt"
$jarOutputStream = New-Object -TypeName java.util.jar.JarOutputStream -ArgumentList (New-Object -TypeName java.io.FileOutputStream -ArgumentList $jarFile), (New-Object -TypeName java.util.jar.Manifest -ArgumentList (Get-Content $manifestFile))
$files = Get-ChildItem -Path $tempDir -Recurse
foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($tempDir.Length + 1)
    $jarEntry = New-Object -TypeName java.util.jar.JarEntry -ArgumentList $relativePath
    $jarOutputStream.PutNextEntry($jarEntry)
    $fileContent = Get-Content -Path $file.FullName -Raw
    $jarOutputStream.Write([System.Text.Encoding]::UTF8.GetBytes($fileContent), 0, $fileContent.Length)
    $jarOutputStream.CloseEntry()
}

# Clean up the temporary directory
Remove-Item -Recurse -Force $tempDir

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
"@ | Set-Content -Path ./$folderRelease/run.ps1 -Encoding UTF8

# Run the Project.jar file
Set-Location ./$folderRelease
./run.ps1
Set-Location ..
#>