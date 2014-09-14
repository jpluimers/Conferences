# Stage C: Installing the Continua CI Server

## Step C00: Welcome to the Continua CI Server Setup Wizard
![C00-Start-CI-Server-Setup.png](Stage-C-Continua-CI-Installing-Server/C00-Start-CI-Server-Setup.png)

Here you just press the next button

## Step C01: select directory for the Continua CI Server
![C01-directory.png](Stage-C-Continua-CI-Installing-Server/C01-directory.png)

## Step C02: specify the service user under which Continua CI Server runs
![C02-specify-ContinuaCI-Service-Account-00.png](Stage-C-Continua-CI-Installing-Server/C02-specify-ContinuaCI-Service-Account-00.png)

## Step C03: the user requires a domain or computer name
![C03-specify-ContinuaCI-Service-Account-00-requires-domain-name.png](Stage-C-Continua-CI-Installing-Server/C03-specify-ContinuaCI-Service-Account-00-requires-domain-name.png)

## Step C04: use dot as shortcut for `current computer`
![C04-specify-ContinuaCI-Service-Account-01-with-dot-for-current-computer.png](Stage-C-Continua-CI-Installing-Server/C04-specify-ContinuaCI-Service-Account-01-with-dot-for-current-computer.png)

## Step C05: specify the share name and shared directory
![C05-specify-ContinuaCI-Share.png](Stage-C-Continua-CI-Installing-Server/C05-specify-ContinuaCI-Share.png)

A directory starting in the root of a drive is not recommended (though default) as that makes it harder to inherit folder rights.

Share name `ContinuaCIShare` (needed later when installing the Agent)
Share directory `C:\ContinuaCI\Share` (don't make the path too long as the version control system have trouble with long path names: somehow they all suffer from [`MAX_PATH`](http://msdn.microsoft.com/en-us/library/aa365247) issues).

## Step C06: keep the default database architecture PostgreSQL
![C06-specify-database-architecture.png](Stage-C-Continua-CI-Installing-Server/C06-specify-database-architecture.png)

## Step C07: Keep the default values for Site name, Pool name and Port
![C07-specify-IIS-app-pool-and-site-options.png](Stage-C-Continua-CI-Installing-Server/C07-specify-IIS-app-pool-and-site-options.png)

## Step C08: specify IIS authentication
![C08-specify-IIS-authentication--hyperlink-fails.png](Stage-C-Continua-CI-Installing-Server/C08-specify-IIS-authentication--hyperlink-fails.png)

Specify the IIS authentication here. For publicly accessible servers, keep it at `Forms` authentication.

**(Note that clicking on the hyperlink will do nothing: it fails)**

## Step C09-ready-to-install.png
![C09-ready-to-install.png](Stage-C-Continua-CI-Installing-Server/C09-ready-to-install.png)

This is your last chance to verify all the settings you entered are correct.

## Step C10: installing
![C10-installing.png](Stage-C-Continua-CI-Installing-Server/C10-installing.png)

Installation takes a while. On SSD equiped hardware usually less than a minute.

## Step C11: Install Finished
![C11-install-finished.png](Stage-C-Continua-CI-Installing-Server/C11-install-finished.png)

When the Continua CI Server installation is finished, you can (and for the free installation: should) run the embedded Continua CI Agent installer.
