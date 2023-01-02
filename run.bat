rem run with: .\run.bat

cls
rm -r -force .\bin
rm -r -force .\src\.*
rm -r -force .\lib\javafx-windows\lib\.*
mkdir bin
xcopy .\assets .\bin\assets /E /I /Y

javac -d .\bin\ .\src\*.java
java -cp ".;.\\bin;.\\bin" Main