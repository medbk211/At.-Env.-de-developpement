$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$tomcatPath = Join-Path $projectRoot ".dist\apache-tomcat-10.1.52"
$buildPath = Join-Path $projectRoot ".dist\build\classes"
$appPath = Join-Path $tomcatPath "webapps\LoginMVC"
$projectLibPath = Join-Path $projectRoot "lib"

if (-not (Test-Path $tomcatPath)) {
    throw "Tomcat not found at $tomcatPath"
}

$javac = (Get-Command javac).Source
$javaHome = Split-Path (Split-Path $javac -Parent) -Parent

$env:JAVA_HOME = $javaHome
$env:CATALINA_HOME = $tomcatPath
$env:CATALINA_BASE = $tomcatPath

New-Item -ItemType Directory -Force -Path $buildPath | Out-Null
New-Item -ItemType Directory -Force -Path $projectLibPath | Out-Null

$srcFiles = Get-ChildItem (Join-Path $projectRoot "src") -Recurse -Filter *.java |
    ForEach-Object { $_.FullName }

$compileClasspath = "$tomcatPath\lib\*;$projectLibPath\*"
javac -encoding UTF-8 -cp $compileClasspath -d $buildPath $srcFiles

if (Test-Path $appPath) {
    Remove-Item -Recurse -Force $appPath
}

New-Item -ItemType Directory -Force -Path $appPath | Out-Null
Copy-Item (Join-Path $projectRoot "webapp\*") $appPath -Recurse -Force
New-Item -ItemType Directory -Force -Path (Join-Path $appPath "WEB-INF\classes") | Out-Null
Copy-Item (Join-Path $buildPath "*") (Join-Path $appPath "WEB-INF\classes") -Recurse -Force

$appLibPath = Join-Path $appPath "WEB-INF\lib"
New-Item -ItemType Directory -Force -Path $appLibPath | Out-Null

$dependencyJars = Get-ChildItem $projectLibPath -Filter *.jar -ErrorAction SilentlyContinue
foreach ($jar in $dependencyJars) {
    Copy-Item $jar.FullName $appLibPath -Force
}

& (Join-Path $tomcatPath "bin\startup.bat")

Write-Host ""
Write-Host "Application URL: http://localhost:8090/LoginMVC/login.jsp"
