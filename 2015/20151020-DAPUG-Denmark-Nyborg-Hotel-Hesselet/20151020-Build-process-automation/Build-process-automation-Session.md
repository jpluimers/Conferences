# Continuous Integration using [Continua CI](https://www.finalbuilder.com/continua-ci) & local command-line building techniques

[Nyborg, Denmark, 20151020](http://www.dapug.dk/2015/08/workshop-20.html)

- Examples: <https://bitbucket.org/jeroenp/besharp.net>
- Slides: <http://github.com/jpluimers/Conferences>
- Blog: <http://wiert.me>

    - Especially for small teams it pays off automating as much of the dull work as possible.
    - A dull part of the process often is compiling and building your program into something testable or shippable.

    - This session is about that: working with Continua CI (free when you use it on a single build system, mine runs Windows 8) and old-school batch files. You learn about essentials of building either under your own account or on a different one.

    - It also helps when switching machines: haven't we all had our main development machine crash leaving us in a state of panic.

Two parts:

1. [Building Locally from the Console](Building-Locally-from-the-Console.md): is about building from the command-line in general.  
  (by building from the command-line you take the IDE out of the equation)

2. [Continua CI](Continua-CI.md): about building using a continuous integration system.  
  (this one is free for 1 local agent which suffices for a lot of cases)
