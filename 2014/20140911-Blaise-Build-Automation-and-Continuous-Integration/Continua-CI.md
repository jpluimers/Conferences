I like <a href="https://www.finalbuilder.com/continua-ci" target="_blank">Continua CI</a>, especially because of how <a href="https://www.finalbuilder.com/continua-ci/feature-tour" target="_blank">feature rich it is</a>, the <a href="https://www.finalbuilder.com/downloads/finalbuilder/finalbuilder-7-version-history" target="_blank">FinalBuilder</a> heritage, and  that the <a href="https://www.finalbuilder.com/continua-ci/pricing" target="_blank">pricing</a> starts with free (as in <a href="https://en.wikipedia.org/wiki/Gratis" target="_blank">gratis</a>) when you run a 1 server + 1 concurrent build on a local agent setup.

Oh and their customer service is awesome: you find a reproducible bug and <a href="https://plus.google.com/+JeroenPluimers/posts/1tyJsQjYhNY" target="_blank">often they fix it within hours</a>.

Like with any <a href="https://en.wikipedia.org/wiki/Continuous_integration" target="_blank">continuous integration system</a>, it has a learning curve and gotchas. That's OK, as it will save you a lot of time.

So here are some links and notes and links:
<ul>
	<li><a href="https://www.youtube.com/embed/pE0v_O7LsmA?__vid=826d3ae09cc70131903422000ab2058a" target="_blank">Continua CI in 3 minutes. - YouTube</a>.</li>
	<li><a href="https://www.youtube.com/user/vincentparrett/videos" target="_blank">VSoft Technologies - YouTube</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Tutorials" target="_blank">Tutorials - Continua CI - VSoft Technologies Documentation Wiki</a> consisting of these steps:
<ul>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Part+1%3A+Create+your+First+Project" target="_blank">Part 1: Create your First Project</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Part+2%3A+Create+your+First+Configuration" target="_blank">Part 2: Create your First Configuration</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Part+3%3A+Create+your+First+Repository" target="_blank">Part 3: Create your First Repository</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Part+4%3A+Create+your+First+Action" target="_blank">Part 4: Create your First Action</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Part+5%3A+Using+Builds" target="_blank">Part 5: Using Builds</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Part+6%3A+Automate+your+Builds" target="_blank">Part 6: Automate your Builds</a>.</li>
</ul>
</li>
</ul>
I'll base a lot of this on the work I did for the <a href="https://plus.google.com/111642256327642864138/about" target="_blank">Spring4D</a> framework.

Note: it is hard to keep screenshots up to date, so neither my article, nor the <a href="http://wiki.finalbuilder.com/display/continua" target="_blank">Continua CI - VSoft Technologies Documentation Wiki</a> will have completely accurate screenshots.

<!--more-->
<h1>Installation</h1>
<h2>Download and install</h2>
<a href="https://www.finalbuilder.com/downloads/continuaci" target="_blank">Downloading</a> is dead simple. I used the x64 builds (my systems are all x64 systems) of the . Then just run the installer. I will post installation screenshots but they are a but dull.

## Security of shares

During the installation, a share is created with read-write access for the group Everyone. You probably want to confine this. 

<h2>Inspect the installation</h2>
After installing, <a href="https://www.finalbuilder.com/support/forums/aft/11575" target="_blank">if the database cannot be connected to</a>, you will see something similar to this at <a href="http://localhost:8080/install/serviceunavailable" target="_blank">http://localhost:8080/install/serviceunavailable</a>:
<blockquote>
<pre>23:00 : Starting
23:01 : Creating Application Setup.
23:01 : Creating Application instance.
23:01 : Starting
23:01 : Setting up Loggers
23:01 : Migrating Database
23:01 : Could not initialise database: Failed to establish a connection to '127.0.0.1'. Check the eventlog for more info.
23:01 : Starting Application instance.</pre>
</blockquote>
The <a href="https://en.wikipedia.org/wiki/Event_Viewer" target="_blank">eventlog</a> will not contain clues, so check these keys in the registry:
<ul>
	<li><code>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ContinuaCIPostgreSQL</code></li>
	<li><code>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ContinuaCIAgent</code></li>
	<li><code>HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ContinuaCI</code></li>
