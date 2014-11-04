# [Build Automation for Delphi Projects](https://github.com/jpluimers/Conferences/blob/master/2014/20141104-EKON-German-Koln-Build-Automation-and-Continuous-Integration/Build-Automation.md)

[Köln, Deutschland, 20141104: EKON 2014](http://entwickler-konferenz.de/2014/sessions)

- Examples: <https://bitbucket.org/jeroenp/besharp.net>
- Slides: <http://github.com/jpluimers/Conferences>
- Blog: <http://wiert.me>

## Introduction

### Shameless plug

<http://www.amazon.com/Delphi-Cookbook-Daniele-Teti/dp/1783559586>

Cheap. 50 examples of newer Delphi stuff. Accurate. 
Buy it at 
- [Packt](https://www.packtpub.com/application-development/delphi-cookbook): EUR 21 (eBook PDF/mobi/epub); EUR 34 (ebook + hardcopy). 
- [Amazon](http://www.amazon.com/Delphi-Cookbook-Daniele-Teti/dp/1783559586): USD 18 (Kindle); USD 40 (hardcopy).

VAT trick at Packt for electronic delivery: ensure your address in the USA. Then buy it. 

![](http://ecx.images-amazon.com/images/I/51GzcWKTbzL.jpg)

### Abstract

So you are developing an application and copy the EXE from your development to your users. 

Now while developing a new feature, a customer reports a bug and you want to fix it. 

> How do you deliver the new build to him? 

A seemingly simple question, with many complex answers. 

- A big help here is being able to build 
your application in an automated way separate from your regular development.
- From a small build batch file to a fully automated build system: this session shows you the range of possibilities, and guidance where to use which.
- You will learn how some initial effort can lead to effortless builds, and through continuous integration even extend them to continuous delivery.

Difficulty level: 2 - intermediate.

### Getting the right sources

Easiest is to have a good version control system, preferably a Distributed Version Control system. [I've talked about that last year](http://wiert.me/2013/08/27/dutch-stop-of-the-rad-studio-in-action-live-event-september-7th-leiden-close-to-amsterdam/), so I won't go into details.

Any version control is better than no version control a all. Even if you work alone.

### Building from the sources

You want to build as reliably as possible: well defined environment with clear steps that can be automated.

Automation means scripting in one way or the other, so most of the session is about that.

### Introductory session

This is introductory: see a lot, ask a lot of questions. 
Many examples. References mostly on-line at these locations:

- <https://bitbucket.org/jeroenp/conferences>
- <https://bitbucket.org/jeroenp/besharp.net>
- <http://wiert.me>

## Scripting

All forms of builds are a sequence of steps that you want to automate, so one way or the other you end up with a kind of (maybe visual) scripting like [this example](http://www.hanselman.com/blog/NuGetForTheEnterpriseNuGetInAContinuousIntegrationAutomatedBuildSystem.aspx) from [Scott Hanselman](http://hanselminutes.com/):

![](http://www.hanselman.com/blog/content/binary/Windows-Live-Writer/NuGet-for-the-Enterprise-NuGet-in-a-Cont_DED9/image_thumb_1.png)

### Building Delphi projects

As of Delphi 2007 everything (including the IDE) is being built using MSBuild. So you never run the command-line compilers yourself, basically because the options have become too complex for most projects.

In Delphi, these files are MSBuild projects:

- `.dproj` Delphi Projects
- `.grouproj` Project Groups

> Generate `.groupproj` from a list of `.dproj` files
> - <https://bitbucket.org/jeroenp/besharp.net/src/tip/Native/Delphi/Apps/Console/GenerateGroupProjConsoleProject>
> - <https://bitbucket.org/jeroenp/besharp.net/src/tip/Native/Delphi/Scripts/GroupProj.xsd>

MSBuild configuration from both the IDE and command-line is done through `$(parameters)` which can be environment variables. Hence you see `$(BDS)` a lot.

### MSBuild

You do need knowledge about [MSBuild](https://en.wikipedia.org/wiki/MSBuild) especially when things fail.

#### MSBuild summary

Basically, MSBuild builds Targets from MSBuild project files. There are a few basic targets included (like C# and Visual Basic) which (like any extra targets) are defined in [MSBuild `*.Targets` files](http://msdn.microsoft.com/en-us/library/ms164312.aspx).

[MSBuild Project files](http://msdn.microsoft.com/en-us/library/5dy88c2e.aspx) use an [XML](https://en.wikipedia.org/wiki/XML) based [Domain Specific Language](http://en.wikipedia.org/wiki/Domain-specific_language).

#### MSBuild references

- [msbuild tag](http://stackoverflow.com/questions/tagged/msbuild) with 6500+ questions on StackOverflow (in fact there are many more [StackOverflow tags](http://stackoverflow.com/tags) for `MSBuild`, like [msbuild-propertygroup](http://stackoverflow.com/questions/tagged/msbuild-propertygroup))
- [EKON 16 MSBuild presentation](https://speakerdeck.com/phoenixhawk/ekon-16-msbuild) by [Sebastian Gingter](http://stackoverflow.com/users/199861/sebastian-p-r-gingter) (German, but you guys can all read that)
- 2009: [Inside the Microsoft® Build Engine: Using MSBuild and Team Foundation Build (Pro-Developer)](http://www.amazon.com/Inside-Microsoft%C2%AE-Build-Engine-Pro-Developer/dp/B0085S10L2)
- 2011: [Inside the Microsoft Build Engine: Using MSBuild and Team Foundation Build (2nd Edition) (Developer Reference)](http://www.amazon.com/Inside-Microsoft-Build-Engine-Foundation/dp/0735645248)
- [MSDN Reference](http://msdn.microsoft.com/en-us/library/0k6kkbsd.aspx) on MSDN
- [Practical .NET2 and C#2: An introduction to MSBuild](http://www.codeproject.com/Articles/12985/Practical-NET-and-C-An-introduction-to-MSBuild) CodeProject

### Batch files

Good old friends, but really hard to maintain as the examples will show. Easy to run as they work everywhere.

### PowerShell

PowerShell is like cmd.exe on steroids: powerful, but you can get sucked into it like crazy.

It is the future of Windows scripts, so better learn it soon. 

## Dependencies

All below dependencies will (often slightly) differ from Delphi version to Delphi version. That's what makes builds hard.
 
### Delphi dependencies

#### `*.Targets`

Both the location and names of the `*.Targets files differ`.

First the location:

- Delphi 2007: In the .NET Framework or Framework64 directory (the installer forgets the latter).
- Delphi 2009+: In the $(BDS)\bin directory

Then the name:

- Delphi 2007: `Borland.*.Targets`
    - `Borland.Common.Targets` 
    - `Borland.Cpp.Targets` 
    - `Borland.Delphi.Targets` 
    - `Borland.Group.Targets`  
- Delphi 2009+: `Codegear.*.Targets`
    - Delphi XE-: 
        - `CodeGear.Common.Targets` 
        - `CodeGear.Cpp.Targets`
        - `CodeGear.Delphi.Targets`
        - `CodeGear.Group.Targets` 
        - `CodeGear.Idl.Targets` <<---- new
    - Delphi XE2+:
        - `CodeGear.Common.Targets` 
        - `CodeGear.Cpp.Targets` 
        - `CodeGear.Delphi.Targets` 
        - `CodeGear.Deployment.Targets` <<---- new 
        - `CodeGear.Group.Targets` 
        - `CodeGear.Idl.Targets` <<---- not in Appmethod
        - `CodeGear.Profiles.Targets` <<---- new
    - Appmethod 1:
        - `CodeGear.Common.Targets` 
        - `CodeGear.Cpp.Targets` 
        - `CodeGear.Delphi.Targets` 
        - `CodeGear.Deployment.Targets`
        - `CodeGear.Group.Targets` 
        - `CodeGear.Profiles.Targets`

#### Delphi specific MSBuild peculiarities

Documentation on Delphi specific MSBuild properties is non-existent (surprise!).

The answer to [What are the MSBuild project level properties for Delphi?](http://stackoverflow.com/questions/2373991/what-are-the-msbuild-project-level-properties-for-delphi) indicates to look in the `*.Delhpi.Targets` files at the `CoreCompile` target.

One specific property is [DCC_BuildAllUnits](https://www.google.com/search?q=DCC_BuildAllUnits) which forces all units to be rebuild (juist like in the IDE you'd use menu option `Project` -> `Build all`).

Where MSBuild uses `$(Configuration)`, Delphi also uses `$(Config)` and does not always sync the two correctly. Go figure (:

#### Binaries, Libraries, Sources

These are all relative the `$(BDS)` path of the targeted Delphi version:

- $(BDS)\lib\... - often $(BDSLIB)\$(PLATFORM)\$(CONFIG)
- $(BDSINCLUDE) - $(BDS)\include
- $(BDSCOMMONDIR) - relative to $(PUBLIC) with product specific suffix

These will get you

- .dcu, .dfm and .pas files
- .inc files
- .dcp and/or .bpl files

The `$(BDSCOMMONDIR)` is a global reference, so you need to be careful with it. 

### `rsvars.bat`

Running the [rsvars.bat](https://www.google.com/search?q=rsvars.bat) for a specific Delphi version sets the environment in the current command-prompt to that Delphi version:

- it sets environment variables like $(BDS)
- it sets the PATH so $(BDS)\bin and the directory for MSBuild are on the path

Any MSBuild version defined in `rsvars.bat` is a minimum version. In fact more recent versions of MSBuild give better feedback on failures, so when resolving failures: use an MSBuild version that is as recent as possible.

A diff of before/after `rsvars.bat` for Delphi XE is like this:

    BDS=C:\Program Files (x86)\Embarcadero\Studio\14.0
    BDSINCLUDE=C:\Program Files (x86)\Embarcadero\Studio\14.0\include
    CG_64_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\Studio\14.0\include\boost_1_50
    CG_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\Studio\14.0\include\boost_1_39
    FrameworkDir=C:\Windows\Microsoft.NET\Framework\v3.5
    FrameworkVersion=v3.5
    LANGDIR=EN
    Path=C:\Windows\Microsoft.NET\Framework\v3.5;;C:\Program Files (x86)\Embarcadero\Studio\14.0\bin;C:\Program Files (x86)\Embarcadero\Studio\14.0\bin64;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE3\win32_togo;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE3\win64_togo;%PATH%

#### Three basic scripts:

- [Dependencies.bat](https://bitbucket.org/jeroenp/besharp.net/src/tip/Dependencies.bat)
- [Run-Dependend-rsvars-From-Path.bat](https://bitbucket.org/jeroenp/besharp.net/src/tip/Run-Dependend-rsvars-From-Path.bat)
- `List-Delphi-Installed-Packages.ps1` in <https://bitbucket.org/jeroenp/besharp.net/src/tip/Native/Delphi/Scripts>

##### `Dependencies.bat`

Is documented in [Dependencies.txt](https://bitbucket.org/jeroenp/besharp.net/src/tip/Dependencies.md).

Summary: 

> loads dependencies from [Dependencies.txt](https://bitbucket.org/jeroenp/besharp.net/src/tip/Dependencies.txt) into environment variable, and knows how to load/update the repositories using the Version Control command-line tools for Git, Mercurial/Hg, SVN and plain directories.

##### `Run-Dependend-rsvars-From-Path.bat`

For a specific BDS version

1. obtains the paths to various things (see Delphi 2007 output) and lists them
2. executes the found `rsvars.bat`
3. runs `Dependencies.bat Set`
4. executes a target

Can execute certain targets:

    D          - Delphi
    C          - C++ Builder
    S          - RAD Studio/Appmethod
    RS         - RAD Studio/Appmethod
    Delphi     - Delphi
    CBuilder   - C++ Builder
    RadStudio  - RAD Studio/Appmethod
    B          - msbuild build project in Debug mode
    msbuild    - msbuild build project in Debug mode
    F          - fix missing *.Targets files (requires UAC Administrator token)
    fixTargets - fix missing *.Targets files (requires UAC Administrator token)

The last target is for [x64 systems running Delphi 2007](http://blog.dummzeuch.de/2013/11/10/delphi-2007-on-windows-8-1/) ensuring the *.Targets files are in the right location.

For most BDS versions:

     5 - Delphi 2007
     6 - Delphi 2009
     7 - Delphi 2010
     8 - Delphi XE
     9 - Delphi XE2
    10 - Delphi XE3
    11 - Delphi XE4
    12 - Delphi XE5
    13 - Appmethod 1
    14 - Delphi XE6/Appnethod 2
    15 - Delphi XE7/Appnethod 3?
     L - Latest/Youngest installed version of the above.

Sample Delphi 2007 output:

    BDS EXE: "C:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin\bds.exe"
    rsvars: "C:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin\rsvars.bat"
    binDir: "C:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin\"
    Setting environment for using CodeGear RAD Studio tools
    targetDirectory: C:\Windows\Microsoft.NET\Framework64\v2.0.50727
    sourceDirectory: C:\Windows\Microsoft.NET\Framework\v2.0.50727\
    msbuild.exe: C:\Windows\Microsoft.NET\Framework64\v2.0.50727\msbuild.exe
    ...
    C:\Windows\Microsoft.NET\Framework64\v2.0.50727\msbuild.exe /target:build /p:DCC_BuildAllUnits=true /p:config=Debug version1\projects\TotalApp\EyePoint.dproj

##### `List-Delphi-Installed-Packages.ps1`

Execute using `PowerShell -File List-Delphi-Installed-Packages.ps1 [Command]` where Command is any of these:

    Versions
    ProductNames
    CompanyNames
    HKCU-BaseKeyPaths
    HKLM-BaseKeyPaths
    ProductVersions
    ProductFullNames
    ProductSummaries
    InstalledProductFullNames
    InstalledProductSummaries
    InstalledPackages

For instance `PowerShell -File List-Delphi-Installed-Packages.ps1 ProductSummaries` gives a table like this:

    Product Summaries:
    
    BDS # HKCU/HKLM registry path        Name                    CompilerVersion RTLVersion Define               Characterset Architectures                         Frameworks DllSuffix
    ----- -----------------------        ----                    --------------- ---------- ------               ------------ -------------                         ---------- ---------
        1 \Software\Borland\BDS\1.0      Borland C# Builder 1    C#              C#         C#                   Unicode      C# .NET 1                             .NET       ????
        2 \Software\Borland\BDS\2.0      Borland Delphi 8        none/16.0       none/16.0  VER160/VER160        Ansi/Unicode Win32;.NET 1                          VCL/.NET   80
        3 \Software\Borland\BDS\3.0      Borland Delphi 2005     17.0/17.0       17.0/17.0  VER170/VER170        Ansi/Unicode Win32;.NET 1                          VCL/.NET   90
        4 \Software\Borland\BDS\4.0      Borland Delphi 2006     18.0/18.0       18.0/18.0  VER180/VER180        Ansi/Unicode Win32;.NET 2                          VCL/.NET   100
        5 \Software\Borland\BDS\5.0      Borland Delphi 2007     18.5/19.0       18.0/19.0  VER180&VER185/VER190 Ansi/Unicode Win32;.NET 2                          VCL/.NET   100
        6 \Software\CodeGear\BDS\6.0     CodeGear Delphi 2009    20.0            20.0       VER200               Unicode      Win32                                 VCL        120
        7 \Software\CodeGear\BDS\7.0     CodeGear Delphi 2010    21.0            21.0       VER210               Unicode      Win32                                 VCL        140
        8 \Software\Embarcadero\BDS\8.0  Embarcadero Delphi XE   22.0            22.0       VER220               Unicode      Win32                                 VCL        150
        9 \Software\Embarcadero\BDS\9.0  Embarcadero Delphi XE2  23.0            23.0       VER230               Unicode      Win32;Win64                           VCL        160
       10 \Software\Embarcadero\BDS\10.0 Embarcadero Delphi XE3  24.0            24.0       VER240               Unicode      Win32;Win64;OSX32                     VCL;FMX1   170
       11 \Software\Embarcadero\BDS\11.0 Embarcadero Delphi XE4  25.0            25.0       VER250               Unicode      Win32;Win64;OSX32;iOS-Arm             VCL;FMX2   180
       12 \Software\Embarcadero\BDS\12.0 Embarcadero Delphi XE5  26.0            26.0       VER260               Unicode      Win32;Win64;OSX32;iOS-Arm;Android-Arm VCL;FMX2   190
       13 \Software\Embarcadero\BDS\13.0 Embarcadero Appmethod 1 26.5            26.5       VER265               Unicode      Win32;Win64;OSX32;iOS-Arm;Android-Arm FMX2       195
       14 \Software\Embarcadero\BDS\14.0 Embarcadero Delphi XE6  27.0            27.0       VER270               Unicode      Win32;Win64;OSX32;iOS-Arm;Android-Arm VCL;FMX2   200
       15 \Software\Embarcadero\BDS\15.0 Embarcadero Delphi XE7  28.0            28.0       VER280               Unicode      Win32;Win64;OSX32;iOS-Arm;Android-Arm VCL;FMX2   210

### User profile dependencies

Registry settings like the `Library Search Path` are saved by the IDE in `EnvOptions.proj`.

If your build user never runs the IDE, `EnvOptions.proj` does not exist, but the Delphi XE- build process depends on it. This can be worked around (see Continua CI portion).

Few people know about the inner details of [EnvOptions.dproj](https://www.google.com/search?q=EnvOptions.proj).

A similar thing holds for the Mobile platform dependencies. This affects any Delphi version and is on my research list (when time permits: Spring4D Continua CI demo will show it.. 

### Project dependencies

Build should run as isolated as possible, so during compilation you will only know:

- relative paths
- parameterized paths

Parameterized like depending on $(BDS) or $(Spring4D) is the easiest.

## Building using batch files and MSBuild

Example for a real life project:

    "C:\Program Files (x86)\CodeGear\RAD Studio\5.0\bin\rsvars.bat"
    C:\Windows\Microsoft.NET\Framework64\v2.0.50727\msbuild.exe /target:build /p:DCC_BuildAllUnits=true /p:config=Debug version1\projects\TotalApp\EyePoint.dproj

Easy to do, but depends on your actual work machine. Which often is full of `convenient` stuff that is not meant for a clean well defined build.

Oh: MSBuild uses awful colours!

## `Spring4D`: Building using a custom-front-end

[Spring4D](http://spring4d.org/) has a Build.exe which executes a set of batch files in the background to facilitate the build process.

> #### Spring4D
> Spring4D is an open-source code library for Embarcadero Delphi 2010 and higher. It consists of a number of different modules that contain a base class library (common types, interface based collection types, reflection extensions) and a dependency injection framework. It uses the Apache License 2.0.
> Join us on the Spring4D Google Group.
> #### Installation
> Just run the `Build.exe` and select the Delphi versions you want to install Spring4D for.

There are two settings files:

- `Build.Settings.Compilers.ini`: from VCS; contains the compiler dependency definitons
- `Build.Settings.ini`: from the UI; contains the selected Delphi versions and build/test/install options

### Example scripts for Build and Tests

For each selected Delphi version, Build.exe runs these scripts:

Build [Spring4D-DelphiXE-Release.bat](https://gist.github.com/jpluimers/a77504792d02e48d76a6)

    "C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\bin\rsvars.bat" 
    C:\Windows\Microsoft.NET\Framework\v2.0.50727\msbuild.exe /nologo 
        "Packages\DelphiXE\Spring4D.groupproj"  
        /target:build  
        /p:DCC_BuildAllUnits=true  
        /p:"Config=Release"  
        /p:"Platform=Win32"  
        /p:"DCC_DcuOutput=Library\DelphiXE\Release"  
        /p:"DCC_Define=CONSOLE_TESTRUNNER"  
        /l:FileLogger,Microsoft.Build.Engine;logfile="Logs\DelphiXE.Win32.Release.MSBuildLog.txt" 

Followed by running the unit tests:

    @echo off
      for /f %%s in ('dir /s /b Spring.Tests.exe') do if exist %%s call :run %%s
      grep -wd error *MSBuildLog.txt
      grep -wd failures *Spring.Tests.Reports.xml
      goto :eof
    :run
      echo %1
      pushd %~dp1
      %1
      popd
      goto :eof

### Advantage

- Easy to run for a one-time install.

### Drawbacks 

- mobile builds can take 15 minutes to run per Delphi version.
- scanning on unit test errors is hard
- too many manual steps and checks: error prone

## Continuous Integration

Allow you to build based on events and schedules.

### Continuous Integration System architecure

[Geert van Horrik](http://stackoverflow.com/users/561411/geert-van-horrik) wrote a nice post [Automatic builds via FinalBuilder and Continua CI](http://geertvanhorrik.com/2013/09/01/automatic-builds-via-finalbuilder-and-continua-ci/) that as a great image explaining the basic architecture of Continuous Integration system:

![](http://geertvanhorrik.com/wp-content/uploads/2013/09/image4_thumb.png)

and some basic stages such a system could execute for a certain project:

1. Build => only builds the code
2. Test => only runs mstest on the test assemblies
3. Package => creates the installation package and nuget packages
4. Deploy => deploys the nuget packages to nuget.org

### Orchestration Server

This knows about the work to be run, events to watch, version control systems to connect to and the available agents.

Work is distributed over the available and matching build agents.

### Agents

Agents connect to the orchestration server providing their capabilities and availability to it. Each Agent gets pieces of work when it is available.

The free license of Continua CI only works when the Agent runs on the same machine as the Orchestration Server.

#### Build Agents

These need to be extremely stable and clean. So not a machine regularly used for development, and maybe even a machine per target version of the tool chain.

#### Testing Agents

Often you want to test on a system that is different from a build server to lessen dependencies. So then you want a different Agent for testing

## `Spring4D`: Building using Continua CI

Continua CI 1.5 got [released in September 2014](http://wiert.me/2014/09/10/continua-ci-version-1-5-has-been-released-build-1-5-0-268-smaller-faster-loads-of-new-features-spring4d-xe7-builds-automated/) Delphi XE7 support.

### Installation

Dead easy. See screen shots.

### Installation of Delphi

In theory you would only [need the command-line compilers, libraries and such](http://delphi.wikia.com/wiki/Setting_up_a_Delphi_Build_Machine) and set a few environment variables, but in practice it is better to install the full product (but not as the Agent user: this ensures you do not pollute that user with too much settings).

### Configuration

A lot harder. See Blog post and [Continua CI markdown](Continua-CI.md).

### Demo.
