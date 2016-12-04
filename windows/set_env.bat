@echo off
SETX GOOGLE_DRIVE "%USERPROFILE%\GoogleDrive"
echo "GOOGLE_DRIVE: [%GOOGLE_DRIVE%]"

SETX DOTFILES "%GOOGLE_DRIVE%\dotfiles"
echo "DOTFILES: [%DOTFILES%]"

SETX DOTFILES_WIN "%DOTFILES%\win"
echo "DOTFILES_WIN: [%DOTFILES_WIN%]"

SETX MYSCRIPTS "%GOOGLE_DRIVE%\myscripts"
echo "MYSCRIPTS: [%MYSCRIPTS%]"

rem SETX PATH "%PATH%;%MYSCRIPTS%"
rem echo "PATH: [%PATH%]"


rem SETX /M JAVA_HOME "C:\Program Files\Java\jdk1.8.0_74"
rem echo "JAVA_HOME: [%JAVA_HOME%]"

pause
exit
