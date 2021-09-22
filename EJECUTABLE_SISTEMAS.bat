@echo off
TITLE Bienvenido %USERNAME% a Auto_ejecutable KOBA_BOGOTA
MODE con:cols=80 lines=40

:inicio
SET var=0
cls
echo ------------------------------------------------------------------------------
echo  %DATE% ^| %TIME%
echo ------------------------------------------------------------------------------
wmic bios get serialnumber
echo ------------------------------------------------------------------------------
echo  1    INSTALACION SOFTWARE TIENDA
echo  2    DEFINIR IP
echo  3    BAJAR FIREWALL
echo  4    DAR PERMISOS A USUARIOS AL ESCRITORIO REMOTO
echo  5    MAPEAR CARPETAS TIENDA Y CREAR ICONOS
echo  6    DESHABILITAR LA TARGETA DE RED DE VIRTUALBOX
echo  7    INSTALACION DE EQUIPO NUEVO DESPUES DE DOMINIO
echo  8    REINICIAR  WEB REPORT
echo  9    Salir
echo ------------------------------------------------------------------------------
echo.

SET /p var= ^> Seleccione una opcion [1-6]:

if "%var%"=="0" goto inicio
if "%var%"=="1" goto op1
if "%var%"=="2" goto op2
if "%var%"=="3" goto op3
if "%var%"=="4" goto op4
if "%var%"=="5" goto op5
if "%var%"=="6" goto op6
if "%var%"=="7" goto op7
if "%var%"=="8" goto op8
if "%var%"=="9" goto salir

::Mensaje de error, validación cuando se selecciona una opción fuera de rango
echo. El numero "%var%" no es una opcion valida, por favor intente de nuevo.
echo.
pause
echo.
goto:inicio

:op1
    echo.
    echo. Has elegido la opcion No. 1
    echo.
        ::Aquí van las líneas de comando de tu opción
        1_npp.exe /S
        echo. SE INSTALO NOTEPAD++
        2_WebComponents.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
        echo. SE INSTALO WebComponents PARA LAS CAMARAS
        Installers\GoogleChromeStandaloneEnterprise64.msi /qb /norestart
        echo. SE INSTALO GoogleChrome
        3_Apache_OpenOffice.exe /S
        echo. SE INSTALO OpenOffice
        4_Firefox47.exe -ms
        echo. SE INSTALO Firefox47
        5_VirtualBox-6_0_20.exe
        echo. SE INSTALO VirtualBox-6_0_20
        7_UltraVNC.exe /silent /norestart
        echo. SE INSTALO UltraVNC
        7z.exe
        echo. SE INSTALO 7z
        AcroRdrDC.exe
        echo. SE INSTALO AcroBAT
        jdk-6u45-windows-i586.exe
        echo. SE INSTALO vlc
        copy r:\software_roll_out_modificado\Otros\webReport.7z  c:\
        echo. SE PEGO EL WEB REPORT EN UNIDAD C
        echo. SE INSTALO jdk
        6_vlc-3.0.2-win64.exe /S
        echo. SE INSTALO VLCT
        C:\webReport\Install.bat
        C:\webReport\StartTomee.bat
        net start Mysql
        net start webReport
        echo. SE INSTALO WEB REPORT Y SE INICIARON SERVICIOS
        net start Mysql
        win-lide300-1_0-n_mcd
        echo. SE INSTALO DRIVER DE SCANNER

    echo.
    pause
    goto:inicio

:op2
    echo.
        ::Aquí van las líneas de comando de tu opción
        netsh interface show interface
        SET /p targeta_red=Escriba el Nombre interfaz a definir ip:
            netsh interface ipv4 set dnsservers  %targeta_red%  static 172.18.164.226 primary
            netsh interface ipv4 add dnsservers  %targeta_red%  10.90.0.13 index=2
        SET /p IP_EQUIPO= ^> Escriba la ip para equipo :
        set /p IP_PUERTA= ^> Escriba la ip para equipo :
            echo  %IP_EQUIPO%
            echo  %IP_PUERTA%
            echo  %targeta_red%
                NETSH INTERFACE IPV4 SET ADDRESS NAME=%targeta_red% static %IP_EQUIPO% 255.255.255.128 %IP_PUERTA%
            echo. CAMBIO DE IP CORRECTAMENTE
    echo.
    pause
    goto:inicio

:op3
    echo.
    echo.
        netsh advfirewall set allprofiles state off
    echo.
    echo.SE BAJO EL FIREWALL
    pause
    goto:inicio

:op4
    echo.
    echo. Has elegido la opcion No. 4
    echo.
        sc config RemoteRegistry start= auto
        net start remoteregistry
        reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
        net localgroup "Usuarios de escritorio remoto" "freddy.barreto" /add
        net localgroup "Usuarios de escritorio remoto" "jorge.leon" /add
        net localgroup "Usuarios de escritorio remoto" "jose.lara" /add
        net localgroup "Usuarios de escritorio remoto" "usrtiendafnz" /add
    echo.
    pause
    goto:inicio

:op5
    echo.
    echo. Has elegido la opcion No. 5
    echo.
        net use * /d /y
        net use K: \\10.26.0.7\06_tiendas
        COPY \\10.26.0.6\06_sistemas\6.Escritorio\KOBA_BOGOTA.lnk  C:\Users\USRTIENDAFNZ\Desktop\
        mkdir c:\Users\USRTIENDAFNZ\Desktop\ESCANNER_LOCAL
    echo.
    pause
    goto:inicio
:op6
    echo.
    echo. Has elegido la opcion No. 6
    echo.
        netsh interface set interface "VirtualBox Host-Only Network" admin=disable
        netsh advfirewall set allprofiles state off
    echo.
    pause
    goto:inicio
:op7
    echo.
    echo. Se inicia configuracion de equipo de equipo
    goto:op5
    goto:op6
    goto:op2
    net start Mysql
    net start webReport

    goto inicio

:op8
    echo.
    echo. SE INICIA A BAJAR SERVICIOS DE WEB webReport
    net stop Mysql
    net start Mysql
    net stop webReport
    net start webReport
    C:\webReport\StartTomee.bat
    echo.
    pause
    goto:inicio

:salir
    wmic bios get serialnumber
    pause
    @cls&exit