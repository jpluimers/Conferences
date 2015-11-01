# [FixInsight](http://sourceoddity.com/fixinsight/): static code analysis catching so much more than the compiler does.

[Köln, Germany, 20151102](http://web.archive.org/web/20151101152757/http://entwickler-konferenz.de/2015/de/sessions/improving-quality-your-code-fixinsight)

- Examples: <https://bitbucket.org/jeroenp/besharp.net>
- Slides: <http://github.com/jpluimers/Conferences>
- Blog: <http://wiert.me>

     FixInsight is a static code analysis tool which catches code issues the compiler doesn't.
     Using it you will be amazed how much the compiler forgets to notice and how many issues your code has.

     How often have you forgotten a parameter to a Format expression? This is only one of the things FixInsight catches.
     You will get a FixInsight license that lasts until early November so you can let it run on your own code at the end of the block and ask questions on the why of certain things it catches.

## Getting started

- [Download](http://sourceoddity.com/fixinsight/download.html): the file
http://sourceoddity.com/download/FixInsight_2015.10upd1_setup.exe (it got updated very recently).

- Install:
    1. Quit all your Delphi instances
    2. Run the installer
    3. Register the license

- License: lasts until 20151102. Get it from [Elena Hüls](https://www.xing.com/profile/Elena_Huels) or me, then use either of these steps to apply the license:
    1. Via the `FixInsight License Manager`:
        1. Click on the Windows `Start` button
        2. Click `Programs` -> `FixInsight -> `FixInsight License Manager`.
        3. In the `FixInsight Registration` dialog:
            1. In the menu, `Open License` and the license file.
            2. Click the `Apply License` button.
    2. Within Delphi
        1. Choose the `Help` menu
        2. Click on `About FixInsight`
        3. In the `About FixInsight` dialog (that initially shows `trial version`), click `Register`.
        4. In the `FixInsight Registration` dialog:
            1. In the menu, `Open License` and the license file.
            2. Click the `Apply License` button.
        5. Confirm the dialog that asks you to restart Delphi.
        6. Restart Delphi.

- [Docs](http://sourceoddity.com/fixinsight/doc.html): we will see most of them in the session[.](http://sourceoddity.com/video/CodeRageX-FixInsight.mp4)

The license until early November so you can play with it after the workshop.  
If you like it, use the coupon (ask [Elena Hüls](https://www.xing.com/profile/Elena_Huels) or me) to get a 20% discount when you [buy](http://sourceoddity.com/fixinsight/order.html) it.

## Why

Often a Delphi program compiles without errors, warnings or hints and is still wrong.

In addition to unit tests, static code analysis can also reveal many errors.

Just over a year old, FixInsight catches a lot of those.

This saves both time and improves your quality.

## How

FixInsight is a smart wrapper around the [DelphiAST](https://github.com/RomanYankovsky/DelphiAST) parser.

It parses about any Delphi language construct you can imagine. If it doesn't, report a bug (see below how).

Then it reports them in the standard Delphi messages pane, similar to what the compiler does.

## Example

https://bitbucket.org/jeroenp/besharp.net/src/tip/Native/Delphi/Apps/Console/FixInsightDemo/

## Supported Delphi versions

- Delphi 2006
- Delphi 2007
- Delphi 2009
- Delphi 2010
- Delphi XE
- Delphi XE2
- Delphi XE3
- Delphi XE4
- Delphi XE5
- Delphi XE6
- Delphi XE7
- Delphi XE8
- Delphi 10 Seattle

This means it supports both classic and modern ~~Delphi~~ Object Pascal language constructs in addition to non-Unicode and Unicode Delphi versions.

## Reporting issues

Like any software, FixInsight can have bugs.

To report bugs:

0. Within Delphi
1. Choose the `Help` menu
2. Click on `About FixInsight`
3. In the `About FixInsight` dialog enable the click `Debug Mode` checkbox.
4. Run your FixInsight as normal.
5. Copy the `*.filog` file in your project folder and post it as feed back to http://sourceoddity.com/

## Time to play

1. Run it on your own source base.
2. Make a top-3 of the most surprising issues.
3. Volunteer to show them to the rest of the people.

## After the Conference

Watch the [CodeRageX-FixInsight video on YouTube](https://www.youtube.com/watch?v=7TboChCHSCY).