</ul>
<h2>First time configuration</h2>
When the installation does come up, you end up at the Welcome page: <a href="http://localhost:8080/install" target="_blank">http://localhost:8080/install</a> where you have to configure an <a href="https://www.google.com/search?q=&quot;Continua+Administrator&quot;+site%3Afinalbuilder.com" target="_blank">Continua Administrator</a> user. This is not explained well in the Continua CI documentation, so I just regard this as the <a href="https://en.wikipedia.org/wiki/Superuser" target="_blank">root user</a> for Continua CI.

After that, you are prompted to create your first project: <a href="http://localhost:8080/ci/projectwizard/start" target="_blank">http://localhost:8080/ci/projectwizard/start</a>

And you can optionally create new users with certain rights as well.
<h2>Upgrading can be done in-place</h2>
The <a href="http://wiki.finalbuilder.com/display/continua/Upgrading" target="_blank">Continua CI installers are smart enough to upgrade in-place</a> while keeping the configuration. But note they cannot do in-place downgrade.

This is where you can find the installed versions from the web-interface:
<ul>
	<li>Agents: <a href="http://localhost:8080/administration/ci/agents/viewall" target="_blank">http://localhost:8080/administration/ci/agents/viewall</a></li>
	<li>Server: <a href="http://localhost:8080/administration/ci/collectors/properties" target="_blank">http://localhost:8080/administration/ci/collectors/properties</a></li>
</ul>
<h1>Structure</h1>
The organisational architecture of Continua CI is from Global through Project to Config.

Depending on the kind of project (business project, open source project supporting many product versions and targets) you need to carefully think what to define at each level.
<ul>
	<li>Global at the server level</li>
	<li>Project at the intermediate level</li>
	<li>Configuration at the leaf level</li>
</ul>
Each level inherits from the parent level.

[caption id="" align="alignnone" width="350"]<img class="" src="https://www.finalbuilder.com/images/continua-ci/continua-architecture.png" alt="Hierarchy: Global, Project, Config" width="350" height="250" /> Hierarchy: Global, Project, Configuration[/caption]

## Per level

Below are the main things you edit at each level:
<ul>
	<li>Global
<ul>
	<li>Application Variables (the Environment variables are inherited from the server)</li>
	<li>Global level repositories</li>
	<li>Server security (Users, Groups, Roles, Access Control)</li>
	<li>Server properties</li>
	<li>Property collectors (readonly)</li>
</ul>
</li>
	<li>Project
<ul>
	<li>Project Variables</li>
	<li>Project level Repositories</li>
</ul>
</li>
	<li>Configuration
<ul>
	<li>Configuration Variables</li>
	<li>Configuration level Repositories</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Stages" target="_blank">Stages</a> (tasks you can execute varying from builds, to scripts, to flow control with all kinds of checks and decisions) and <a href="http://wiki.finalbuilder.com/display/continua/Stages" target="_blank">gates</a> (that allow/block you to get to the next stage).</li>
</ul>
</li>
</ul>
Note:
<blockquote>Variable values can be obtained by percentage signs (%). Object and property values can be obtained by dollar signs ($). Both are hierarchical (so there is %Global.*%, %Configuration.*%, $Agent.*$, $Build.*$, etc) and there is a scope (from close to wide: Build, Configuration, Project, Application, Environment). When you need a percent  or dollar character then you need to <a href="http://wiki.finalbuilder.com/display/continua/Part+5:+Using+Builds#Part5:UsingBuilds-CreateDirectoryAction" target="_blank">escape them by doubling</a>: %% and $$.

Read these two links for more information: <a href="http://wiki.finalbuilder.com/display/continua/Variables" target="_blank">Variables</a> and <a href="http://wiki.finalbuilder.com/pages/viewpage.action?pageId=655772" target="_blank">Variables, Objects &amp; Expressions</a>.</blockquote>

## Spring4D hierarchy

For Spring4D, we've chosen this global/project/configuration hierarchy:
<ul>
	<li>Global level:
<ul>
	<li>Server</li>
</ul>
</li>
	<li>Project level:
<ul>
	<li>Spring4D</li>
</ul>
</li>
	<li>Configurations:
<ul>
	<li>DelphiXE.Win32.Debug</li>
	<li>DelphiXE.Win32.Release</li>
	<li>DelphiXE2.Win32.Debug</li>
	<li>DelphiXE2.Win32.Release</li>
	<li>DelphiXE2.Win64.Debug</li>
	<li>DelphiXE2.Win64.Release</li>
	<li>DelphiXE2.OSX32.Debug</li>
	<li>DelphiXE2.OSX32.Release</li>
	<li>DelphiXE3.Win32.Debug</li>
	<li>DelphiXE3.Win32.Release</li>
	<li>DelphiXE3.Win64.Debug</li>
	<li>DelphiXE3.Win64.Release</li>
	<li>DelphiXE3.OSX32.Debug</li>
	<li>DelphiXE3.OSX32.Release</li>
	<li>DelphiXE4.Win32.Debug</li>
	<li>DelphiXE4.Win32.Release</li>
	<li>DelphiXE4.Win64.Debug</li>
	<li>DelphiXE4.Win64.Release</li>
	<li>-DelphiXE4.iOSSimulator.Debug</li>
	<li>-DelphiXE4.iOSSimulator.Release</li>
	<li>-DelphiXE4.iOSDevice.Debug</li>
	<li>-DelphiXE4.iOSDevice.Release</li>
	<li>DelphiXE5.Win32.Debug</li>
	<li>DelphiXE5.Win32.Release</li>
	<li>DelphiXE5.Win64.Debug</li>
	<li>DelphiXE5.Win64.Release</li>
	<li>DelphiXE5.OSX32.Debug</li>
	<li>DelphiXE5.OSX32.Release</li>
	<li>-DelphiXE5.iOSSimulator.Debug</li>
	<li>-DelphiXE5.iOSSimulator.Release</li>
	<li>-DelphiXE5.iOSDevice.Debug</li>
	<li>-DelphiXE5.iOSDevice.Release</li>
	<li>DelphiXE5.AndroidARM.Debug</li>
	<li>-DelphiXE5.AndroidARM.Release</li>
	<li>DelphiXE6.Win32.Debug</li>
	<li>DelphiXE6.Win32.Release</li>
	<li>DelphiXE6.Win64.Debug</li>
	<li>DelphiXE6.Win64.Release</li>
	<li>DelphiXE6.OSX32.Debug</li>
	<li>DelphiXE6.OSX32.Release</li>
	<li>DelphiXE6.iOSSimulator.Debug</li>
	<li>-DelphiXE6.iOSSimulator.Release</li>
	<li>-DelphiXE6.iOSDevice.Debug</li>
	<li>-DelphiXE6.iOSDevice.Release</li>
	<li>DelphiXE6.AndroidARM.Debug</li>
	<li>-DelphiXE6.AndroidARM.Release</li>
	<li>DelphiXE7.Win32.Debug</li>
	<li>DelphiXE7.Win32.Release</li>
	<li>DelphiXE7.Win64.Debug</li>
	<li>DelphiXE7.Win64.Release</li>
	<li>DelphiXE7.OSX32.Debug</li>
	<li>DelphiXE7.OSX32.Release</li>
	<li>-DelphiXE7.iOSSimulator.Debug</li>
	<li>-DelphiXE7.iOSSimulator.Release</li>
	<li>-DelphiXE7.iOSDevice.Debug</li>
	<li>-DelphiXE7.iOSDevice.Release</li>
	<li>-DelphiXE7.AndroidARM.Debug</li>
	<li>-DelphiXE7.AndroidARM.Release</li>
</ul>
</li>
</ul>
<blockquote>Note: The ones with a minus in front are not yet done.</blockquote>
This is what we defined at each level:
<ul>
	<li>Global: nothing</li>
	<li>Project
<ul>
	<li>git repository</li>
</ul>
</li>
	<li>Each configuration
<ul>
	<li>Environment variables</li>
	<li><a href="https://www.finalbuilder.com/continua-ci/feature-tour/advanced-workflow" target="_blank">Stages</a> with
<ul>
	<li>Agent requirements</li>
	<li>Build task</li>
	<li>Unit test task</li>
</ul>
</li>
</ul>
</li>
</ul>
<h2>C# / Delphi: getting the <code>rsvars.bat</code> / <code>vsvars32.bat</code> environment variable info</h2>
When building C# or Delphi programs using <a href="https://en.wikipedia.org/wiki/MSBuild" target="_blank">msbuild</a>, you normally first run <a href="http://msdn.microsoft.com/en-us/library/1700bbwd.aspx" target="_blank"><code>vsvars32.bat</code></a> or <a href="https://www.google.com/search?q=rsvars.bat" target="_blank"><code>rsvars.bat</code></a> to select for which Visual Studio or Delphi version you want to setup environment variables.

