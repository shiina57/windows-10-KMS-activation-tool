    @echo off

    rem author: TrustDec
    rem 推薦MSDN原版映象:https://msdn.itellyou.cn
    chcp 65001
    set "Apply=%*"
    cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  cmd /u /c echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %Apply%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
    title Windows 10 數字權利啟用指令碼
    pushd "%~dp0"
    setlocal enabledelayedexpansion

    cls
    if /i "%PROCESSOR_IDENTIFIER:~0,3%"=="x86" (
    set bit=x86
    ) else (
    set bit=x64
        )
    echo ---------------------------------------------------------------
    echo     指令碼僅支援 Windows 10 系統，其它系統請勿執行此指令碼。

    echo     指令碼支援啟用以下版本 Windows 10，並獲取數字權利。
    
    echo ---------------------------------------------------------------

    echo     Windows 10 家庭版、家庭N、家庭單語言版、家庭中國版、Windows 10 S、Windows 10 SN。

    echo     專業版、專業N、專業教育版、專業教育N、專業工作站版、工作站N。

    echo     企業版、企業 （LTSB 2016）、教育版、教育N。

    echo ---------------------------------------------------------------
    echo     啟用時請保持電腦連網狀態，斷網情況下無法使用此方法啟用。

    echo     啟用可能一次無法成功，遇到無法成功的可以重新執行指令碼嘗試啟用。另外有些精簡版系統也可能無法啟用。

    echo ---------------------------------------------------------------
    echo     指令碼不支援路徑中帶有空格，請在路徑中不含空格的目錄下執行。

    echo     切換版本後最後的版本資訊顯示可能會有延時，請參考輸入的 KEY為證。或登出系統後再檢視。

    echo ---------------------------------------------------------------
    echo     按任意鍵開始，或按Ctrl+C退出指令碼！
    pause >nul

    :menu
    title Windows 10 數字權利啟用指令碼－選擇功能
    cls
    echo ---------------------------------------------------------------
    echo     請選擇任務。
    echo ---------------------------------------------------------------
    echo     [1]一鍵啟用當前版本。

    echo     [2]自定義選擇版本啟用。

    echo     [3]檢視當前系統版本資訊。

    echo     [4]安裝 KEY（不啟用）。

    echo     [5] 解除安裝系統預設 KEY。

    echo     [6]訪問指令碼釋出帖，（僅限遠景註冊使用者訪問）。

    echo     [7]退出指令碼。

    echo ---------------------------------------------------------------

    choice /n /c 1234567 /m 請輸入數字選擇
    cls
    if errorlevel 7 exit
    if errorlevel 6 goto url
    if errorlevel 5 goto uninstall
    if errorlevel 4 goto install
    if errorlevel 3 goto information
    if errorlevel 2 goto Choice
    if errorlevel 1 goto start

    :Choice
    title Windows 10 數字權利啟用指令碼－選擇版本
    cls
    echo ---------------------------------------------------------------
    echo     請選擇需要啟用的版本
    echo ---------------------------------------------------------------

    echo A= Windows 10 S （安裝證書僅限 16299）

    echo B= Windows 10 S N （安裝證書僅限 16299）

    echo ---------------------------------------------------------------

    echo 以下版本支援安裝 16299和 17134的證書。

    echo C= Windows 10 家庭版

    echo D= Windows 10 家庭 N

    echo E= Windows 10 家庭中國版

    echo F= Windows 10 家庭單語言版

    echo ---------------------------------------------------------------

    echo G= Windows 10 專業版

    echo H= Windows 10 專業 N

    echo I= Windows 10 專業教育版

    echo J= Windows 10 專業教育 N

    echo K= Windows 10 專業工作站版

    echo L= Windows 10 專業工作站 N

    echo ---------------------------------------------------------------

    echo M= Windows 10 教育版

    echo N= Windows 10 教育 N

    echo ---------------------------------------------------------------

    echo O= Windows 10 企業版

    echo P= Windows 10 企業 N

    echo Q= Windows 10 企業 LTSB

    echo R= Windows 10 企業 LTSB N

    echo ---------------------------------------------------------------

    echo.
    set /p pid="請輸入對應版本的字母，按 Enter開始"

    cls
    if /i "%pid%"=="a" goto Cloud
    if /i "%pid%"=="b" goto CloudN
    if /i "%pid%"=="c" goto Core
    if /i "%pid%"=="d" goto CoreN
    if /i "%pid%"=="e" goto CoreCountrySpecific
    if /i "%pid%"=="f" goto CoreSingleLanguage
    if /i "%pid%"=="g" goto Professional
    if /i "%pid%"=="h" goto ProfessionalN
    if /i "%pid%"=="i" goto ProfessionalEducation
    if /i "%pid%"=="j" goto ProfessionalEducationN
    if /i "%pid%"=="k" goto ProfessionalWorkstation
    if /i "%pid%"=="l" goto ProfessionalWorkstationN
    if /i "%pid%"=="m" goto Education
    if /i "%pid%"=="n" goto EducationN
    if /i "%pid%"=="o" goto Enterprise
    if /i "%pid%"=="p" goto EnterpriseN
    if /i "%pid%"=="q" goto EnterpriseS
    if /i "%pid%"=="r" goto EnterpriseSN
    echo. & echo 輸入錯誤，按任意鍵重新輸入！
    pause >nul && cls &&goto Choice

    :start
    cls
    wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0') get Name 2>nul | findstr /i "Windows" >nul 2>&1 && (echo. & echo 您使用的電腦已永久啟用！無需此操作。 & echo 請在未啟用的電腦上執行此指令碼，或選擇啟用其它版本。 & echo 按任意鍵退出指令碼！ & pause >nul && exit )

    for /f "tokens=3 delims= " %%i in ('cscript /nologo %SystemRoot%\System32\slmgr.vbs /dli ^| findstr /i "edition"') do (set edition=%%i)
    goto %edition%

    :Cloud
    set sku=178
    set pidkey=V3WVW-N2PV2-CGWC3-34QGF-VMJ2C
    set skus=Cloud
    goto activation

    :CloudN
    set sku=179
    set pidkey=NH9J3-68WK7-6FB93-4K3DF-DJ4F6
    set skus=CloudN
    goto activation

    :Core
    set sku=101
    set pidkey=YTMG3-N6DKC-DKB77-7M9GH-8HVX7
    set skus=Core
    goto activation

    :CoreN
    set sku=98
    set pidkey=4CPRK-NM3K3-X6XXQ-RXX86-WXCHW
    set skus=CoreN
    goto activation

    :CoreCountrySpecific
    set sku=99
    set pidkey=N2434-X9D7W-8PF6X-8DV9T-8TYMD
    set skus=CoreCountrySpecific
    goto activation

    :CoreSingleLanguage
    set sku=100
    set pidkey=BT79Q-G7N6G-PGBYW-4YWX6-6F4BT
    set skus=CoreSingleLanguage
    goto activation

    :Professional
    set sku=48
    set pidkey=VK7JG-NPHTM-C97JM-9MPGT-3V66T
    set skus=Professional
    goto activation

    :ProfessionalN
    set sku=49
    set pidkey=2B87N-8KFHP-DKV6R-Y2C8J-PKCKT
    set skus=ProfessionalN
    goto activation

    :ProfessionalEducation
    set sku=164
    set pidkey=8PTT6-RNW4C-6V7J2-C2D3X-MHBPB
    set skus=ProfessionalEducation
    goto activation

    :ProfessionalEducationN
    set sku=165
    set pidkey=GJTYN-HDMQY-FRR76-HVGC7-QPF8P
    set skus=ProfessionalEducationN
    goto activation

    :ProfessionalWorkstation
    set sku=161
    set pidkey=DXG7C-N36C4-C4HTG-X4T3X-2YV77
    set skus=ProfessionalWorkstation
    goto activation

    :ProfessionalWorkstationN
    set sku=162
    set pidkey=WYPNQ-8C467-V2W6J-TX4WX-WT2RQ
    set skus=ProfessionalWorkstationN
    goto activation

    :Education
    set sku=121
    set pidkey=YNMGQ-8RYV3-4PGQ3-C8XTP-7CFBY
    set skus=Education
    goto activation

    :EducationN
    set sku=122
    set pidkey=84NGF-MHBT6-FXBX8-QWJK7-DRR8H
    set skus=EducationN
    goto activation

    :Enterprise
    set sku=4
    set pidkey=XGVPP-NMH47-7TTHJ-W3FW7-8HV2C
    set skus=Enterprise
    goto activation

    :EnterpriseN
    set sku=27
    set pidkey=YHMNQ-PPQW2-P8PGP-32643-C372T
    set skus=EnterpriseN
    goto activation

    :EnterpriseS
    set sku=125
    set pidkey=NK96Y-D9CD8-W44CQ-R8YTK-DYJWX
    set skus=EnterpriseS
    goto activation

    :EnterpriseSN
    set sku=126
    set pidkey=C73T8-FNJRG-FTQWK-2JP2R-VMJWR
    set skus=EnterpriseSN

    :activation
    cls
    for /f "tokens=3 delims=." %%a in ('ver') do (set version=%%a)
    if not exist "%SystemRoot%\System32\spp\tokens\skus\%skus%" (
    title Windows 10 數字權利啟用指令碼－正在安裝數字證書
    xcopy /i /y /q %~dp0skus\%version%\%skus% "%SystemRoot%\System32\spp\tokens\skus\%skus%" >nul || goto end
    echo ---------------------------------------------------------------
    echo 正在安裝數字證書，此過程時間稍長，請耐心等待完成！
    cscript /nologo %SystemRoot%\System32\slmgr.vbs /rilc >nul
    ) else (
    goto next
        )

    :next
    title Windows 10 數字權利啟用指令碼－正在啟用
    for /f "tokens=3" %%k in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "start"') do (set services=%%k)
    if /i "%services%" gtr "0x3" (
    echo ---------------------------------------------------------------
    echo 正在開啟Windows Update服務
    sc config wuauserv start= auto >nul 2>nul
    ) else (
    goto activation1
        )

    :activation1

    echo ---------------------------------------------------------------

    echo      正在安裝KEY，請等待完成。

    echo ---------------------------------------------------------------

    cscript /nologo %SystemRoot%\System32\slmgr.vbs /ipk %pidkey% || goto error1
    timeout /nobreak /t 2 >nul
    wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0') get Name 2>nul | findstr /i "Windows" >nul 2>&1 && (echo. & echo 您選擇的版本已在本電腦上永久啟用！無需再次啟用。 & echo 請按任意鍵重新選擇！ & pause >nul && goto choice )

    sc start wuauserv >nul 2>nul
    echo ---------------------------------------------------------------
    echo 正在新增登錄檔
    reg add "HKLM\SYSTEM\Tokens" /v "Channel" /t REG_SZ /d "Retail" /f >nul
    reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Kernel-ProductInfo" /t REG_DWORD /d "%sku%" /f >nul
    reg add "HKLM\SYSTEM\Tokens\Kernel" /v "Security-SPP-GenuineLocalStatus" /t REG_DWORD /d "1" /f >nul
    reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%~dp0%bit%\gatherosstate.exe" /d "^ WIN7RTM" /f >nul

    echo ---------------------------------------------------------------

    echo     正在獲取數字門票，請等待完成。

    echo ---------------------------------------------------------------


    start /wait %~dp0%bit%\Gatherosstate.exe
    timeout /nobreak /t 4 >nul
    :Reset
    if not exist %~dp0%bit%\GenuineTicket.xml goto Reset
    clipup -v -o -altto %~dp0%bit%\

    echo ---------------------------------------------------------------
    cscript /nologo %SystemRoot%\system32\slmgr.vbs /ato

    echo ---------------------------------------------------------------
    echo 正在刪除登錄檔
    reg delete "HKLM\SYSTEM\Tokens" /f >nul
    reg delete "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%~dp0%bit%\gatherosstate.exe" /f >nul

    :error1
    if /i "%services%" gtr "0x3" (
    echo ---------------------------------------------------------------
    echo 正在禁用 Windows Update服務
    sc stop wuauserv >nul 2>nul
    sc config wuauserv start= disabled >nul 2>nul
    ) else (
    goto information
        )

    :information
    title Windows 10 數字權利啟用指令碼－版本資訊
    echo ---------------------------------------------------------------

    for /f "delims=" %%f in ('wmic os get caption ^| findstr /i "Microsoft"') do (echo %%f)

    for /f "tokens=2-4" %%f in ('ver') do (echo %%f %%g %%h)

