@echo off 
setlocal EnableDelayedExpansion

rem ==================================================
rem run-local-k8s.bat -- Start Connectra on local Kubernetes
rem ==================================================

set "REPO_ROOT=%~dp0"
set "K8S_DIR=%REPO_ROOT%k8s"

where kubectl >nul 2>&1
if !ERRORLEVEL! NEQ 0 (
    echo [ERROR] kubectl is not installed or not in PATH
    pause
    exit /b 1
)

echo [OK] kubectl found.
echo.

echo [INFO] Image versions from k8s manifests:
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Select-String -Path '%K8S_DIR%\backend\deployment.yaml' -Pattern 'image:' | ForEach-Object { $_.Line.Trim() }"') do echo %%i
for /f "tokens=*" %%i in ('powershell -NoProfile -Command "Select-String -Path '%K8S_DIR%\frontend\deployment.yaml' -Pattern 'image:' | ForEach-Object { $_.Line.Trim() }"') do echo %%i

echo ============================================
echo Applying Kubernetes manifests
echo ============================================

echo [INFO] Applying namespace..
kubectl apply -f "%K8S_DIR%\namespace.yaml"

echo [INFO] Applying MongoDB..
kubectl apply -f "%K8S_DIR%\mongodb"

echo [INFO] Applying Redis..
kubectl apply -f "%K8S_DIR%\redis"

echo [INFO] Applying Backend..
kubectl apply -f "%K8S_DIR%\backend"

echo [INFO] Applying Frontend..
kubectl apply -f "%K8S_DIR%\frontend"

echo.
echo [OK] All manifests applied.

echo ============================================
echo Watching rollout progress
echo ============================================
echo.

echo Backend rollout:
kubectl rollout status deployment/backend -n connectra --timeout=3m
if !ERRORLEVEL! NEQ 0 (
    echo [WARN] Backend rollout timeout
    echo        Check: kubectl get pods -n connectra
)

echo Frontend rollout:
kubectl rollout status deployment/frontend -n connectra --timeout=3m
if !ERRORLEVEL! NEQ 0 (
    echo [WARN] Frontend rollout timeout
    echo        Check: kubectl get pods -n connectra
)

echo.
echo ==========================================
echo   Connectra is Running!
echo ==========================================
echo.
echo   Access Connectra:
echo     Frontend  --  http://localhost
echo     Backend   --  http://localhost:5000/docs
echo.
echo   Useful diagnostic commands:
echo     kubectl get pods -n connectra
echo     kubectl get svc  -n connectra
echo     kubectl logs -f deployment/backend  -n connectra
echo     kubectl logs -f deployment/frontend -n connectra
echo.
echo   To stop everything run:  .\stop-k8s.bat
echo.

endlocal
pause