In most continuous integration systems you cannot do that, as processes execute independently of each other (so the environment variables set in a batch file execution step would get lost in the next step).

The <a href="http://stackoverflow.com/questions/9358239/running-rsvars-bat-before-teamcity-build-starts/9715266#9715266" target="_blank">workaround is to wrap the batch file and msbuild call into one script</a>, but that defeats the msbuild result check capabilities of Continua CI (or any other continuous integration solution).

That's why you can <a href="https://www.finalbuilder.com/support/forums/aft/11648" target="_blank">edit the environment variables on Continua CI</a> on multiple levels.

You get these values using a small script like this (you should specify the full path for any specific Delphi version you want to use):

https://gist.github.com/jpluimers/c986d8a767fa4ff63cc1  
<https://gist.github.com/jpluimers/c986d8a767fa4ff63cc1>

Which then results in a diff like:

https://gist.github.com/jpluimers/781d3aee152c467b7091  
<https://gist.github.com/jpluimers/781d3aee152c467b7091>

You then enter these differences in your <a href="http://wiki.finalbuilder.com/display/continua/MSBuild+Action#MSBuildAction-EnvironmentVariables" target="_blank">msbuild action Environment Variables</a>. Of course this is specific for your agent machine, so you need to watch two things:
<ul>
	<li>Ensure the values are really correct, for instance by dumping the environment in a pre-build event on a normal development machine.</li>
	<li>Use the property collectors to auto-fill the machine dependent values, for instance like below.</li>
</ul>

https://gist.github.com/jpluimers/009f39203c737c2130b7  
<https://gist.github.com/jpluimers/009f39203c737c2130b7>

<h2>Property Collectors</h2>
As mentioned above, Delphi projects normally require <code>rsvars.bat</code> from the right Delphi version being called. Describing how to create the environment variables is in <a href="https://www.finalbuilder.com/resources/blogs/postid/695/building-delphi-projects-with-continua-ci" target="_blank">Building Delphi projects with Continua CI</a>,

The process uses <a href="http://wiki.finalbuilder.com/display/continua/Property+Collectors" target="_blank">Property Collectors</a>, which the article there covers very lightly, so here is where you find those on your server: <a href="http://localhost:8080/administration/ci/collectors" target="_blank">http://localhost:8080/administration/ci/collectors</a>

For Delphi, the below keys are defined (similar keys exist for many other tools like Visual Studio, msbuild, Git, Mercurial, etc):
<table id="tableCollectors" class="dataViewTable">
<thead>
<tr>
<td><strong>Namespace</strong></td>
<td><strong>Properties</strong></td>
<td><strong>Run On</strong></td>
<td><strong>Description</strong></td>
</tr>
</thead>
<tbody>
<tr>
<td>Delphi.2005</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Borland\BDS\3.0'.</td>
</tr>
<tr>
<td>Delphi.2006</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Borland\BDS\4.0'.</td>
</tr>
<tr>
<td>Delphi.2007</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Borland\BDS\5.0'.</td>
</tr>
<tr>
<td>Delphi.2009</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\CodeGear\BDS\6.0'.</td>
</tr>
<tr>
<td>Delphi.2010</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\CodeGear\BDS\7.0'.</td>
</tr>
<tr>
<td>Delphi.7</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Borland\Delphi\7.0'.</td>
</tr>
<tr>
<td>Delphi.XE</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\8.0'.</td>
</tr>
<tr>
<td>Delphi.XE2</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\9.0'.</td>
</tr>
<tr>
<td>Delphi.XE3</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\10.0'.</td>
</tr>
<tr>
<td>Delphi.XE4</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\11.0'.</td>
</tr>
<tr>
<td>Delphi.XE5</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\12.0'.</td>
</tr>
<tr>
<td>Delphi.XE6</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\14.0'.</td>
</tr>
<tr>
<td>Delphi.XE7</td>
<td>Path</td>
<td>Agent</td>
<td>Find the value of 'RootDir' in the registry key 'HKEY_LOCAL_MACHINE\Software\Embarcadero\BDS\15.0'.</td>
</tr>
</tbody>
</table>
You will find these as properties on your agent at a path like <a href="http://localhost:8080/administration/ci/agents/view/{GUID}#properties" target="_blank">http://localhost:8080/administration/ci/agents/view/{GUID}#properties</a> which you reach by clicking on [View] after each agent at <a href="http://localhost:8080/administration/ci/agents/viewall" target="_blank">http://localhost:8080/administration/ci/agents/viewall</a>.
<h1>Building with msbuild</h1>
For both Delphi and C# projects, you usually use an <a href="http://wiki.finalbuilder.com/display/continua/MSBuild+Action" target="_blank">msbuild action</a>, so that's what you will see in the next steps.

