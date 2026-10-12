@echo off 
setlocal EnableDelayedExpansion

rem ==================================================
rem stop-k8s.bat -- fully stop and clean up Connectra from k8s
rem ==================================================

set /p CONFIRM="Are you sure you want to stop Connectra? Type YES to continue: "
if /i "!CONFIRM!" NEQ "YES" (
    echo [INFO] Cancelled. Nothing was deleted.
    pause
    exit /b 0
)

echo.
echo [INFO] Deleting all resources in connectra namespace...

kubectl delete namespace connectra --wait=true

if !ERRORLEVEL! EQU 0 (
    echo.
    echo [OK] Namespace connectra and all associated resources deleted.
) else (
    echo.
    echo [WARN] Namespace connectra may not have existed.
)

rem Clean up any leftover PVCs/PVs
echo. 
echo [INFO] Cleaning up any leftover PersistentVolumes...
kubectl delete pvc mongodb-pvc -n connectra --ignore-not-found=true
kubectl delete pv --selector=app=mongodb --ignore-not-found=true 2>nul

echo.
echo ==========================================
echo   Cleanup Complete
echo ==========================================
echo.
echo   All pods, services, volumes, and the namespace have been removed.
echo   To redeploy run:  .\run-local-k8s.bat
echo              or:    .\deploy.bat
echo.

endlocal
pause
