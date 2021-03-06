@echo off

call DownloadExternals.cmd

rem
rem Update this version number with every release
rem
setlocal
set version=2.48

set msiversion=%version:.=%
set normal=GitExtensions%msiversion%Setup.msi
set complete=GitExtensions%msiversion%SetupComplete.msi

set msbuild="%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
set output=bin\Release\GitExtensions.msi
set project=Setup.wixproj

set build=%msbuild% %project% /t:Rebuild /p:Version=%Version% /p:NumericVersion=%Version% /p:Configuration=Release /nologo /v:m

echo Creating installers for Git Extensions %version%
echo.

echo Removing %normal%
del %normal% 2> nul

echo Removing %complete%
del %complete% 2> nul

echo.

echo Building %normal%
%build% /p:IncludeRequiredSoftware=0
IF ERRORLEVEL 1 EXIT /B 1
copy bin\Release\GitExtensions.msi %normal%
IF ERRORLEVEL 1 EXIT /B 1

echo Building %complete%
%build% /p:IncludeRequiredSoftware=1
IF ERRORLEVEL 1 EXIT /B 1
copy bin\Release\GitExtensions.msi %complete%
IF ERRORLEVEL 1 EXIT /B 1