Note that if you <a href="https://www.finalbuilder.com/support/forums/aft/13068" target="_blank">combine multiple msbuild actions in one configuration, they will see each others results</a>, which might be bad or good, depending on your objective.
<h2>Building Delphi projects</h2>
From the command-line, the Spring4D build commands to build with Delphi XE are these:

https://gist.github.com/jpluimers/a77504792d02e48d76a6  
<https://gist.github.com/jpluimers/a77504792d02e48d76a6>

https://gist.github.com/jpluimers/a77504792d02e48d76a6  
<https://gist.github.com/jpluimers/a77504792d02e48d76a6>

For both, the <code>rsvars.bat</code> <a href="https://en.wikipedia.org/wiki/Diff" target="_blank">diff</a> is this one:

Now in Continua CI, it is not wise to have global dependencies (like on the Delphi Library path which is defined in <code>HKCU</code> or on a global <code>EnvOptions.proj</code>) as these change when you install/uninstall components, and you want to keep the build machine as clean as possible.
<blockquote>Often the Continua CI Agent user is non-interactive, or hardly used in an interactive way, so global Delphi settings (like the Delphi Library path) might not be up to date, or not set at all. In addition, depending on global user (or even machine) things that might vary from user to user or from machine to machine is not a good idea. So always make sure that you set those dependencies on the Project or Configuration level in Continua CI.</blockquote>
So the trick is to convert these parameters and environment variables to Continua CI members of an msbuild action:
<blockquote>
<pre>BDS=C:\Program Files (x86)\Embarcadero\RAD Studio\8.0
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
</pre>
</blockquote>
<h3>Configuring the Project Variables</h3>
<table>
<thead>
<tr>
<td><strong>Name</strong></td>
<td><strong>Description</strong></td>
<td><strong>Value</strong></td>
<td><strong>Variable Type</strong></td>
</tr>
</thead>
<tbody>
<tr>
<td>RepositoryRoot</td>
<td></td>
<td class="wrap-text">$Source.spring4djwp$</td>
<td>Expression</td>
</tr>
</tbody>
</table>

<h3>Configuring the Stage Variables</h3>
Some values (like Debug, Win32) above are used multiple times, so they are excellent candidates to become variables.

So create these Variables and values:
<table>
<thead>
<tr>
<td><strong>Name</strong></td>
<td><strong>Description</strong></td>
<td><strong>Value</strong></td>
<td><strong>Variable Type</strong></td>
<td><strong>Prompt Type</strong></td>
</tr>
</thead>
<tbody>
<tr >
    <td>BDSRoot
    </td>
    <td>The Delphi Agent to use: $Agent.Delphi.XE.Path$, $Agent.Delphi.XE#.Path$ where #=2..7
    </td>
    <td class="wrap-text">$Agent.Delphi.XE7.Path$
    </td>
    <td>Expression
    </td>
        <td>
            
        </td>
</tr>
<tr>
    <td>Configuration
    </td>
    <td>Configuration: Debug or Release
    </td>
    <td class="wrap-text">Release
    </td>
    <td>Text
    </td>
        <td>
            Dropdown Select
        </td>
</tr>
<tr>
    <td>DCC_Define
    </td>
    <td>Always CONSOLE_TESTRUNNER to allow NUnit XML compatible output from the unit tests.
    </td>
    <td class="wrap-text">CONSOLE_TESTRUNNER
    </td>
    <td>Text
    </td>
        <td>
            Text
        </td>
</tr>
<tr>
    <td>DelphiVersion
    </td>
    <td>Automatically computed.
    </td>
    <td class="wrap-text">
    </td>
    <td>Text
    </td>
        <td>
            Text
        </td>
</tr>
<tr>
    <td>Platform
    </td>
    <td>Platform value to build for:
