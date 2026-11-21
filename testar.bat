@echo off
rem Roda os testes. Exemplos: "testar.bat 3" testa so a fase 3; "testar.bat" testa todas.
"C:\Program Files\LOVE\lovec.exe" "%~dp0." --teste %1
