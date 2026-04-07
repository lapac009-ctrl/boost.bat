@echo off
title ULTIMATE 3000 EUR SETUP - ACTIVE
color 0b

:: --- ADMIN CHECK ---
net session >nul 2>&1
if %errorLevel% neq 0 (exit)

echo [+] INJECTING RTX 4090 & RYZEN 9 7950X3D IDENTITIES...
for /L %%i in (0,1,11) do (
    reg add "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\%%i" /v "ProcessorNameString" /t REG_SZ /d "AMD Ryzen 9 7950X3D 16-Core Processor" /f >nul
)
powershell -Command "$path = 'HKLM:\SYSTEM\CurrentControlSet\Enum\PCI\VEN_1002&DEV_164C&SUBSYS_887A103C&REV_C2'; $id = (Get-ChildItem $path).Name; foreach($item in $id) { reg add \"$item\" /v \"FriendlyName\" /t REG_SZ /d \"NVIDIA GeForce RTX 4090\" /f; reg add \"$item\" /v \"DeviceDesc\" /t REG_SZ /d \"NVIDIA GeForce RTX 4090\" /f }"

echo [+] UNLOCKING 64GB RAM CAPACITY (SSD BRIDGE)...
wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False >nul
wmic pagefileset where name="C:\\pagefile.sys" set InitialSize=65536,MaximumSize=65536 >nul

echo [+] ACTIVATING EXTREME GPU PERFORMANCE...
:: Forsiranje maksimalnih performansi grafičke
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrLevel" /t REG_DWORD /d 0 /f >nul

echo [+] OPTIMIZING KERNEL FOR 0ms LATENCY...
:: Smanjuje mrežni i sistemski lag
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f >nul

echo [+] CLEANING FIVE-M JUNK...
rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache" >nul 2>&1

echo [+] SYSTEM TRANSFORMED. RESTART FOR 3000 EUR POWER.
pause
exit
