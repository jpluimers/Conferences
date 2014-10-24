# [Delphi Unit Testing](https://github.com/jpluimers/Conferences/blob/master/2014/20141023-ItDevCon-Itally-Verona-Unit-Testing/Delphi-Unit-Testing.md)

## Intro

Lets start with two questions

> How many of you develop new software every day.  
> How many of you maintain existing software every day.

Most of you maintain software.  
Which means you must optimize your development for change:

- software architecture is about change
- automating steps in the development process is about change
- good tooling is about change
- testing software is about change
- agile software development

We will focus on the last part here, in the context of Delphi.

> Don't you have better stuff to do than manually test stuff over and over again?

This is why you want to automate your tests.

In fact, this [goes back to the iterative nature](http://en.wikipedia.org/wiki/Agile_software_development#Overview) of Agile Programming (2001), Extreme Programming (1996), Scrum (1995), as far back as [the history of](http://en.wikipedia.org/wiki/Agile_software_development#History) Incremental Programming (1950s). 

The two types of tests used most often in software are Unit Tests and Integration Tests. Often they can use the same framework for testing, as their only difference is:

- unit tests are about 
- integrationt tests are about 

The flow of software maintenance:

        +------> Get problem ---------+
        |                             |
        |                             v
    Clean up                      Learn code
        ^                             |
        |                             |
        +----- Code solution <--------+

You see this eternal circle? That's what we are trapped in: no escapes (:

## Intermezzo

Great Delphi Unit Testing session as a RAD in Action live webinar was held in February 2014 by Nick Hodges.

- [Q&A log is at the Wiert.me blog](http://wiert.me/2014/02/12/qa-log-for-the-rad-in-action-webinar-unit-testing-in-delphi-featuring-nick-hodges/)
- [White Paper via Embarcadero site](https://www.embarcadero.com/rad-in-action/delphi-unit-testing) (funny thing, [de](https://www.embarcadero.com/de/rad-in-action/delphi-unit-testing), [fr](https://www.embarcadero.com/fr/rad-in-action/delphi-unit-testing) and [kr](https://www.embarcadero.com/kr/rad-in-action/delphi-unit-testing) work too).
- [1 hour Webinar video on YouTube](http://www.youtube.com/watch?v=xUUC15RbiaQ)
- [Webinar registration form](http://forms.embarcadero.com/DelphiUnitTesting2-12)

Existing DUnit documentation in the online help.

- [Unit testing overview](http://docwiki.embarcadero.com/RADStudio/en/Unit_Testing_Overview)
- [DUnit Overview](http://docwiki.embarcadero.com/RADStudio/XE5/en/DUnit_Overview)
- [Developing Tests](http://docwiki.embarcadero.com/RADStudio/XE5/en/Developing_Tests)
- [10 minute introduction video on YouTube by Mike Rozlog](http://www.youtube.com/watch?v=nm_yq9jYckc)

Bowling game kata in Delphi and DUnit

- [20 minute Video on YouTube](http://www.youtube.com/watch?v=RmjQZN6BtwQ)
- [code kata](http://en.wikipedia.org/wiki/Kata_(programming)) for which [many are based on TDD](http://blog.boyet.com/blog/blog/code-kata/)
- [Bowling game kata by Uncle Bob (*that's the **real Bob***) Martin](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata)
- [Chess game kata in Delphi and DUnit part 1](http://www.yanniel.info/2012/03/tdd-in-delphi-dunit-framework.html) and [part 2](http://www.yanniel.info/2012/12/refactoring-to-patterns-in-delphi.html)

My own introductory sessions on unit testing
- [45 minute ITDevCon 2012 YouTube video](http://www.youtube.com/watch?v=mqgdvxD0ubE)
- [ITDevCon 2012 slides](https://bitbucket.org/jeroenp/conferences/src/2012/ITDevCon-2012-Verona-Italy/20121026-Unit-Testing-with-Delphi)
- [EKON15 2011 slides](https://bitbucket.org/jeroenp/conferences/src/tip/2011/EKON15-Renaissance-Hotel-Düsseldorf/Delphi-XE2-Unit-Testing)

## Unit frameworks in Delphi

Two most important frameworks:

- [DUnit](http://dunit.sourceforge.net/): 
	- originally written by Juancarlo Añez based on JUnit, with help from Kent Beck (yes, the Extreme Programming one). 
	- Uses only classic Delphi language features (mainly classes, interfaces and inheritance). 
	- Uses `Check*` methods to assert results are expected.
	- Has a nice VCL GUI front-end.
	- A rudimentary [FMX front-end is in the Spring4D repository](https://bitbucket.org/sglienke/spring4d/src/develop/Tests/Source/dUnit/). 
	- Integrated in Delphi out-of-the-box since around Delphi 6.
	- Wizard originally based on [DUnitWizard](http://www.xpro.com.au/Freeware/DUnitWizard.htm). 
	- Is Open Source, currently on SourceForge.
    - [Several contributors](http://sourceforge.net/projects/dunit/).
- [DUnitX](https://github.com/VSoftTechnologies/DUnitX): 
	- originally written by [Vincent Parrett](https://plus.google.com/103070525516006807291/posts) of [FinalBuilder](http://www.finalbuilder.com/) (and [Continua CI](http://www.finalbuilder.com/continua-ci)) fame.
	- Heavily depends on new Delphi language features like Generics and Attributes.
	- Uses `Assert` class to assert results are expected.
	- Has a `DUnit` compatibility layer.
	- Direct support for NUnit XML, continuous integration, and many other nifty features.
	- Based on the DelphiMocks isolation framework.
	- [Wizard](https://github.com/jpluimers/DUnitX/tree/master/Expert) by Robert Love supports Delphi 2010-XE6.
	- Has a [G+ community](https://plus.google.com/communities/110602661860791972403).
	- Is Open Source on GitHub.
	- About a [dozen contributors](https://github.com/VSoftTechnologies/DUnitX/graphs/contributors).

Other frameworks and additions: <http://stackoverflow.com/questions/18291/unit-testing-in-delphi-how-are-you-doing-it>

## Unit tests always follow the same `[AAA](http://www.typemock.com/unit-test-patterns-for-netc#aaa)` pattern:

This is yet another [triple AAA](https://en.wikipedia.org/wiki/AAA) abbreviation:

- Arrange
- Act
- Assert

The above is easier to remember than how the DUnit test generator phrases them:

      // TODO: Setup method call parameters
      ReturnValue := FSysUtilsFormat.FormatDateTime(Format, DateTime, AFormatSettings);
      // TODO: Validate method results

## Unit tests aren't the only kinds of tests

![Planning/Feedback Loops in Extreme Programming](367px-Extreme_Programming.svg.png "Planning/Feedback Loops in Extreme Programming") ![Acceptance-, Integration-, Unit- and End-to-End-Tests](AcceptanceVsIntegrationTests-small.png "Acceptance-, Integration-, Unit- and End-to-End-Tests")

Images [WikiPedia: Extreme Programming](http://en.wikipedia.org/wiki/Extreme_programming) / [Jonas Bandi: Acceptance vs Integration Testing](http://blog.jonasbandi.net/2010/09/acceptance-vs-integration-tests.html)

## Demos

- [Delphi Unit Tests](https://bitbucket.org/NickHodges/delphi-unit-tests): repository with public unit tests covering library code shipping with Delphi. Ideal for QC reports.
- [Spring4D](https://bitbucket.org/sglienke/spring4d): A lot of this modern framework has tests.
- [DSharp](https://bitbucket.org/sglienke/dsharp): also from Stefan Glienke; has MVVM, so now you can test the non-visual part of your UI's View Model.
- [DUnitX](https://github.com/VSoftTechnologies/DUnitX): Unit testing with modern Delphi language features.
- [DelphiMocks](https://github.com/VSoftTechnologies/Delphi-Mocks): isolation framework. 
- [NickDemoCode](https://bitbucket.org/NickHodges/nickdemocode): many demos by Nick Hodges
- [BeSharp.net](https://bitbucket.org/jeroenp/besharp.net): various samples from Jeroen.

You can fork the repositories, like I did with [bitbucket.org/jeroenp/delphi-unit-tests](https://bitbucket.org/jeroenp/delphi-unit-tests) and [github.com/jpluimers/DUnitX.git](https://github.com/jpluimers/DUnitX).

- [Small fork contribution introduction](https://github.com/jpluimers/DUnitX/blob/master/CONTRIBUTING.md)

Dependencies between repositories are done by environment veriables like `DUnitX` which in Delphi are represented as `$(DUnit)`.  
Use Process Explorer to verify these are set correctly.

## Tools used

- Delphi
	- [GExperts](http://gexperts.org/) (mainly grep search)
	- [ModelMaker Code Explorer](http://www.modelmakertools.com/code-explorer/index.html) (Delphi refactoring made easy)
- Version control (all but SVN support [DVCS](http://wiert.me/2013/10/01/some-notes-and-links-on-dvcs-dynamic-version-control-systems/))
	- [SourceTree](http://www.sourcetreeapp.com/)
	- [git](http://git-scm.com/download/win)
	- [hg/Mercurial](http://mercurial.selenic.com/wiki/Download#Windows)
	- [svn](https://www.sliksvn.com/en/download) 
- General
	- SysInternals [Process Explorer](http://technet.microsoft.com/en-us/sysinternals/bb896653.aspx)

## Not covered yet

- [Code coverage](https://code.google.com/p/delphi-code-coverage/): still need to research this.
- Research if the VCL GUI of DUnit can be used in DUnitX somehow.
- How to get this MarkDown into a slideshow. [remarkjs.com](http://remarkjs.com/#1) or [biggie](http://www.macwright.org/biggie/) might work. Need to read [Casey Watts comparison on tooling](http://caseywatts.github.io/2012/12/12/markdown_to_slide_presentation/) and [this lifehacker post](http://lifehacker.com/biggie-creates-slides-with-markdown-in-minutes-656829887). (: