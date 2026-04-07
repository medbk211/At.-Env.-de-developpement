$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$distPath = Join-Path $projectRoot ".dist"
$tomcatDirectory = Get-ChildItem -Path $distPath -Directory -Filter "apache-tomcat-10.1*" |
    Sort-Object Name -Descending |
    Select-Object -First 1

if (-not $tomcatDirectory) {
    throw "Tomcat not found under $distPath"
}

$tomcatPath = $tomcatDirectory.FullName
$javaSourcePath = Join-Path $projectRoot "src\main\java"
$resourcesPath = Join-Path $projectRoot "src\main\resources"
$webappSourcePath = Join-Path $projectRoot "src\main\webapp"
$buildPath = Join-Path $projectRoot ".dist\build\classes"
$appPath = Join-Path $tomcatPath "webapps\LoginMVC"
$projectLibPath = Join-Path $projectRoot "lib"

if (-not (Test-Path $javaSourcePath)) {
    throw "Java source path not found at $javaSourcePath"
}

if (-not (Test-Path $webappSourcePath)) {
    throw "Webapp path not found at $webappSourcePath"
}

$javac = (Get-Command javac).Source
$javaHome = Split-Path (Split-Path $javac -Parent) -Parent

$env:JAVA_HOME = $javaHome
$env:CATALINA_HOME = $tomcatPath
$env:CATALINA_BASE = $tomcatPath

if (Test-Path $buildPath) {
    Get-ChildItem -Path $buildPath -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force
} else {
    New-Item -ItemType Directory -Force -Path $buildPath | Out-Null
}

New-Item -ItemType Directory -Force -Path $buildPath | Out-Null
New-Item -ItemType Directory -Force -Path $projectLibPath | Out-Null

$srcFiles = @(Get-ChildItem -Path $javaSourcePath -Recurse -Filter *.java |
    Select-Object -ExpandProperty FullName)

if ($srcFiles.Count -eq 0) {
    throw "No Java source files found under $javaSourcePath"
}

$compileClasspath = "$tomcatPath\lib\*;$projectLibPath\*"
javac --release 17 -encoding UTF-8 -cp $compileClasspath -d $buildPath $srcFiles

if (Test-Path $resourcesPath) {
    Copy-Item -Path (Join-Path $resourcesPath "*") -Destination $buildPath -Recurse -Force
}

if (Test-Path $appPath) {
    Remove-Item -LiteralPath $appPath -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $appPath | Out-Null
Copy-Item -Path (Join-Path $webappSourcePath "*") -Destination $appPath -Recurse -Force
New-Item -ItemType Directory -Force -Path (Join-Path $appPath "WEB-INF\classes") | Out-Null
Copy-Item -Path (Join-Path $buildPath "*") -Destination (Join-Path $appPath "WEB-INF\classes") -Recurse -Force

$appLibPath = Join-Path $appPath "WEB-INF\lib"
New-Item -ItemType Directory -Force -Path $appLibPath | Out-Null

$dependencyJars = Get-ChildItem -Path $projectLibPath -Filter *.jar -ErrorAction SilentlyContinue
foreach ($jar in $dependencyJars) {
    Copy-Item -Path $jar.FullName -Destination $appLibPath -Force
}

& (Join-Path $tomcatPath "bin\startup.bat")

Write-Host ""
Write-Host "Application URL: http://localhost:8090/LoginMVC/"
