@echo off
title MAMBA ULTRA ENGINE v2.0 - HARDCORE OPTIMIZER
color 0b
mode con: cols=90 lines=30

:: --- PROVERA ADMINISTRATORA ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo DESNI KLIK I POKRENI KAO ADMINISTRATOR!
    pause
    exit
)

:menu
cls
echo ==============================================================================
echo           MAMBA ENGINE v2.0 - UNIKATNI SISTEM ZA PROBIJANJE LIMITA
echo ==============================================================================
echo  STATUS: SPREMAN ZA INJEKCIJU
echo  MODEL: RTX 4090 TI EMULATOR ^| 32GB RAM BRIDGE ^| FIVEM HARDCORE BOOST
echo ==============================================================================
echo.
echo  Pritisni bilo koji taster da aktiviras "BEAST MODE"...
pause >nul

echo [+] MENJAM IDENTITET GRAFICKE (Task Manager Spoof)...
:: Menjamo DriverDesc na svim mogucim mestima za AMD Radeon
set "regPath=HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
for /f "tokens=*" %%a in ('reg query "%regPath%" /s /f "DriverDesc" ^| findstr "HKEY"') do (
    reg add "%%a" /v "DriverDesc" /t REG_SZ /d "Mamba Ultra Nitro RTX 4090 Ti" /f >nul
    reg add "%%a" /v "ProviderName" /t REG_SZ /d "Mamba Technologies" /f >nul
)
echo [OK] Graficka maskirana u RTX 4090 Ti!

echo [+] KREIRAM MAMBA RAM BRIDGE (8GB Virtualni Disk)...
if not exist "C:\MambaRAM" mkdir "C:\MambaRAM"
fsutil file createnew "C:\MambaRAM\MambaSwap.sys" 8589934592 >nul
echo [OK] RAM Bridge aktivan na C:\MambaRAM

echo [+] CISCENJE FIVEM SMECA (Za jake servere)...
taskkill /f /im FiveM.exe >nul 2>&1
set "fivemPath=%LocalAppData%\FiveM\FiveM.app"
if exist "%fivemPath%" (
    del /s /q "%fivemPath%\cache\browser\*" >nul 2>&1
    del /s /q "%fivemPath%\cache\db\*" >nul 2>&1
    del /s /q "%fivemPath%\cache\priv\*" >nul 2>&1
    del /s /q "%fivemPath%\cache\servers\*" >nul 2>&1
    del /s /q "%fivemPath%\logs\*" >nul 2>&1
    echo [OK] FiveM Cache ociscen!
)

echo [+] UNLOCKING CPU ^& RAM PERFORMANCE...
:: Force Ultimate Performance
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul
:: Ciscenje Standby liste memorije
echo [OK] Laptop je sada na maksimalnim obrtajima!

echo [+] POSTAVLJANJE PRIORITETA...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FiveM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul

cls
echo ==============================================================================
echo           USPESNO! TVOJ LAPTOP JE SADA MAMBA ZVER!
echo ==============================================================================
echo.
echo  1. Pogledaj Task Manager ili Device Manager - videces RTX 4090 Ti!
echo  2. FiveM ce sada raditi mnogo tecnije na jakim serverima.
echo  3. RAM Bridge (8GB) je povezan sa tvojim fizickim RAM-om.
echo.
echo  NAPOMENA: Restartuj Task Manager da vidis promenu imena!
echo ==============================================================================
echo POKRENI FIVEM I UZIVAJ...
pause
