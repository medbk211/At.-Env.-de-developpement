$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $PSScriptRoot
$tomcatPath = Join-Path $projectRoot ".dist\apache-tomcat-10.1.52"

if (-not (Test-Path $tomcatPath)) {
    throw "Tomcat not found at $tomcatPath"
}

$javac = (Get-Command javac).Source
$javaHome = Split-Path (Split-Path $javac -Parent) -Parent

$env:JAVA_HOME = $javaHome
$env:CATALINA_HOME = $tomcatPath
$env:CATALINA_BASE = $tomcatPath

& (Join-Path $tomcatPath "bin\shutdown.bat")
