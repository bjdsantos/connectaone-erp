@echo off
rem ConnectaOne ERP - T001: roda o diagnostico somente leitura
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0verificar-ambiente.ps1"
echo.
echo Pode fechar esta janela.
pause
