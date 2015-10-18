# [Continua CI: continuous integration of your builds, packaging, testing and deployment](https://github.com/jpluimers/Conferences/blob/master/2014/20141104-EKON-German-Koln-Build-Automation-and-Continuous-Integration/Continua-CI.md)

## Introduction

I like [Continua CI](https://www.finalbuilder.com/continua-ci), especially because of how [feature rich it is](https://www.finalbuilder.com/continua-ci/feature-tour), the [FinalBuilder](https://www.finalbuilder.com/downloads/finalbuilder/finalbuilder-7-version-history) heritage, and  that the [pricing](https://www.finalbuilder.com/continua-ci/pricing) starts with free (as in [gratis](https://en.wikipedia.org/wiki/Gratis)) when you run a `1 server + 1 concurrent build on a local agent` setup.

Oh and their customer service is awesome: you find a reproducible bug and [often they fix it within hours](https://plus.google.com/+JeroenPluimers/posts/1tyJsQjYhNY).

Like with any [continuous integration system](https://en.wikipedia.org/wiki/Continuous_integration), it has a learning curve and gotchas. That's OK, as it will save you a lot of time.

So here are some links and notes and links:

*   [Continua CI in 3 minutes. - YouTube](https://www.youtube.com/embed/pE0v_O7LsmA?__vid=826d3ae09cc70131903422000ab2058a).
*   [VSoft Technologies - YouTube](https://www.youtube.com/user/vincentparrett/videos).
*   [Tutorials - Continua CI - VSoft Technologies Documentation Wiki](http://wiki.finalbuilder.com/display/continua/Tutorials) consisting of these steps:
    *   [Part 1: Create your First Project](http://wiki.finalbuilder.com/display/continua/Part+1%3A+Create+your+First+Project).
    *   [Part 2: Create your First Configuration](http://wiki.finalbuilder.com/display/continua/Part+2%3A+Create+your+First+Configuration).
    *   [Part 3: Create your First Repository](http://wiki.finalbuilder.com/display/continua/Part+3%3A+Create+your+First+Repository).
    *   [Part 4: Create your First Action](http://wiki.finalbuilder.com/display/continua/Part+4%3A+Create+your+First+Action).
    *   [Part 5: Using Builds](http://wiki.finalbuilder.com/display/continua/Part+5%3A+Using+Builds).
    *   [Part 6: Automate your Builds](http://wiki.finalbuilder.com/display/continua/Part+6%3A+Automate+your+Builds).

I've based a lot of this on the work I did for the [Spring4D](https://plus.google.com/111642256327642864138/about) framework.

> Note: it is hard to keep screenshots up to date, so neither [my articles with screenshots](https://github.com/jpluimers/Conferences/blob/master/2014/2014-Continua-CI-installation/2014-Continua-CI-installation.md), nor the [Continua CI - VSoft Technologies Documentation Wiki](http://wiki.finalbuilder.com/display/continua) will have completely accurate screenshots.

## Installation

### Download and install

[Downloading](https://www.finalbuilder.com/downloads/continuaci) is dead simple. I used the `x64` builds of the installer.

> My systems are all [x64](http://en.wikipedia.org/wiki/X86-64) systems: I've left the x86 era for hosts behind me quite a while ago as x86 software just as good on it (the exception is 16-bit DOS, but I haven't used that in ages).

Just run the installer and complete the steps. The [installation screenshots are in a separate article](https://github.com/jpluimers/Conferences/blob/master/2014/2014-Continua-CI-installation/2014-Continua-CI-installation.md) as they are a bit dull.

### Security of shares

During the installation, a share is created with read-write access for the group Everyone. You probably want to confine this a bit further.

### Inspect the installation

After installing, [if the database cannot be connected to](https://www.finalbuilder.com/support/forums/aft/11575), you will see something similar to this at <http://localhost:8080/install/serviceunavailable>:

> 23:00 : Starting
> 23:01 : Creating Application Setup.
> 23:01 : Creating Application instance.
> 23:01 : Starting
> 23:01 : Setting up Loggers
> 23:01 : Migrating Database
> 23:01 : Could not initialise database: Failed to establish a connection to '127.0.0.1'. Check the eventlog for more info.
> 23:01 : Starting Application instance.

The [eventlog](https://en.wikipedia.org/wiki/Event_Viewer) will not contain clues, so check these keys in the registry:

*   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ContinuaCIPostgreSQL`
*   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ContinuaCIAgent`
*   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ContinuaCI`

### First time configuration

When the installation does come up, you end up at the Welcome page: <http://localhost:8080/install> where you have to configure an [Continua Administrator](https://www.google.com/search?q=&quot;Continua+Administrator&quot;+site%3Afinalbuilder.com) user. This is not explained well in the Continua CI documentation, so I just regard this as the [root user](https://en.wikipedia.org/wiki/Superuser) for Continua CI.

After that, you are prompted to create your first project: <http://localhost:8080/ci/projectwizard/start>

And you can optionally fine tune security by defining `users`, `groups` and ` roles`, then grant roles to users/groups in `access control`:

| Security       | URL                                                                                                                                                                                            |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Users          | <http://localhost:8080/administration/users>                                        |
| Groups         | <http://localhost:8080/administration/groups>                                     |
| Roles          | <http://localhost:8080/administration/roles>                                        |
| Access Control | <http://localhost:8080/administration/accesscontrollists> |

### Upgrading can be done in-place

The [Continua CI installers are smart enough to upgrade in-place](http://wiki.finalbuilder.com/display/continua/Upgrading) while keeping the configuration. But note they cannot do in-place downgrade.

This is where you can find the installed versions from the web-interface:

*   Agents: <http://localhost:8080/administration/ci/agents/viewall>
*   Server: <http://localhost:8080/administration/ci/collectors/properties>

## Structure

The organisational architecture of Continua CI is from `Global` through `Project` to `Config`.

Depending on the kind of project (business project, open source project supporting many product versions and targets) you need to carefully think what to define at each level.

*   Global at the server level
*   Project at the intermediate level
*   Configuration at the leaf level

Each level inherits from the parent level.

![Hierarchy: Global, Project, Config](https://www.finalbuilder.com/images/continua-ci/continua-architecture.png)

### Per level

Below are the main things you edit at each level:

*   Global
    *   Application Variables (the Environment variables are inherited from the server)
    *   Global level repositories
    *   Server security (Users, Groups, Roles, Access Control)
    *   Server properties
    *   Property collectors (readonly)
*   Project
    *   Project Variables
    *   Project level Repositories
*   Configuration
    *   Configuration Variables
    *   Configuration level Repositories
    *   [Stages](http://wiki.finalbuilder.com/display/continua/Stages) (tasks you can execute varying from builds, to scripts, to flow control with all kinds of checks and decisions) and [gates](http://wiki.finalbuilder.com/display/continua/Stages) (that allow/block you to get to the next stage).

Note:

> Variable values can be obtained by percentage signs (%). Object and property values can be obtained by dollar signs ($). Both are hierarchical (so there is %Global.*%, %Configuration.*%, $Agent.*$, $Build.*$, etc) and there is a scope (from close to wide: Build, Configuration, Project, Application, Environment). When you need a percent  or dollar character then you need to [escape them by doubling](http://wiki.finalbuilder.com/display/continua/Part+5:+Using+Builds#Part5:UsingBuilds-CreateDirectoryAction): %% and $$.
>
> Read these two links for more information: [Variables](http://wiki.finalbuilder.com/display/continua/Variables) and [Variables, Objects &amp; Expressions](http://wiki.finalbuilder.com/pages/viewpage.action?pageId=655772).

### Spring4D hierarchy

For Spring4D, we've chosen this global/project/configuration hierarchy:

*   Global level:
    *   Server
*   Project level:
    *   Spring4D
*   Configurations:

| Config \ Delphi version | XE                       | XE2                       | XE3                       | XE4                               | XE5                               | XE6                               | XE7                               |
|-------------------------|--------------------------|---------------------------|---------------------------|-----------------------------------|-----------------------------------|-----------------------------------|-----------------------------------|
| `Win32.Debug`           | `DelphiXE.Win32.Debug`   | `DelphiXE2.Win32.Debug`   | `DelphiXE3.Win32.Debug`   | `DelphiXE4.Win32.Debug`           | `DelphiXE5.Win32.Debug`           | `DelphiXE6.Win32.Debug`           | `DelphiXE7.Win32.Debug`           |
| `Win32.Release`         | `DelphiXE.Win32.Release` | `DelphiXE2.Win32.Release` | `DelphiXE3.Win32.Release` | `DelphiXE4.Win32.Release`         | `DelphiXE5.Win32.Release`         | `DelphiXE6.Win32.Release`         | `DelphiXE7.Win32.Release`         |
| `Win64.Debug`           | -                        | `DelphiXE2.Win64.Debug`   | `DelphiXE3.Win64.Debug`   | `DelphiXE4.Win64.Debug`           | `DelphiXE5.Win64.Debug`           | `DelphiXE6.Win64.Debug`           | `DelphiXE7.Win64.Debug`           |
| `Win64.Release`         | -                        | `DelphiXE2.Win64.Release` | `DelphiXE3.Win64.Release` | `DelphiXE4.Win64.Release`         | `DelphiXE5.Win64.Release`         | `DelphiXE6.Win64.Release`         | `DelphiXE7.Win64.Release`         |
| `OSX32.Debug`           | -                        | `DelphiXE2.OSX32.Debug`   | `DelphiXE3.OSX32.Debug`   | `DelphiXE4.OSX32.Debug`           | `DelphiXE5.OSX32.Debug`           | `DelphiXE6.OSX32.Debug`           | `DelphiXE7.OSX32.Debug`           |
| `OSX32.Release`         | -                        | `DelphiXE2.OSX32.Release` | `DelphiXE3.OSX32.Release` | `DelphiXE4.OSX32.Release`         | `DelphiXE5.OSX32.Release`         | `DelphiXE6.OSX32.Release`         | `DelphiXE7.OSX32.Release`         |
| `iOSSimulator.Debug`    | -                        | -                         | -                         | -`DelphiXE4.iOSSimulator.Debug`   | -`DelphiXE5.iOSSimulator.Debug`   | `DelphiXE6.iOSSimulator.Debug`    | -`DelphiXE7.iOSSimulator.Debug`   |
| `iOSSimulator.Release`  | -                        | -                         | -                         | -`DelphiXE4.iOSSimulator.Release` | -`DelphiXE5.iOSSimulator.Release` | -`DelphiXE6.iOSSimulator.Release` | -`DelphiXE7.iOSSimulator.Release` |
| `iOSDevice.Debug`       | -                        | -                         | -                         | -`DelphiXE4.iOSDevice.Debug`      | -`DelphiXE5.iOSDevice.Debug`      | -`DelphiXE6.iOSDevice.Debug`      | -`DelphiXE7.iOSDevice.Debug`      |
| `iOSDevice.Debug`       | -                        | -                         | -                         | -`DelphiXE4.iOSDevice.Release`    | -`DelphiXE5.iOSDevice.Release`    | -`DelphiXE6.iOSDevice.Release`    | -`DelphiXE7.iOSDevice.Release`    |
| `AndroidARM.Debug`      | -                        | -                         | -                         | -                                 | `DelphiXE5.AndroidARM.Debug`      | `DelphiXE6.AndroidARM.Debug`      | -`DelphiXE7.AndroidARM.Debug`     |
| `AndroidARM.Release`    | -                        | -                         | -                         | -                                 | -`DelphiXE5.AndroidARM.Release`   | -`DelphiXE6.AndroidARM.Release`   | -`DelphiXE7.AndroidARM.Release`   |


> Note:
> - The ones with a minus in front are not yet done.
> - The ones with just a minus are not supported by Delphi.

This is what we defined at each level:

*   Global: nothing
*   Project
    *   git repository
*   Each configuration
    *   Environment variables
    *   [Stages](https://www.finalbuilder.com/continua-ci/feature-tour/advanced-workflow) with
        *   Agent requirements
        *   Build task
        *   Unit test task

### C# / Delphi: getting the `rsvars.bat` / `vsvars32.bat` environment variable info

When building C# or Delphi programs using [msbuild](https://en.wikipedia.org/wiki/MSBuild), you normally first run [`vsvars32.bat`](http://msdn.microsoft.com/en-us/library/1700bbwd.aspx) or [`rsvars.bat`](https://www.google.com/search?q=rsvars.bat) to select for which Visual Studio or Delphi version you want to setup environment variables.

In most continuous integration systems you cannot do that, as processes execute independently of each other (so the environment variables set in a batch file execution step would get lost in the next step).

The [workaround is to wrap the batch file and msbuild call into one script](http://stackoverflow.com/questions/9358239/running-rsvars-bat-before-teamcity-build-starts/9715266#9715266), but that defeats the msbuild result check capabilities of Continua CI (or any other continuous integration solution).

That's why you can [edit the environment variables on Continua CI](https://www.finalbuilder.com/support/forums/aft/11648) on multiple levels.

You get these values using a small script like this (you should specify the full path for any specific Delphi version you want to use): [`get-rsvars-diff.bat`](https://gist.github.com/jpluimers/c986d8a767fa4ff63cc1)

    setlocal
    set > %temp%\set.0-before.txt
    call rsvars.bat
    set > %temp%\set.1-after.txt
    endlocal
    diff %temp%\set.0-before.txt %temp%\set.1-after.txt

Which then results in a diff like for Delphi XE6: [`XE6-rsvars-difference.bat`](https://gist.github.com/jpluimers/781d3aee152c467b7091)

    BDS=C:\Program Files (x86)\Embarcadero\Studio\14.0
    BDSINCLUDE=C:\Program Files (x86)\Embarcadero\Studio\14.0\include
    CG_64_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\Studio\14.0\include\boost_1_50
    CG_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\Studio\14.0\include\boost_1_39
    FrameworkDir=C:\Windows\Microsoft.NET\Framework\v3.5
    FrameworkVersion=v3.5
    LANGDIR=EN
    Path=C:\Windows\Microsoft.NET\Framework\v3.5;;C:\Program Files (x86)\Embarcadero\Studio\14.0\bin;C:\Program Files (x86)\Embarcadero\Studio\14.0\bin64;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE3\win32_togo;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE3\win64_togo;%PATH%

You then enter these differences in your [msbuild action Environment Variables](http://wiki.finalbuilder.com/display/continua/MSBuild+Action#MSBuildAction-EnvironmentVariables). Of course this is specific for your agent machine, so you need to watch two things:

*   Ensure the values are really correct, for instance by dumping the environment in a pre-build event on a normal development machine.
*   Use the property collectors to auto-fill the machine dependent values, for instance like below.

[continuaCI-msbuild-environment.txt](https://gist.github.com/jpluimers/009f39203c737c2130b7)

    BDS=$Agent.Delphi.XE6.Path$
    BDSLIB=$Agent.Delphi.XE6.Path$\lib
    BDSINCLUDE=$Agent.Delphi.XE6.Path$\include

If you forget for instance `BDS`, you get [errors like this in your msbuild log](http://qc.embarcadero.com/wc/qcmain.aspx?d=45435):

    The "DCC" task could not be loaded from the assembly \bin\Borland.Build.Tasks.Delphi.dll

### Property Collectors

As mentioned above, Delphi projects normally require `rsvars.bat` from the right Delphi version being called. Describing how to create the environment variables is in [Building Delphi projects with Continua CI](https://www.finalbuilder.com/resources/blogs/postid/695/building-delphi-projects-with-continua-ci),

The process uses [Property Collectors](http://wiki.finalbuilder.com/display/continua/Property+Collectors), which the article there covers very lightly, so here is where you find those on your server: <http://localhost:8080/administration/ci/collectors>

For Delphi, the below keys are defined (similar keys exist for many other tools like Visual Studio, msbuild, Git, Mercurial, etc):

| **Namespace**   | **Properties** | **Run On** | **Find the value of 'RootDir' in the registry key:** |
|-----------------|----------------|------------|------------------------------------------------------|
| `Delphi.2005`   | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Borland\BDS\3.0`        |
| `Delphi.2006`   | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Borland\BDS\4.0`        |
| `Delphi.2007`   | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Borland\BDS\5.0`        |
| `Delphi.2009`   | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\CodeGear\BDS\6.0`       |
| `Delphi.2010`   | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\CodeGear\BDS\7.0`       |
| `Delphi.7`      | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Borland\Delphi\7.0`     |
| `Delphi.XE`     | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\8.0`    |
| `Delphi.XE2`    | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\9.0`    |
| `Delphi.XE3`    | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\10.0`   |
| `Delphi.XE4`    | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\11.0`   |
| `Delphi.XE5`    | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\12.0`   |
| `Delphi.XE6`    | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\14.0`   |
| `Delphi.XE7`    | `Path`         | `Agent`    | `HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\15.0`   |

You will find these as properties on your agent at a path like <http://localhost:8080/administration/ci/agents/view/{GUID}#properties> which you reach by clicking on [View] after each agent at <http://localhost:8080/administration/ci/agents/viewall>.

## Building with msbuild

For both Delphi and C# projects, you usually use an [msbuild action](http://wiki.finalbuilder.com/display/continua/MSBuild+Action), so that's what you will see in the next steps.

Note that if you [combine multiple msbuild actions in one configuration, they will see each others results](https://www.finalbuilder.com/support/forums/aft/13068), which might be bad or good, depending on your objective.

### Building Delphi projects

From the command-line, the Spring4D build commands to build with Delphi XE are these:

[`Spring4D-DelphiXE-Debug.bat`](https://gist.github.com/jpluimers/34737b62a1e65a63fe0e)

    "C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\bin\rsvars.bat"
    C:\Windows\Microsoft.NET\Framework\v2.0.50727\msbuild.exe /nologo "Packages\DelphiXE\Spring4D.groupproj" /target:build /p:DCC_BuildAllUnits=true /p:"Config=Debug" /p:"Platform=Win32" /p:"DCC_DcuOutput=Library\DelphiXE\Debug" /p:"DCC_Define=CONSOLE_TESTRUNNER" /l:FileLogger,Microsoft.Build.Engine;logfile="Logs\DelphiXE.Win32.Debug.MSBuildLog.txt"

[`Spring4D-DelphiXE-Release.bat`](https://gist.github.com/jpluimers/a77504792d02e48d76a6):

    "C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\bin\rsvars.bat"
    C:\Windows\Microsoft.NET\Framework\v2.0.50727\msbuild.exe /nologo "Packages\DelphiXE\Spring4D.groupproj" /target:build /p:DCC_BuildAllUnits=true /p:"Config=Release" /p:"Platform=Win32" /p:"DCC_DcuOutput=Library\DelphiXE\Release" /p:"DCC_Define=CONSOLE_TESTRUNNER" /l:FileLogger,Microsoft.Build.Engine;logfile="Logs\DelphiXE.Win32.Release.MSBuildLog.txt"

For both, the `rsvars.bat` [diff](https://en.wikipedia.org/wiki/Diff) is this one:

    BDS=C:\Program Files (x86)\Embarcadero\Studio\14.0
    BDSCOMMONDIR=C:\Users\Public\Documents\Embarcadero\Studio\14.0
    BDSINCLUDE=C:\Program Files (x86)\Embarcadero\Studio\14.0\include
    CG_64_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\Studio\14.0\include\boost_1_50
    CG_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\Studio\14.0\include\boost_1_39
    FrameworkDir=C:\Windows\Microsoft.NET\Framework\v3.5
    FrameworkVersion=v3.5
    LANGDIR=EN
    Path=C:\Windows\Microsoft.NET\Framework\v3.5;;C:\Program Files (x86)\Embarcadero\Studio\14.0\bin;C:\Program Files (x86)\Embarcadero\Studio\14.0\bin64;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE3\win32_togo;C:\Users\Public\Documents\Embarcadero\InterBase\redist\InterBaseXE3\win64_togo;%PATH%

Now in Continua CI, it is not wise to have global dependencies (like on the Delphi Library path which is defined in `HKCU` or on a global `EnvOptions.proj`) as these change when you install/uninstall components, and you want to keep the build machine as clean as possible.

> Often the Continua CI Agent user is non-interactive, or hardly used in an interactive way, so global Delphi settings (like the Delphi Library path) might not be up to date, or not set at all. In addition, depending on global user (or even machine) things that might vary from user to user or from machine to machine is not a good idea. So always make sure that you set those dependencies on the Project or Configuration level in Continua CI.
So the trick is to convert these parameters and environment variables to Continua CI members of an msbuild action:

    BDS=C:\Program Files (x86)\Embarcadero\RAD Studio\8.0
    BDSCOMMONDIR=C:\Users\Public\Documents\RAD Studio\8.0
    CG_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\include\boost_1_39
    FrameworkDir=C:\Windows\Microsoft.NET\Framework\v2.0.50727
    FrameworkVersion=v2.0.50727
    LANGDIR=EN
    Path=C:\Windows\Microsoft.NET\Framework\v2.0.50727;%PATH%

    C:\Windows\Microsoft.NET\Framework\v2.0.50727\msbuild.exe /nologo
        "Packages\DelphiXE\Spring4D.groupproj"
        /target:build
        /p:DCC_BuildAllUnits=true
        /p:"Config=Debug"
        /p:"Platform=Win32"
        /p:"DCC_DcuOutput=Library\DelphiXE\Debug"
        /p:"DCC_Define=CONSOLE_TESTRUNNER"
        /l:FileLogger,Microsoft.Build.Engine;logfile="Logs\DelphiXE.Win32.Debug.MSBuildLog.txt"

#### Configuring the Project Variables

| Name             | Description | Value                  | Variable Type   |
|------------------|-------------|------------------------|-----------------|
| `RepositoryRoot` | -           | `$Source.spring4djwp$` | `Expression`    |

#### Configuring the Stage Variables

Some values (like Debug, Win32) above are used multiple times, so they are excellent candidates to become variables.

So create these Variables and values:

| Name            | Description                                                                                       | Value                     | Variable Type | Prompt Type       |
|-----------------|---------------------------------------------------------------------------------------------------|---------------------------|---------------|-------------------|
| `BDSRoot`       | The Delphi Agent to use: `$Agent.Delphi.XE.Path$`, `$Agent.Delphi.XE#.Path$` where `#`=`2`..`7`   | `$Agent.Delphi.XE7.Path$` | Expression    | `Text`            |
| `Configuration` | Configuration: `Debug` or `Release`                                                               | `Release`                 | Text          | `Dropdown Select` |
| `DCC_Define`    | Always `CONSOLE_TESTRUNNER` to allow `NUnit` XML compatible output from the unit tests.           | `CONSOLE_TESTRUNNER`      | Text          | `Text`            |
| `DelphiVersion` | Automatically computed.                                                                           | -                         | Text          | `Text`            |
| `Platform`      | Platform value to build for: `Win32`, `Win64`, `OSX32`, `iOSSimulator`, `iOSDevice`, `AndroidARM` | `Win64`                   | Text          | `Dropdown Select` |
| `TargetVersion` | `XE` or `XE#` where `#`=`1`..`7`                                                                  | `XE7`                     | Text          | `Text`            |

Later on (in the various msbuild tabs), when you want to use the values, just surround the variable names with percent signs. So:

*   `%Configuration%==Debug`
*   `%Platform%==Win32`

#### Configure the main msbuild tab

Set these entries on the main msbuild tab:

| Field                      | Value                                                         |
|----------------------------|---------------------------------------------------------------|
| name                       | (choose a meaningful name)                                    |
| Project file               | `$Source._spring4djwp_$\Packages\DelphiXE\Spring4D.groupproj` |
| Targets (case insensitive) | Build                                                         |
| Configuration              | `%Configuration%`                                             |
| Output path                | `$Workspace$\Output`                                          |
| MSBuild Platform           | `Default`                                                     |
| Using                      | `MSBuild 4.0`                                                 |

In the Project File, if you forget the `$Source.spring4djwp$\` part, then you get an error message like this:

> `The working directory does not exist : C:\ContinuaCI\WorkSpace\Ws\48\Packages\DelphiXE`

The reason is that the working directory will include the slug name of your repository:

> `C:\ContinuaCI\WorkSpace\Ws\44\Source\_spring4djwp_\Packages\DelphiXE`

The msbuild version for Delphi XE should be 2.0 or higher. Higher versions give more detailed output (which you can increase in the Options tab using the Verbosity option that ranges from Quited, through Minimal, Normal and Detailed through Diagnostic which you will need for hard to trace build issues).

#### Configuring the properties

Except for the "Config" parameter, any /p parameter passed to msbuild goes into a property:

    `DCC_BuildAllUnits=true
    Platform=%Platform%
    DCC_DcuOutput=$Workspace$\Library\DelphiXE\%Configuration%
    DCC_Define=CONSOLE_TESTRUNNER`

The "Config" parameter is at the first tab of the msbuild action: the "Configuration". So make sure you set that to "Debug".

Finally (and when using Spring4D only for Delphi XE, but for other projects also for different Delphi versions) the property that gets the build going, as I will explain later:

> `DelphiLibraryPath=$Agent.Delphi.XE.Path$\Lib\%Platform%\%Configuration%`

#### Configuring environment

The environment variables will not be fully hard coded: they are all based on the $Agent.Delphi.XE.Path$ property form the property collector on this agent.

> `BDS=$Agent.Delphi.XE.Path$`

#### Configure the stage requirement: check Delphi XE is there

To ensure that a specific Delphi version is indeed available on your Agent, you have to configure an [Agent Requirement](http://wiki.finalbuilder.com/display/continua/Agent+Requirements). The documentation about it is very flimsy, but [Building Delphi projects with Continua CI](https://www.finalbuilder.com/resources/blogs/postid/695/building-delphi-projects-with-continua-ci).

In our case, it comes down to configure this requirement:
> `$Agent.Delphi.XE$    requirement    Exists`

#### Unused environment variables

These environment variables might be used, but not by all builds, so they were not needed to get Spring4D built:

    `BDSLIB=$Agent.Delphi.XE.Path$\lib
    BDSINCLUDE=$Agent.Delphi.XE.Path$\include
    BDSCOMMONDIR=C:\Users\Public\Documents\RAD Studio\8.0
    CG_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\include\boost_1_39
    FrameworkDir=C:\Windows\Microsoft.NET\Framework\v2.0.50727
    FrameworkVersion=v2.0.50727
    LANGDIR=EN
    Path=C:\Windows\Microsoft.NET\Framework\v2.0.50727;%PATH%`

Path is not used, as ContinuaCI takes care of that. FrameworkDir and FrameworkVersion is not used because that depends on the MSBuild version used.

#### Specify the `DelphiLibraryPath` in MSBuild

Note: in the below section, `8.0` is for `Delphi XE`, but the general part holds for any Delphi version.

The Delphi Library path is normally a concatenation of the contents of the `Search Path` values of two (2!) keys in the below list: the base key, and the `Platform` specific key:

*   `HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library`
*   `HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library\Win32`
*   `HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library\OSX32`
*   `HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library\Linux32`

The way that ends up in the MSBuild configuration is through the [`EnvOptions.proj`](https://www.google.com/search?q=&quot;EnvOptions.proj&quot;) file that is normally in this directory:

> `%AppData%\Embarcadero\BDS\8.0\EnvOptions.proj`

If it exists, the `EnvOptions.proj` file is included by either `CodeGear.Common.Targets` (any Delphi version) and `CodeGear.Delphi.Targets` (Delphi XE2 and up) as [explained](http://stackoverflow.com/questions/1821112/how-does-msbuild-find-the-delphi-search-path/1821144#1821144) by [User Jon Benedicto](http://stackoverflow.com/users/84190/jon-benedicto): When the IDE runs, it copies the settings from the registry to `EnvOptions.proj` and it is then used by MSBuild through the `*.Targets` files.

When that file does not exist, Delphi XE2 and higher will set a default value in `CodeGear.Delphi.Targets` to `$(BDSLIB)\$(PLATFORM)\$(CONFIG)`: [DelphiLibraryPath-CodeGear.Delphi.Targets](https://gist.github.com/jpluimers/06fc33a956a174a15a4f)

      <DelphiLibraryPath Condition="'$(DelphiLibraryPath)'==''">$(BDSLIB)\$(PLATFORM)\$(CONFIG)</DelphiLibraryPath>

This means that:

*   For Delphi 2007, you have to specify the Library Path as a `Win32LibraryPath` MSBuild property as defined below
*   for Delphi 2009 and 2010 you have to specify a similar property that you obtain from the `EnvOptions.proj` file (just diff that against Delphi XE2 and higher to see the difference).
*   For Delphi XE, you have to specify the Library Path as a `DelphiLibraryPath` MSBuild property as defined below
*   For other Delphi versions, you might need this MSBuild property to specify additional paths that `CodeGear.Delphi.Targets` does not insert as default.
*   I need to research the [`ForceEnvOptionsUpdate`](https://www.google.com/search?q=ForceEnvOptionsUpdate) registry value one day as it seems [related to writing this `EnvOptions.proj` file](http://support.embarcadero.com/article/39758).

This is the `DelphiLibraryPath` value that includes both the `Win32\Debug` folder and the `Include` folder:

> `DelphiLibraryPath=$Agent.Delphi.XE.Path$\Lib\Win32\Debug;$Agent.Delphi.XE.Path$\Include;`

I'm not sure if it is possible to substitute Platform (here: `Win32`) and Configuration (here: `Debug`) in an easy manner yet.

If you don't have the `DelphiLibraryPath` right, you get error messages in the builds like these:

*   `On packages: [Fatal: E2202 Required package 'rtl' not found](https://www.google.com/search?q=%22Fatal%3A%20E2202%20Required%20package%20)`
*   `On projects: [Fatal: F1027 Unit not found: 'System.pas' or binary equivalents (.dcu)](https://www.google.com/search?q=%22Fatal%3A+F1027+Unit+not+found%3A+)`

#### Build stage

As [guest users cannot see the stages yet](https://plus.google.com/+JeroenPluimers/posts/7dWFP7E7LPx), here is an example picture:

![](Build-steps-in-Spring4D-Stage-ContinuaCI.png)

#### Android manifest errors

To prevent errors like these:

> `C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\bin\CodeGear.Common.Targets(1088,5): error MSB4018: The "CreateAndroidManifestFile" task failed unexpectedly.`

> `C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\bin\CodeGear.Common.Targets(1088,5): error MSB4018: System.IO.DirectoryNotFoundException: Could not find a part of the path 'C:\Users\ContinuaCI\AppData\Roaming\Embarcadero\BDS\12.0\AndroidManifest.xml'.`

further research is needed. This is why the iOS and Android projects do not build on the build server yet.

### Building C# projects

C# projects requires `vsvars32.bat` being called

#### Unit testing Delphi projects

Continua CI requires unit testing projects to emit NUnit XML compatible output (there is even an [XSD defining NUnit XML results](http://stackoverflow.com/questions/3878018/xsd-for-the-xml-file-that-nunit-uses)).

DUnitX already emits that output (but I've not seen the XSD file used in there, so I wonder how the validation of the XML is done).

[For DUnit, there is a DUnit-XML extension](https://plus.google.com/u/0/+JeroenPluimers/posts/TB3AcRrX6Bf) that allows output in NUnit XML format: [https://github.com/VSoftTechnologies/DUnit-XML](https://github.com/VSoftTechnologies/DUnit-XML).

It's not been updated in a while and may not be producing 100% correct xml but it's a start.

If your own unit testing framework emits XML, you could use XSLT to map to NUnit compatible XML (just like you could [use XSLT to post-process NUnit output](http://stackoverflow.com/questions/2222203/is-it-possible-to-customize-nunit-xml-output)).

#### Notes

*   Continua CI works better with Git than Mercurial/HG.
*   Same for GitHub versus BitBucket: pull-requests support in GitHub is better than in BitBucket: [Building GitHub Pull Requests with Continua CI](https://www.finalbuilder.com/resources/blogs/postid/700/building-github-pull-requests-with-continua-ci).
*   Ensure your git is up to date; otherwise you will get errors when accessing repositories

A while ago, I had this error on BitBucket:
<blockquote><code>Running git.exe with arguments "fetch --prune" failed with return code 128 and error output: "fatal: unable to access 'https://%account%@bitbucket.org/%user%/%repository%.git/': Unknown SSL protocol error in connection to bitbucket.org:443</code></blockquote>
A quick search for <a href="https://www.google.com/search?q=%22Unknown+SSL+protocol+error+in+connection+to+bitbucket.org%3A443%22">"Unknown SSL protocol error in connection to bitbucket.org:443"</a> pointed me to a <a href="http://stackoverflow.com/questions/20491027/unknown-ssl-protocol-error-in-connection#comment39628017_24380075" target="_blank">comment</a> by <a href="http://stackoverflow.com/users/262618/ludwik-trammer">Ludwik Trammer</a> on an <a href="http://stackoverflow.com/questions/20491027/unknown-ssl-protocol-error-in-connection" target="_blank">answer</a> by <a href="http://stackoverflow.com/users/6759/jordfr%c3%a4s" target="_blank">Jordfräs</a>:
<blockquote>I resolved the issue by upgrading from git 1.8 to git 2.0.</blockquote>
Which reminded me this was a Windows system, where there is no package manager that verifies how far your non-system software is behind.

One day, I will write a script that finds out about the git version history and inform me of major/minor versions I've skipped.

Some notes for that:
<ul>
	<li>This VM was at "git version 1.8.5.2.msysgit.0" from indeed a very old "<a href="https://github.com/msysgit/msysgit/releases/tag/Git-1.8.5.2-preview20131230" target="_blank">Git-1.8.5.2-preview20131230</a>.exe".</li>
	<li>For version 1.x, the Windows development of Git
<ul>
	<li>was at the repository <a href="https://github.com/msysgit/msysgit" target="_blank">https://github.com/msysgit/msysgit</a></li>
	<li>release history was at <a href="https://github.com/msysgit/msysgit/releases" target="_blank">https://github.com/msysgit/msysgit/releases</a>.</li>
</ul>
</li>
	<li>Now I'm at "git version 2.6.1.windows.1" from "<a href="https://github.com/git-for-windows/git/releases/tag/v2.6.1.windows.1" target="_blank">Git-2.6.1-32-bit</a>.exe" from <a href="https://github.com/git-for-windows/git/releases/latest" target="_blank">https://github.com/git-for-windows/git/releases/latest</a>.</li>
	<li>For version 2.0+, the Windows development Git
<ul>
	<li>is at the repository <a href="https://github.com/git-for-windows/git" target="_blank">https://github.com/git-for-windows/git</a></li>
	<li>release history is at <a href="https://github.com/git-for-windows/git/releases" target="_blank">https://github.com/git-for-windows/git/releases</a>.</li>
	<li>the latest download is at <a href="https://git-scm.com/download/win" target="_blank">https://git-scm.com/download/win</a> which will auto-download the 32-bit version and provides manual downloads of the x64 version.</li>
</ul>
</li>
</ul>
Probably I will need to do something similar for Mercurial/hg in the future as well.

--jeroen

via: <a href="http://stackoverflow.com/questions/20491027/unknown-ssl-protocol-error-in-connection" target="_blank">git - Unknown SSL protocol error in connection - Stack Overflow</a>

--jeroen

## Further reading

*   [Building Delphi projects with Continua CI](https://www.finalbuilder.com/resources/blogs/postid/695/building-delphi-projects-with-continua-ci).
*   [Integrating DUnitX Unit Testing with Continua CI](https://www.finalbuilder.com/language/en-au/resources/blogs/postid/699/integrating-dunitx-unit-testing-with-continua-ci).
*   [Automated Builds vs Continuous Integration](https://www.finalbuilder.com/resources/blogs/postid/703/automated-builds-vs-continuous-integration).
*   [Problems starting database after windows 8 update - VSoft](https://www.finalbuilder.com/support/forums/aft/11575).
*   [continua ci Archives - Geert van HorrikGeert van Horrik](http://geertvanhorrik.com/tag/continua-ci-2/).
*   [What kind changes to DUnit would be required to emit DUnitX compatible…](https://plus.google.com/u/0/+JeroenPluimers/posts/TB3AcRrX6Bf).
*   [Any chance of running a pre-build batch file for the msbuild targets?](https://plus.google.com/+JeroenPluimers/posts/XXtEGrXKuX6).
*   [Backing up the Continua database - Continua CI - VSoft Technologies Documentation Wiki](http://wiki.finalbuilder.com/display/continua/Backing+up+the+Continua+database).
*   [Building Feature &amp; Personal branches with Continua CI](https://www.finalbuilder.com/resources/blogs/postid/693/building-feature-personal-branches-with-continua-ci).
*   [Variables - Continua CI - VSoft Technologies Documentation Wiki](http://wiki.finalbuilder.com/display/continua/Variables).
*   [Variables, Objects &amp; Expressions - Continua CI - VSoft Technologies Documentation Wiki](http://wiki.finalbuilder.com/pages/viewpage.action?pageId=655772).
*   [Feature request: create configurations based on simple text -](https://www.finalbuilder.com/support/forums/aft/13519).
*   [Git - Continua CI - VSoft Technologies Documentation Wiki](http://wiki.finalbuilder.com/display/continua/Git).
*   [Building GitHub Pull Requests with Continua CI](https://www.finalbuilder.com/resources/blogs/postid/700/building-github-pull-requests-with-continua-ci).
*   [Git - The Refspec](http://git-scm.com/book/ch9-5.html).
