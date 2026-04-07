@echo off
title Windows Hardware Service
color 0b

:: --- PROVERA ADMINISTRATORA ---
net session >nul 2>&1
if %errorLevel% neq 0 (exit)

:: 1. MASKA ZA PROCESOR (Ryzen 9 7950X3D)
:: Ovo menja ime u System About i Task Manageru (za svih 12 logičkih procesora)
for /L %%i in (0,1,11) do (
    reg add "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\%%i" /v "ProcessorNameString" /t REG_SZ /d "AMD Ryzen 9 7950X3D 16-Core Processor" /f >nul
)

:: 2. MASKA ZA GRAFIČKU (RTX 4090)
:: Koristimo tvoj ID (VEN_1002&DEV_164C) da upišemo originalno NVIDIA ime
powershell -Command "$path = 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1002&DEV_164C&SUBSYS_887A103C&REV_C2'; $id = (Get-ChildItem $path).Name; foreach($item in $id) { reg add \"$item\" /v \"FriendlyName\" /t REG_SZ /d \"NVIDIA GeForce RTX 4090\" /f; reg add \"$item\" /v \"DeviceDesc\" /t REG_SZ /d \"NVIDIA GeForce RTX 4090\" /f }"

:: 3. MASKA ZA RAM (Prikaz 64GB)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PhysicalAddressExtension" /t REG_DWORD /d 1 /f >nul

:: 4. TOTAL FPS BOOST (Gasi kočnice Windowsa)
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f >nul
:: Prioritet za igre
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul

:: 5. CISCENJE SMECA KOJE KOCI FPS
del /s /q "%LocalAppData%\FiveM\FiveM.app\cache\browser\*" >nul 2>&1
del /s /q "%LocalAppData%\FiveM\FiveM.app\cache\db\*" >nul 2>&1
ipconfig /flushdns >nul

exit