for /f "tokens=5 delims= " %%f in ('cscript /nologo %SystemRoot%\System32\slmgr.vbs /dli ^| findstr /i "channel"') do  (echo 產品金鑰通道: %%f)

    for /f "skip=3 delims=" %%f in ('cscript /nologo %SystemRoot%\System32\slmgr.vbs /dli') do (echo %%f)

    echo ---------------------------------------------------------------

    pause
exit

    :url
    start "" "http://bbs.pcbeta.com/forum.php?mod=viewthread&tid=1786788&page=1#pid48314667"
    goto menu

    :install
    title Windows 10 數字權利啟用指令碼－安裝 KEY
    echo ---------------------------------------------------------------

    set /p install="請輸入或貼上需要安裝的 KEY，按 Enter安裝"

    cls

    echo ---------------------------------------------------------------

    echo      正在安裝KEY，請等待完成。

    echo ---------------------------------------------------------------

    cscript /nologo %SystemRoot%\System32\slmgr.vbs /ipk %install% || goto error

    echo ---------------------------------------------------------------

    for /f "tokens=3" %%k in ('cscript /nologo %SystemRoot%\System32\slmgr.vbs /dti') do (set ID=%%k)
    for /f "delims=" %%g in ("%ID%") do (
    set pid0=%%g
    set pid1=!pid0:~0,7!
    set pid2=!pid0:~7,7!
    set pid3=!pid0:~14,7!
    set pid4=!pid0:~21,7!
    set pid5=!pid0:~28,7!
    set pid6=!pid0:~35,7!
    set pid7=!pid0:~42,7!
    set pid8=!pid0:~49,7!
    set pid9=!pid0:~56,7!

    echo 安裝 ID: !pid1! !pid2! !pid3! !pid4! !pid5! !pid6! !pid7! !pid8! !pid9!
        )

    :error

    echo ---------------------------------------------------------------

    pause
exit

    :uninstall
    title Windows 10 數字權利啟用指令碼－解除安裝 KEY

    echo ---------------------------------------------------------------

    echo     正在解除安裝預設 KEY，請稍等。

    echo ---------------------------------------------------------------

    cscript /nologo %SystemRoot%\system32\slmgr.vbs /upk

    echo ---------------------------------------------------------------

pause
exit

    :end
    echo ---------------------------------------------------------------

    echo 證書複製失敗，請檢查 skus目錄是否完整，和系統版本是否支援！

    echo ---------------------------------------------------------------

    echo 按任意鍵退出指令碼。

    pause >nul
exit
