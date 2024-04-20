@echo off

REM 当脚本退出时删除编译的服务器程序并杀死所有子进程
setlocal
set "SERVER_EXE=server.exe"
set "PORTS=8001 8002 8003"
set "API_FLAG=-api=1"

REM 编译Go程序
go build -o %SERVER_EXE%

REM 启动三个服务器实例
for %%P in (%PORTS%) do start /b %SERVER_EXE% -port=%%P %API_FLAG%

REM 等待2秒
timeout /t 2 /nobreak > nul

echo ">>> start test"
REM 发送测试请求
curl "http://localhost:9999/api?key=Tom"
curl "http://localhost:9999/api?key=Tom"
curl "http://localhost:9999/api?key=Tom"

REM 等待所有子进程结束
wait
endlocal