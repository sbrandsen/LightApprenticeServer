
$clsid = "{C343ED84-A129-11d3-B799-0060B0F159EF}"
if (Test-Path -Path registry::HKEY_CLASSES_ROOT\CLSID\$clsid\InprocServer32) {
Read-Host -Prompt "Apprentice Server is already installed" 
exit
}

# Create a variable to store the total number of steps
$totalSteps = 5

# Create a variable to store the current step
$currentStep = 1

# Download the zip file
Write-Progress -Activity "Downloading zip file, Estimated amount of bytes: 55000000" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep / $totalSteps) * 100)
Invoke-WebRequest -Uri "https://github.com/sbrandsen/LightApprenticeServer/archive/refs/heads/main.zip" -OutFile "$env:USERPROFILE\Downloads\zipfile.zip"

# Update the current step variable
$currentStep++

# Unzip the file
Write-Progress -Activity "Unzipping file" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep / $totalSteps) * 100)
Expand-Archive -Force -Path "$env:USERPROFILE\Downloads\zipfile.zip" -DestinationPath "$env:USERPROFILE\Downloads\"

# Update the current step variable
$currentStep++

# Change directory to the unzipped folder
Write-Progress -Activity "Changing directory" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep / $totalSteps) * 100)
cd "$env:USERPROFILE\Downloads\LightApprenticeServer-main"

# Update the current step variable
$currentStep++

# Copy the "Apprenticeserver" folder to programdata
Write-Progress -Activity "Copying files" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep / $totalSteps) * 100)
Copy-Item -Force -Recurse -Path "Apprenticeserver" -Destination "C:\ProgramData"

# Update the current step variable
$currentStep++

# Remove the unzipped folder
Write-Progress -Activity "Removing files" -Status "Step $currentStep of $totalSteps" -PercentComplete (($currentStep / $totalSteps) * 100)
cd ..
Remove-Item -Path "$env:USERPROFILE\Downloads\LightApprenticeServer-main" -Recurse -Force
Remove-Item -Path "$env:USERPROFILE\Downloads\zipfile.zip" -Recurse -Force

# Display a message when the script is done
Write-Progress -Activity "Completed" -Status "All steps have been completed" -Completed
Write-Host "All steps have been completed"

Write-Host ""
Write-Host "Setting Registry"

if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}" -force -ea SilentlyContinue };
if((Test-Path -LiteralPath "HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}\InprocServer32") -ne $true) {  New-Item "HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}\InprocServer32" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}' -Name '(default)' -Value 'Inventor: Apprentice Server Component' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}\InprocServer32' -Name '(default)' -Value 'C:\ProgramData\ApprenticeServer\RxApprenticeServer.dll' -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKLM:\SOFTWARE\Classes\CLSID\{C343ED84-A129-11d3-B799-0060B0F159EF}\InprocServer32' -Name 'ThreadingModel' -Value 'Apartment' -PropertyType String -Force -ea SilentlyContinue;

Read-Host -Prompt "Apprentice Server is installed" 
