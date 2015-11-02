# 19. EKON 2015

> The conference for Delphi & More

[Köln, Germany, 20151102-20151104](http://web.archive.org/web/20150912121134/http://entwickler-konferenz.de/2015/de)

[Hilton Hotel, Köln](https://www.google.com/search?q=hilton+cologne)  
Marzellenstraße 13-17
50668 Köln
Germany
+49 221 130710

## Chance to look at the books Jeroen brought

I did bring quite a few software development related books.

Feel free to browse through them during the day. Be sure to return them before the conference ends.

## After the Workshop

- Examples: <https://bitbucket.org/jeroenp/besharp.net>
- Slides: <http://github.com/jpluimers/Conferences>
- Blog: <http://wiert.me>

## Setup, Power, Network

Be early to setup at around 08:00. The workshop begins at about 09:30.

Network access code: `softwareandsupport` valid for 24 hours each time you connect with it.

Bring a good mood, we're going to have fun!

### Setup

It makes it a lot easier if you have this installed on your machines:

- A Delphi version that is XE or higher
- [Git for Windows](https://github.com/git-for-windows/git/releases/latest) as the [Conferences repository](https://github.com/jpluimers/Conferences) is using Git.
- [Mercurial for Windows](https://www.mercurial-scm.org/wiki/Download) as the Examples repository is using Mercurial.
- [SourceTree for Windows](https://www.sourcetreeapp.com/) which makes it easier to visually work with Mercurial and Git repositories
- A good text editor (I like [Notepad++](https://notepad-plus-plus.org/) a lot)
- (Delphi) productivity tools like [Beyond Compare](http://www.scootersoftware.com), [GExperts](http://www.gexperts.org/), [ModelMaker Code Explorer](http://www.modelmakertools.com/code-explorer/index.html), [FixInsight](http://sourceoddity.com/fixinsight/), [TestInsight](https://bitbucket.org/sglienke/testinsight/wiki/Home) etc.

#### Discounts

Attendees can get a 20% discount for the next procucts; ask Jens or me for the coupon.

- [Beyond Compare](http://www.scootersoftware.com); regular prices: single platform standard/pro: [USD 30/50](http://www.scootersoftware.com/features.php?zz=pricing); multi-platform standard/pro [USD 48/80](http://www.scootersoftware.com/features.php?zz=pricing).
- [ModelMaker Code Explorer](http://www.modelmakertools.com/code-explorer/index.html); regular price [EUR 99/199/399/749](http://www.modelmakertools.com/order/newlicenses.html) for 1-user/4-user/10-user/site license.
- [FixInsight](http://sourceoddity.com/fixinsight/); regular price [USD 127](http://sourceoddity.com/fixinsight/order.html).

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

The meeting rooms have power. If you need to plug in more than one device, bring an extension cord or power strip that fits multiple plugs.

### Network

There is WiFi in the hotel, but quality varies. In the meeting rooms, it's free.

# [Program (Zeitplaner)](http://web.archive.org/web/20151101153224/http://entwickler-konferenz.de/2015/de/zeitplaner) as  [PDF](http://web.archive.org/web/20151101153333/http://entwickler-konferenz.de/2015/sites/default/files/ekon_zeitplaner_pdf.pdf).

## Monday – 14:00-15:15: [Improving the quality of your code with FixInsight](20151102-FixInsight): static code analysis catching so much more than the compiler does.

- FixInsight is a static code analysis tool which catches code issues the compiler doesn't.
- Using it you will be amazed how much the compiler forgets to notice and how many issues your code has.
- How often have you forgotten a parameter to a Format expression? This is only one of the things FixInsight catches.
- You will get a FixInsight license that lasts until early November so you can let it run on your own code at the end of the block and ask questions on the why of certain things it catches.

## Tuesday – 10:30-11:45: [High Performance Delphi Apps](20151103-AQTime): Demonstrates AQTime.

http://entwickler-konferenz.de/2015/de/sessions/high-performance-delphi-apps
http://web.archive.org/web/20151101153952/http://entwickler-konferenz.de/2015/de/sessions/high-performance-delphi-apps

- Demonstrates how a high performance stock quote processing system got improved both in capacity (it can process > 20-thousand quotes per second) and concurrency.

## Tuesday - 14:15-15:30: [How to partition your applications using Model View ViewModel](20151102-MVVM): demonstrates Caliburn for Delphi and Knockoff

- Get familiar with the nice things that have been introduced in the Pascal language over the last decade, and how some open source libraries use that to make your programming a lot easier.
- Most of these are based on Generics, Interfaces, Loose Coupling, Inversion of Control and Dependency Injection.
- This is a way to push business logic out of your user interface into places where test is a lot easier

## Wednesday - 13:30-17:00: [Improving Software Quality](20151104-Software-Quality-the-Human-Factor) - we are all humans.

- Code Complete
- Refactoring: improving the design of existing code
- Design Patterns: elements of re-usable object oriented software
- Some topics covered are how to essentials for writing good software, classic mistakes of writing bad software, the human factor in software development, reducing failure, emotions versus technique and processes.  
You will do some tasks helping you shedding some light on how people actually work
and cooperate.

## About me and what I show

During the sessions I will try to demonstrate the tools I use on a regular base like version control
(I prefer DVCS like Git and Mercurial even for my one-man projects), AQTime performance profiling, Beyond Compare, ModelMaker Code Explorer and many many others.

I'm a keyboard person, so you will also learn lots and lots of shortcuts and of course about console commands.
