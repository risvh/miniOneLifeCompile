@echo off
for /D %%i in (*) do (
    if exist .\%%i\*.fcz del /s /q .\%%i\*.fcz
)
pause