# LoginMVC Server Guide

This file explains exactly how to start and stop the local server for this project.

## 1) Requirements

- Windows + PowerShell
- JDK installed (`java` and `javac` available in terminal)
- Tomcat extracted inside `.dist` with a folder name like `apache-tomcat-10.1.x`

Current project path:

`E:\DSI2\s2\At. Env. de developpement\LoginMVC`

## 2) Easiest Way (One Command)

From project root:

```bat
run.bat
```

You can also double-click `run.bat` from File Explorer.

To stop:

```bat
stop.bat
```

## 3) Quick Start (PowerShell)

From project root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\start-server.ps1
```

This command does all of this automatically:

- compiles Java sources from `src`
- deploys `webapp` + compiled classes to Tomcat `webapps/LoginMVC`
- starts Tomcat
- prints the application URL

Open in browser:

`http://localhost:8090/LoginMVC/login.jsp`

If your Tomcat connector is not `8090`, use the URL printed by the script.

## 4) Stop Server (Graceful)

From project root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\stop-server.ps1
```

## 5) Force Stop (If Still Running)

If graceful stop does not terminate Java/Tomcat:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\stop-server.ps1 -Force
```

## 6) Manual Commands (Without Scripts)

Use these only if you want full manual control.

### 5.1 Compile classes

```powershell
New-Item -ItemType Directory -Force -Path .dist\build\classes | Out-Null
$srcFiles = Get-ChildItem src -Recurse -Filter *.java | ForEach-Object { $_.FullName }
javac -encoding UTF-8 -cp ".dist\apache-tomcat-10.1.52\lib\*" -d ".dist\build\classes" $srcFiles
```

### 5.2 Deploy to Tomcat webapps

```powershell
$appPath = ".dist\apache-tomcat-10.1.52\webapps\LoginMVC"
if (Test-Path $appPath) { Remove-Item -Recurse -Force $appPath }
New-Item -ItemType Directory -Force -Path $appPath | Out-Null
Copy-Item webapp\* $appPath -Recurse -Force
New-Item -ItemType Directory -Force -Path "$appPath\WEB-INF\classes" | Out-Null
Copy-Item .dist\build\classes\* "$appPath\WEB-INF\classes" -Recurse -Force
```

### 5.3 Start Tomcat

```powershell
$tomcat = (Resolve-Path ".dist\apache-tomcat-10.1.52").Path
$javac = (Get-Command javac).Source
$env:JAVA_HOME = Split-Path (Split-Path $javac -Parent) -Parent
$env:CATALINA_HOME = $tomcat
$env:CATALINA_BASE = $tomcat
& "$tomcat\bin\startup.bat"
```

### 5.4 Stop Tomcat

```powershell
$tomcat = (Resolve-Path ".dist\apache-tomcat-10.1.52").Path
$javac = (Get-Command javac).Source
$env:JAVA_HOME = Split-Path (Split-Path $javac -Parent) -Parent
$env:CATALINA_HOME = $tomcat
$env:CATALINA_BASE = $tomcat
& "$tomcat\bin\shutdown.bat"
```

## 7) Credentials for Test

- username: `admin`
- password: `1234`

## 8) Troubleshooting

- If `8080` is busy, change Tomcat HTTP connector port in:
  `.dist\apache-tomcat-10.1.x\conf\server.xml`
- If script says Tomcat not found, verify folder exists under `.dist`
- If Java not found, install JDK and restart terminal
