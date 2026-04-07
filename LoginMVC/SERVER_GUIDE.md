# LoginMVC Server Guide

This project now follows a professional Maven-style structure:

```text
LoginMVC/
|- src/
|  \- main/
|     |- java/com/example/project/
|     |  |- controller/
|     |  |- service/
|     |  |- dao/
|     |  |- model/
|     |  \- util/
|     |- resources/
|     |  \- application.properties
|     \- webapp/
|        |- views/
|        |- css/
|        |- js/
|        \- WEB-INF/
|- lib/
|- scripts/
|- pom.xml
```

## 1) Requirements

- Windows + PowerShell
- JDK installed (`java` and `javac` available in terminal)
- Tomcat extracted inside `.dist` with a folder name like `apache-tomcat-10.1.x`

Current project path:

`E:\DSI2\s2\At. Env. de developpement\LoginMVC`

## 2) Start The App

From project root:

```bat
run.bat
```

This script now:

- compiles Java sources from `src/main/java`
- copies `src/main/resources` into the compiled classes output
- deploys `src/main/webapp` to Tomcat
- copies project jars from `lib` into `WEB-INF/lib`
- starts Tomcat and prints the application URL

Default URL:

`http://localhost:8090/LoginMVC/`

If your Tomcat connector is not `8090`, use the URL printed by the script.

## 3) Stop The App

From project root:

```bat
stop.bat
```

Or directly:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\stop-server.ps1
```

## 4) Optional Maven Build

The project now includes `pom.xml`.

If Maven is installed on your machine, you can package the app with:

```powershell
mvn clean package
```

Generated artifact:

`target/LoginMVC.war`

## 5) Configuration

Database configuration lives in:

`src/main/resources/application.properties`

Environment variables still override properties when present:

- `DB_HOST`
- `DB_PORT`
- `DB_NAME`
- `DB_USER`
- `DB_PASSWORD`

## 6) Credentials For Test

- username: `admin`
- password: `1234`

## 7) Troubleshooting

- If `8080` or `8090` is busy, change the Tomcat HTTP connector port in `.dist\apache-tomcat-10.1.x\conf\server.xml`
- If the script says Tomcat not found, verify a Tomcat folder exists under `.dist`
- If Java is not found, install a JDK and restart the terminal
- If Maven is not found, keep using `run.bat`; Maven support is optional