Win32, Win64, OSX32, iOSSimulator, iOSDevice, AndroidARM
    </td>
    <td class="wrap-text">Win64
    </td>
    <td>Text
    </td>
        <td>
            Dropdown Select
        </td>
</tr>
<tr>
    <td>TargetVersion
    </td>
    <td>XE or XE# where #=1..7
    </td>
    <td class="wrap-text">XE7
    </td>
    <td>Text
    </td>
        <td>
            Text
        </td>
</tr>
</tbody>
</table>
Later on (in the various msbuild tabs), when you want to use the values, just surround the variable names with percent signs. So:
<ul>
	<li>%Configuration%==Debug</li>
	<li>%Platform%==Win32</li>
</ul>
<h3>Configure the main msbuild tab</h3>
Set these entries on the main msbuild tab:
<ul>
	<li>name
<ul>
	<li>(choose a meaningful name)</li>
</ul>
</li>
	<li>Project file
<ul>
	<li>$Source.<em>spring4djwp</em>$\Packages\DelphiXE\Spring4D.groupproj</li>
</ul>
</li>
	<li>Targets (case insensitive)
<ul>
	<li>Build</li>
</ul>
</li>
	<li>Configuration
<ul>
	<li>%Configuration%</li>
</ul>
</li>
	<li>Output path
<ul>
	<li>$Workspace$\Output</li>
</ul>
</li>
	<li>MSBuild Platform
<ul>
	<li>Default</li>
</ul>
</li>
	<li>Using
<ul>
	<li>MSBuild 4.0</li>
