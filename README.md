# LightApprenticeServer
Install the Autodesk Apprentice Server without any extra dependencies. Tested for Inventor 2022. Will not run if Inventor (View) or Apprentice Server are installed already, since it is not needed anymore.

Installing any of these will overwrite this program. To fully delete, delete %ProgramData%\Apprenticeserver

# To install:
Run install.ps1 as admin

# WHY?
Apprentice install is now < 150mb instead of 600mb
It prevents the install of the following programs:
- **Autodesk Single Sign-On** allows users to access different Autodesk products with one set of login credentials.
- **Autodesk Desktop App** helps users keep software up to date and provides easy access to product information and resources.
- **Autodesk Genuine Service** ensures that users are using a genuine, licensed copy of Autodesk software.

Which are **NOT** required for this free software

Apprentice Server can be used to read iProperties data and other metadata from Inventor files. Using Apprentice Server instead of the Inventor API can make reading this metadata so fast that it can be used for live syncing with a database or Excel file.

# What does it do?

The PowerShell script performs the following actions:

1. It checks if a specific registry key "HKEY_CLASSES_ROOT\CLSID{C343ED84-A129-11d3-B799-0060B0F159EF}\InprocServer32" exists, if it does it prompts a message "Apprentice Server is already installed" and exit
2. Downloads a zip file from a specific url and save it in the user's download folder
3. Unzips the downloaded file
4. Changes the directory to the unzipped folder
5. Copies the "Apprenticeserver" folder to the programdata folder
6. Removes the unzipped folder and zip file
7. Then it creates a new registry key "HKLM:\SOFTWARE\Classes\CLSID{C343ED84-A129-11d3-B799-0060B0F159EF}\InprocServer32" and creates new property with value 'Inventor: Apprentice Server Component', also references this CSLID (Which is RxApprenticeServer to this new folder).
