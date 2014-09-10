(* BOF *********************************************************************)

{
  The Project.inc defines in which state the project was delivered most recently.
  In this case this is Develop

  This file MUST either be in your .dpr directory or in the search path.
  It is easiest to have it in your .dpr directory.

  Do NOT use // comments here, as we need to be backwards compatible with Borland Pascal!!

  20070329 JPL Refactored structure: all project settings come from Project.inc
               Project.inc is being included twice, for two phases:
               - include_prolog: at the start of Defines.inc
               - include_epilog: at the end of Defines.inc
               Project.inc can define develop/test/ship,
               DefinesIncDoesMemorySettings and/or Korsakov
}

{ Project.inc may turn on these settings: }

{-- Stage (select only 1 entry) -------------------------------------------}
{$define develop}
{.define test}
{.define ship}

{-- Decide whether Project.inc or Defines.inc does the Memory Settings ----}
{.define DefinesIncDoesMemorySettings}

{-- Extra checking 16-bit apps only ---------------------------------------}
{.define Korsakov}          { test for heap leaks }

{ PROLOG - start ========================================================= }
{$ifdef include_prolog}
{ For the current project, there is no need to do anything in the prolog }
{$endif include_prolog}
{ PROLOG - finish ======================================================== }

(*
{ examples of things you could do here:
  1. Have include files for project groups
  2. Decide what kind of project (service, UI, console) you want to build
}
{$i ProjectGroup.inc}
{$define serviceApp}
{$ifndef serviceApp}
  {$define consoleApp}
{$endif serviceApp}
*)

{ EPILOG - start ========================================================= }
{$ifdef include_epilog}
{ When moving to a new Delphi version, you can temporarily disable warnings.
  For instance, in Delphi 2006, you might want to disable these warnings
  when starting your port: Symbol_Platform, Symbol_Deprecated, Unit_Platform
}
(*
{$warn Symbol_Platform off}
{$warn Symbol_Deprecated off}
{$warn Unit_Platform off}
*)
{$endif include_epilog}
{ EPILOG - finish ======================================================== }
