#Stage-A: Continua CI Prerequisites: .NET, IIS and ASP.NET

On Windows 8.1, .NET 4 should be installed by default. On other operating systems.

##Step A00: requirements - .NET 4 OK; IIS not OK
![A00-ContinuaCI-Server-requirements-.NET4-IIS.png](Stage-A-Continua-CI-Prerequisites-.NET-IIS-and-ASP.NET\A00-ContinuaCI-Server-requirements-.NET4-IIS.png)

If the .NET Framework 4 is missing, then install it through `%windir%\System32\OptionalFeatures.exe`, or through [PkgMgr.exe](http://technet.microsoft.com/en-us/library/cc749465) (the Windows Package Manager).

##Step A01: requirements - .NET 4 OK; IIS OK; ASP.NET not OK
![A01-ContinuaCI-Server-requirements-.NET4-IIS-ASP.NET.png](Stage-A-Continua-CI-Prerequisites-.NET-IIS-and-ASP.NET\A01-ContinuaCI-Server-requirements-.NET4-IIS-ASP.NET.png)

If IIS (Internet Information Services) is missing, then install it through `%windir%\System32\OptionalFeatures.exe`, or through [PkgMgr.exe](http://technet.microsoft.com/en-us/library/cc749465) (the Windows Package Manager) as described in [Installing IIS and ASP.NET modules](http://technet.microsoft.com/en-us/library/hh831475.aspx).

##Step A02: Using Windows-Features, add IIS ASP.net binding
![A02-Windows-Features-IIS-ASP.net-binding.png](Stage-A-Continua-CI-Prerequisites-.NET-IIS-and-ASP.NET\A02-Windows-Features-IIS-ASP.net-binding.png)

Even though ASP.NET is indicated as installed, it might not be bound to IIS yet. The following two screenshots show you how to perform that binding.

##Step A03: Using Windows-Features, selected IIS ASP.net binding
![A03-Windows-Features-IIS-ASP.net-binding-installation.png](Stage-A-Continua-CI-Prerequisites-.NET-IIS-and-ASP.NET\A03-Windows-Features-IIS-ASP.net-binding-installation.png)

##Step A04: requirements - .NET 4 OK, IIS OK and IIS-ASP.net binding recognized
![A04-ContinuaCI-Server-requirements-IIS-ASP.net-binding-recognized.png](Stage-A-Continua-CI-Prerequisites-.NET-IIS-and-ASP.NET\A04-ContinuaCI-Server-requirements-IIS-ASP.net-binding-recognized.png)