</ul>
</li>
</ul>
If in the Project File, you forget the `$Source.spring4djwp$\` part, then you get an error message like this:
<blockquote><code>The working directory does not exist : C:\ContinuaCI\WorkSpace\Ws\48\Packages\DelphiXE</code></blockquote>
The reason is that the working directory will include the slug name of your repository:
<blockquote><code>C:\ContinuaCI\WorkSpace\Ws\44\Source\<em>spring4djwp</em>\Packages\DelphiXE</code></blockquote>
The msbuild version for Delphi XE should be 2.0 or higher. Higher versions give more detailed output (which you can increase in the Options tab using the Verbosity option that ranges from Quited, through Minimal, Normal and Detailed through Diagnostic which you will need for hard to trace build issues).
<h3>Configuring the properties</h3>
Except for the "Config" parameter, any /p parameter passed to msbuild goes into a property:
<blockquote><code>DCC_BuildAllUnits=true
Platform=%Platform%
DCC_DcuOutput=$Workspace$\Library\DelphiXE\%Configuration%
DCC_Define=CONSOLE_TESTRUNNER</code></blockquote>
The "Config" parameter is at the first tab of the msbuild action: the "Configuration". So make sure you set that to "Debug".

Finally (and when using Spring4D only for Delphi XE, but for other projects also for different Delphi versions) the property that gets the build going, as I will explain later:
<blockquote><code>DelphiLibraryPath=$Agent.Delphi.XE.Path$\Lib\%Platform%\%Configuration%</code></blockquote>
<h3>Configuring environment</h3>
The environment variables will not be fully hard coded: they are all based on the $Agent.Delphi.XE.Path$ property form the property collector on this agent.
<blockquote>BDS=$Agent.Delphi.XE.Path$</blockquote>
<h3>Configure the stage requirement: check Delphi XE is there</h3>
To ensure that a specific Delphi version is indeed available on your Agent, you have to configure an <a href="http://wiki.finalbuilder.com/display/continua/Agent+Requirements" target="_blank">Agent Requirement</a>. The documentation about it is very flimsy, but <a href="https://www.finalbuilder.com/resources/blogs/postid/695/building-delphi-projects-with-continua-ci" target="_blank">Building Delphi projects with Continua CI</a>.

In our case, it comes down to configure this requirement:
<blockquote><code>$Agent.Delphi.XE$    requirement    Exists</code></blockquote>
<h3>Unused environment variables</h3>
These environment variables might be used, but not by all builds, so they were not needed to get Spring4D built:
<blockquote><code>BDSLIB=$Agent.Delphi.XE.Path$\lib
BDSINCLUDE=$Agent.Delphi.XE.Path$\include
BDSCOMMONDIR=C:\Users\Public\Documents\RAD Studio\8.0
CG_BOOST_ROOT=C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\include\boost_1_39
FrameworkDir=C:\Windows\Microsoft.NET\Framework\v2.0.50727
FrameworkVersion=v2.0.50727
LANGDIR=EN
Path=C:\Windows\Microsoft.NET\Framework\v2.0.50727;%PATH%</code></blockquote>
Path is not used, as ContinuaCI takes care of that. FrameworkDir and FrameworkVersion is not used because that depends on the MSBuild version used.
<h3>Specify the <code>DelphiLibraryPath</code> in MSBuild</h3>
Note: in the below section, 8.0 is for Delphi XE, but the general part holds for any Delphi version.

The Delphi Library path is normally a concatenation of the contents of the <code>Search Path</code> values of two (2!) keys in the below list: the base key, and the <code>Platform</code> specific key:
<ul>
	<li>HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library</li>
	<li>HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library\Win32</li>
	<li>HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library\OSX32</li>
	<li>HKEY_CURRENT_USER\Software\Embarcadero\BDS\8.0\Library\Linux32</li>
</ul>
The way that ends up in the MSBuild configuration is through the <a href="https://www.google.com/search?q=&quot;EnvOptions.proj&quot;" target="_blank"><code>EnvOptions.proj</code></a> file that is normally in this directory:
<blockquote><code>%AppData%\Embarcadero\BDS\8.0\EnvOptions.proj</code></blockquote>
If it exists, the <code>EnvOptions.proj</code> file is included by either <code>CodeGear.Common.Targets</code> (any Delphi version) and <code>CodeGear.Delphi.Targets</code> (Delphi XE2 and up) as <a href="http://stackoverflow.com/questions/1821112/how-does-msbuild-find-the-delphi-search-path/1821144#1821144" target="_blank">explained</a> by <a href="http://stackoverflow.com/users/84190/jon-benedicto">User Jon Benedicto</a>: When the IDE runs, it copies the settings from the registry to <code>EnvOptions.proj</code> and it is then used by MSBuild through the <code>*.Targets</code> files.

When that file does not exist, Delphi XE2 and higher will set a default value in <code>CodeGear.Delphi.Targets</code> to <code>$(BDSLIB)\$(PLATFORM)\$(CONFIG)</code>:

https://gist.github.com/jpluimers/06fc33a956a174a15a4f

This means that:
<ul>
	<li>For Delphi XE, you have to specify the Library Path as an MSBuild property as defined below</li>
	<li>For other Delphi versions, you might need this MSBuild property to specify additional paths that <code>CodeGear.Delphi.Targets</code> does not insert as default.</li>
</ul>
This is the <code>DelphiLibraryPath</code> value that includes both the Win32 Debug folder and the Include folder:
<blockquote><code>DelphiLibraryPath=$Agent.Delphi.XE.Path$\Lib\Win32\Debug;$Agent.Delphi.XE.Path$\Include;</code></blockquote>
I'm not sure if it is possible to substitute Platform (here: <code>Win32</code>) and Configuration (here: <code>Debug</code>) in an easy manner yet.

If you don't have the DelphiLibraryPath right, you get error messages in the builds like these:
<ul>
	<li><code>On packages: <a href="https://www.google.com/search?q=%22Fatal%3A%20E2202%20Required%20package%20'rtl'%20not%20found%22" target="_blank">Fatal: E2202 Required package 'rtl' not found</a></code></li>
	<li><code>On projects: <a href="https://www.google.com/search?q=%22Fatal%3A+F1027+Unit+not+found%3A+'System.pas'+or+binary+equivalents+(.dcu)%22" target="_blank">Fatal: F1027 Unit not found: 'System.pas' or binary equivalents (.dcu)</a></code></li>
</ul>
<h3>Android manifest errors</h3>
To prevent errors like these:
<blockquote>C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\bin\CodeGear.Common.Targets(1088,5): error MSB4018: The "CreateAndroidManifestFile" task failed unexpectedly.
C:\Program Files (x86)\Embarcadero\RAD Studio\12.0\bin\CodeGear.Common.Targets(1088,5): error MSB4018: System.IO.DirectoryNotFoundException: Could not find a part of the path 'C:\Users\ContinuaCI\AppData\Roaming\Embarcadero\BDS\12.0\AndroidManifest.xml'.</blockquote>
ensure that:

...
<h2>Building C# projects</h2>
C# projects requires <code>vsvars32.bat</code> being called
<h3>Unit testing Delphi projects</h3>
Continua CI requires unit testing projects to emit NUnit XML compatible output (there is even an <a href="http://stackoverflow.com/questions/3878018/xsd-for-the-xml-file-that-nunit-uses" target="_blank">XSD defining NUnit XML results</a>).

DUnitX already emits that output (but I've not seen the XSD file used in there, so I wonder how the validation of the XML is done).

<a href="https://plus.google.com/u/0/+JeroenPluimers/posts/TB3AcRrX6Bf" target="_blank">For DUnit, there is a DUnit-XML extension</a> that allows output in NUnit XML format: <a href="https://github.com/VSoftTechnologies/DUnit-XML" target="_blank">https://github.com/VSoftTechnologies/DUnit-XML</a>.

It's not been updated in a while and may not be producing 100% correct xml but it's a start.

If your own unit testing framework emits XML, you could use XSLT to map to NUnit compatible XML (just like you could <a href="http://stackoverflow.com/questions/2222203/is-it-possible-to-customize-nunit-xml-output" target="_blank">use XSLT to post-process NUnit output</a>).
<h3>Notes</h3>
<ul>
	<li>Continua CI works better with Git than Mercurial/HG.</li>
	<li>Same for GitHub versus BitBucket: pull-requests support in GitHub is better than in BitBucket: <a href="https://www.finalbuilder.com/resources/blogs/postid/700/building-github-pull-requests-with-continua-ci" target="_blank">Building GitHub Pull Requests with Continua CI</a>.</li>
</ul>
--jeroen
<h1>Further reading</h1>
<ul>
	<li><a href="https://www.finalbuilder.com/resources/blogs/postid/695/building-delphi-projects-with-continua-ci" target="_blank">Building Delphi projects with Continua CI</a>.</li>
	<li><a href="https://www.finalbuilder.com/language/en-au/resources/blogs/postid/699/integrating-dunitx-unit-testing-with-continua-ci" target="_blank">Integrating DUnitX Unit Testing with Continua CI</a>.</li>
	<li><a href="https://www.finalbuilder.com/resources/blogs/postid/703/automated-builds-vs-continuous-integration" target="_blank">Automated Builds vs Continuous Integration</a>.</li>
	<li><a href="https://www.finalbuilder.com/support/forums/aft/11575" target="_blank">Problems starting database after windows 8 update - VSoft</a>.</li>
	<li><a href="http://geertvanhorrik.com/tag/continua-ci-2/" target="_blank">continua ci Archives - Geert van HorrikGeert van Horrik</a>.</li>
	<li><a href="https://plus.google.com/u/0/+JeroenPluimers/posts/TB3AcRrX6Bf" target="_blank">What kind changes to DUnit would be required to emit DUnitX compatible…</a>.</li>
	<li><a href="https://plus.google.com/+JeroenPluimers/posts/XXtEGrXKuX6" target="_blank">Any chance of running a pre-build batch file for the msbuild targets?</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Backing+up+the+Continua+database" target="_blank">Backing up the Continua database - Continua CI - VSoft Technologies Documentation Wiki</a>.</li>
	<li><a href="https://www.finalbuilder.com/resources/blogs/postid/693/building-feature-personal-branches-with-continua-ci" target="_blank">Building Feature &amp; Personal branches with Continua CI</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Variables" target="_blank">Variables - Continua CI - VSoft Technologies Documentation Wiki</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/pages/viewpage.action?pageId=655772" target="_blank">Variables, Objects &amp; Expressions - Continua CI - VSoft Technologies Documentation Wiki</a>.</li>
	<li><a href="https://www.finalbuilder.com/support/forums/aft/13519" target="_blank">Feature request: create configurations based on simple text -</a>.</li>
	<li><a href="http://wiki.finalbuilder.com/display/continua/Git" target="_blank">Git - Continua CI - VSoft Technologies Documentation Wiki</a>.</li>
	<li><a href="https://www.finalbuilder.com/resources/blogs/postid/700/building-github-pull-requests-with-continua-ci" target="_blank">Building GitHub Pull Requests with Continua CI</a>.</li>
	<li><a href="http://git-scm.com/book/ch9-5.html" target="_blank">Git - The Refspec</a>.</li>
</ul>