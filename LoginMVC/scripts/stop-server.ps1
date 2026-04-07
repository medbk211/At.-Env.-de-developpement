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
$javac = (Get-Command javac).Source
$javaHome = Split-Path (Split-Path $javac -Parent) -Parent

$env:JAVA_HOME = $javaHome
$env:CATALINA_HOME = $tomcatPath
$env:CATALINA_BASE = $tomcatPath

& (Join-Path $tomcatPath "bin\shutdown.bat")
