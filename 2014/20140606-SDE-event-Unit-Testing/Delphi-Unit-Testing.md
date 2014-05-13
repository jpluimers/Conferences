# Delphi Unit Testing

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

