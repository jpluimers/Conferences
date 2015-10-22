# DAPUG 2015 fall Workshop

> Quality - It's all about the quality - Jeroen Pluimers

[Nyborg, Denmark, 20151020-20151021](http://www.dapug.dk/2015/08/workshop-20.html)

[Hotel Hesselet](http://www.hotel-hesselet.dk/)  
Christianslundsvej 119  
5800 Nyborg  
Denmark  
+45 65 31 30 29  

## After the Workshop

- Examples: <https://bitbucket.org/jeroenp/besharp.net>
- Slides: <http://github.com/jpluimers/Conferences>
- Blog: <http://wiert.me>

## Travel

- By train: It takes 1 hour 30 minutes from Copenhagen by train, and from Århus about 2 hours and 15 minutes.
- By car:
    1. Take exit 45 on the E20 highway, exit sign "Nyborg Øst" (Nyborg East).
    2. Head north and follow the signs: Strandhoteller (Beach hotels).
    3. Turn left onto Storebæltsvej/Route 163.
    4. Take Østerøvej to Christianslundsvej.
    5. Storebæltsvej turns slightly left and becomes Østerøvej
    6. Østerøvej turns left and becomes Christianslundsvej
    7. At Christianslundsvej, turn right (sign: Hotel Hesselet).

## Setup, Power, Network

Be early to setup at around 08:00. The workshop begins at about 09:30.

Bring a good mood, we're going to have fun!

### Setup

It makes it a lot easier if you have this installed on your machines:

- A Delphi version that is XE or higher
- [Git for Windows](https://github.com/git-for-windows/git/releases/latest) as the [Conferences repository](https://github.com/jpluimers/Conferences) is using Git.
- [Mercurial for Windows]() as the Examples repository is using Mercurial.
- [SourceTree for Windows](https://www.sourcetreeapp.com/) which makes it easier to visually work with Mercurial and Git repositories
- A good text editor (I like [Notepad++](https://notepad-plus-plus.org/) a lot)
- (Delphi) productivity tools like [Beyond Compare](http://www.scootersoftware.com), [GExperts](http://www.gexperts.org/), [ModelMaker Code Explorer](http://www.modelmakertools.com/code-explorer/index.html), etc.

#### Repositories used

- Spring4D:
    - Home: https://bitbucket.org/sglienke/spring4d
    - Git: https://bitbucket.org/sglienke/spring4d.git
    - Console: `git clone https://bitbucket.org/sglienke/spring4d.git`
- DSharp
    - Home: https://bitbucket.org/sglienke/dsharp
    - Git: https://bitbucket.org/sglienke/dsharp.git
    - Console: `git clone https://bitbucket.org/sglienke/dsharp.git`
- Knockoff
    - Home: https://bitbucket.org/sglienke/knockoff
    - Git: https://bitbucket.org/sglienke/knockoff.git
    - Console: `git clone https://bitbucket.org/sglienke/knockoff.git`
- BeSharp
    - Home: https://bitbucket.org/jeroenp/besharp.net
    - Mercurial/Hg: https://bitbucket.org/jeroenp/besharp.net
    - Console: `hg clone https://bitbucket.org/jeroenp/besharp.net`

Easiest way to get them:

    pushd "%USERPROFILE%"
    mkdir Versioned
    cd Versioned
    git clone https://bitbucket.org/sglienke/spring4d.git
    git clone https://bitbucket.org/sglienke/dsharp.git
    git clone https://bitbucket.org/sglienke/knockoff.git
    hg clone https://bitbucket.org/jeroenp/besharp.net`
    popd

#### Tools used

- ZoomIt: https://technet.microsoft.com/en-us/sysinternals/bb897434.aspx
- ProcMon: https://technet.microsoft.com/en-us/sysinternals/bb896645
- Everything: http://www.voidtools.com/
- Beyond Compare: http://www.scootersoftware.com/features.php

### Power

The meeting room has power. If you need to plug in more than one device, bring an extension cord or power strip that fits multiple plugs.

### Network

Bring your own network patch cable: at least 3 meters, preferably 5.

If you need to connect multiple devices: bring a network switch.

There is WiFi in the hotel, but quality varies.

# [Program](http://alt.dapug.dk/ws20102015.htm)

## Tuesday – TECH stuff

### Morning

#### 08:00 - Arrival and setup

#### 09:30 - Welcome to Jeroen

#### 09:40 - Demonstration and working with [MVVM](20151020-Caliburn), Spring4D, [Knockoff](20151020-KnockOff) fundamentals and Delphi Generics.

- Get familiar with the nice things that have been introduced in the Pascal language over the last decade, and how some open source libraries use that to make your programming a lot easier.
- Most of these are based on Generics, Interfaces, Loose Coupling, Inversion of Control and Dependency Injection.
- This is a way to push business logic out of your user interface into places where test is a lot easier

#### 10:50 - BREAK

#### 11:05 Demonstration and working with MVVM, Spring4D, Knockoff fundamentals and Delphi Generics - Continued.

- Continue and finish the morning session.

#### 12:00 - LUNCH

### Afternoon

#### 13:00 - [Continuous Integration using Continua CI & local command-line building techniques](20151020-Build-process-automation/Build-process-automation-Session.md)

- Especially for small teams it pays off automating as much of the dull work as possible.
- A dull part of the process often is compiling and building your program into something testable or shippable.

- This session is about that: working with Continua CI (free when you use it on a single build system, mine runs Windows 8) and old-school batch files. You learn about essentials of building either under your own account or on a different one.

- It also helps when switching machines: haven't we all had our main development machine crash leaving us in a state of panic.

#### 14:45 - COFFEE BREAK

#### 15:00 - [Data aware controls VCL](20151020-DataAwareControls) - data aware control controller

- We go back to old-school but very important VCL: most applications use VCL and databases.

- Based on some reusable techniques you will see how you can both make your database centric code easier as well as your user-interface cleaner while still using the familiar data ware control, datasource, dataset adagium.
- Two important parts are a data-aware control controller, and a dataset helper.
- As a side effect you will see how the data aware controls and data source are internally bound using data-links and learn about modularisation of your code.

#### 17:00 - Wrap up of Tuesday, with a message from [Flemming Jensen](https://www.linkedin.com/in/flemmingkoldingjensen), [Nohau](http://dk.nohau.se/).

### Evening - chance to look at the books Jeroen brought

#### 18:30 - Drinks before dinner in Tranquebar

#### 19:00 - DINNER

## Wednesday Day 2 - Software Quality stuff

### Morning

#### 9:00 – [FixInsight](20151021-FixInsight): static code analysis catching so much more than the compiler does.

- FixInsight is a static code analysis tool which catches code issues the compiler doesn't.
- Using it you will be amazed how much the compiler forgets to notice and how many issues your code has.
- How often have you forgotten a parameter to a Format expression? This is only one of the things FixInsight catches.
- You will get a FixInsight license that lasts until early November so you can let it run on your own code at the end of the block and ask questions on the why of certain things it catches.

#### 10:30 - COFFEE BREAK

#### 10:45 – [TestInsight](20151021-TestInsight): the IDE integration of unit testing on steroids

- Unit testing is a great way of keeping new bugs from entering a changing code base.  
But running them and keeping an eye on them can be tedious.
- Unless you integrate the tooling in the IDE and have it run automagically when you code.
- It is part of my motto "automate everything to make your life easier".
- You will see how much faster it becomes writing tests and how easy it is to still have them run in a build system like Continua CI.

#### 12:00 - LUNCH

### Afternoon

#### 13:00 – [Highlights of Software Quality](20151021-Software-Quality-the-Human-Factor)

- Code Complete
- Refactoring: improving the design of existing code
- Design Patterns: elements of re-usable object oriented software
- Some topics covered are how to essentials for writing good software, classic mistakes of writing bad software, the human factor in software development, reducing failure, emotions versus technique and processes.  
You will do some tasks helping you shedding some light on how people actually work
and cooperate.

#### 14:15 - COFFEE BREAK

#### 14:30 – Highlights of Software Quality Part 2

#### 16:00 - Wrapup and evaluation,

During the sessions I will try to demonstrate the tools I use on a regular base like version control
(I prefer DVCS like Git and Mercurial even for my one-man projects), AQTime performance profiling, Beyond Compare, ModelMaker Code Explorer and many many others.

I'm a keyboard person, so you will also learn lots and lots of shortcuts and of course about console commands.
