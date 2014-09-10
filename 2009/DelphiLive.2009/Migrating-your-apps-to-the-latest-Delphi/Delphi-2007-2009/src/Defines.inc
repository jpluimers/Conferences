{ Conditional definines fo NN units
  ---------------------------------
  You can change defines in the top part. The bottom part will set
  some directives and add global defines depending on the compiler and
  settings in the top part.

  19980923 JWP initial version for Delphi and Borland Pascal
  19990306 JWP C++ Builder 4
  19990830 JWP Delphi 5.0
  20050919 JWP Delphi 7.0
  20060227 JWP Delphi 2006 (10.0)
  20060313 JPL Monolithic
  20060320 JPL wm_CopyData
  20070322 JPL Memory alignment of 4 bytes in 32bit wereld
  20070329 JPL Refactored structure: all project settings come from Project.inc
               Project.inc is being included twice, for two phases:
               - include_prolog: at the start of Defines.inc
               - include_epilog: at the end of Defines.inc
               Project.inc can define develop/test/ship,
               DefinesIncDoesMemorySettings and/or Korsakov
  20081018 JWP Delphi 2009 (12.0), RAD Studio and intermediate versions

  Do NOT use // comments here, as we need to be backwards compatible with Borland Pascal!!
}

{ Project.inc may turn on these settings: }

{-- Stage (select only 1 entry) -------------------------------------------}
{.define develop}
{.define test}
{.define ship}

{-- Decide whether Project.inc or Defines.inc does the Memory Settings ----}
{.define DefinesIncDoesMemorySettings}

{-- Extra checking 16-bit apps only ---------------------------------------}
{.define Korsakov}          { test for heap leaks }

(**************************************************************************)
(******************** Don't change below this line ************************)
(**************************************************************************)

{ PROLOG - start ========================================================= }

{$define include_prolog}
{$i Project.inc}

{ PROLOG - finish ======================================================== }

{-- Memory settings -------------------------------------------------------}
{$ifdef DefinesIncDoesMemorySettings}
  {$ifdef MSDOS}
    {$M 16384,0,655360}       { real mode stack,heapmin,heapmax size}
  {$endif MSDOS}

  {$ifdef DPMI}
    {$M 16384}                { DPMI protected mode stack size }
  {$endif DPMI}

  {$ifdef windows}
    {$M 8192,8192}            { 16-bit windows mode stack,local heap size }
  {$endif windows}

  {$ifdef win32}
    {$M 16384,1048576}        { 32-bit windows mode min stacksize, max stacksize }
  {$endif win32}
{$endif NNDefine_Memory_Settings}

(* Create additional defines *)

{$ifdef DPMI}
  {$define protected}
{$endif DPMI}

{$ifdef windows}
  {$define protected}
{$endif windows}


{$ifdef DPMI}
  { $define dynamic}
{$endif DPMI}


{$ifdef ver70} { Turbo Pascal 7 & Borland Pascal 7 }
  {$define 16bit}
  {$define bp7}
  {$define tv}
  {$define owl}
{$endif ver70}

{$ifdef ver80} { Delphi 1 }
  {$define 16bit}
  {$define d1}
  {$define vcl}
{$endif ver80}

{$ifdef ver90} { Delphi 2 }
  {$define 32bit}
  {$define d2}
  {$define vcl}
{$endif ver90}

{$ifdef ver93} { C++ Builder }
  {$define 32bit}
  {$define c1}
  {$define vcl}
{$endif ver90}

{$ifdef ver100} { Delphi 3 }
  {$define 32bit}
  {$define d3}
  {$define vcl}
{$endif ver100}

{$ifdef ver110} { C++ Builder 3 - there was never a C++ Builder 2}
  {$define 32bit}
  {$define c3}
  {$define vcl}
{$endif ver110}

{$ifdef ver120} { Delphi 4 }
  {$define 32bit}
  {$define d4}
  {$define vcl}
{$endif ver120}

{$ifdef ver125} { C++ Builder 4 }
  {$define 32bit}
  {$define c4}
  {$define vcl}
{$endif ver125}

{$ifdef ver130} { Delphi 5 / C++ Builder 5 }
  {$define 32bit}
  {$ifdef BCB}
    {$define c5}
  {$else}
    {$define d5}
  {$endif BCB}
  {$define vcl}
{$endif ver130}

{$ifdef ver140} { Delphi 6 / C++ Builder 6 }
  {$define 32bit}
  {$ifdef BCB}
    {$define c6}
  {$else}
    {$define d6}
  {$endif BCB}
  {$define vcl}
{$endif ver130}

{$ifdef ver150} { Delphi 7 }
  {$define 32bit}
  {$define d7}
  {$define vcl}
{$endif ver150}

{$ifdef ver160} { Delphi 8 (.net only) }
  {$define d8}
  {$define vcl}
{$endif ver150}

{$ifdef ver170} { Delphi 2005 (9) }
  {$define 32bit}
  {$define d9}
  {$define vcl}
{$endif ver170}

{$ifdef ver180} { Delphi 2006 (10) / C++ Builder 2006 }
  {$define 32bit}
  {$ifdef BCB}
    {$define c10}
  {$else}
    {$define d10}
  {$endif BCB}
  {$define vcl}
{$endif ver180}

{$ifdef ver185} { Delphi 2007 (11) }
  {$define 32bit}
  {$define d11}
  {$define vcl}
{$endif ver180}

{$ifdef ver190} { BDS 2007 .net personality (11) }
  {$define d11}
  {$define vcl}
{$endif ver185}

{$ifdef ver200} { Delphi 2009 (12) / C++ Builder 2009 }
  {$define 32bit}
  {$ifdef BCB}
    {$define c12}
  {$else}
    {$define d12}
  {$endif BCB}
  {$define vcl}
{$endif ver200}


(* base versions *)

{$ifdef d12} {$define d12up} {$endif d12}
{$ifdef d11} {$define d11up} {$endif d11}
{$ifdef d10} {$define d10up} {$endif d10}
{$ifdef d9}  {$define d9up}  {$endif d9}
{$ifdef d8}  {$define d8up}  {$endif d8}
{$ifdef d7}  {$define d7up}  {$endif d7}
{$ifdef d6}  {$define d6up}  {$endif d6}
{$ifdef d5}  {$define d5up}  {$endif d5}
{$ifdef d4}  {$define d4up}  {$endif d4}
{$ifdef d3}  {$define d3up}  {$endif d3}
{$ifdef d2}  {$define d2up}  {$endif d2}
{$ifdef d1}  {$define d1up}  {$endif d1}
{$ifdef c12} {$define c12up} {$endif c12}
{$ifdef c10} {$define c10up} {$endif c10}
{$ifdef c6}  {$define c6up}  {$endif c6}
{$ifdef c5}  {$define c5up}  {$endif c5}
{$ifdef c4}  {$define c4up}  {$endif c4}
{$ifdef c3}  {$define c3up}  {$endif c3}
{.ifdef c2} { There is no C++ Builder 2.0 }
  {.define c2up}
{.endif c2}
{$ifdef c1}  {$define c1up}  {$endif c1}
{$ifdef bp7}  {$define bp7up}  (* tp6up, tp55up, tp50up, tp40up *) {$endif bp7}

(* back versions - C++ Builder *)

{$ifdef c12up} {$define c10up} {$define d12up} {$endif c12up}
{$ifdef c10up} {$define c6up}  {$define d10up} {$endif c10up}
{$ifdef c6up}  {$define c5up}  {$define d6up}  {$endif c6up}
{$ifdef c5up}  {$define c4up}  {$define d5up}  {$endif c5up}
{$ifdef c4up}  {$define c3up}  {$define d4up}  {$endif c4up}
{$ifdef c3up}  {$define c1up}  {$define d3up}  {$endif c3up}
{.ifdef c2up} { There is no C++ Builder 2.0 }
  {.define c1up}
{.endif c2up}
{$ifdef c1up}  {$define d2up}  {$endif c1up}

(* back versions - Delphi *)

{$ifdef d12up} {$define d11up} {$endif d12up}
{$ifdef d11up} {$define d10up} {$endif d11up}
{$ifdef d10up} {$define d9up}  {$endif d10up}
{$ifdef d9up}  {$define d8up}  {$endif d9up}
{$ifdef d8up}  {$define d7up}  {$endif d8up}
{$ifdef d7up}  {$define d6up}  {$endif d7up}
{$ifdef d6up}  {$define d5up}  {$endif d6up}
{$ifdef d5up}  {$define d4up}  {$endif d5up}
{$ifdef d4up}  {$define d3up}  {$endif d4up}
{$ifdef d3up}  {$define d2up}  {$endif d3up}
{$ifdef d2up}  {$define d1up}  {$endif d2up}


{-- Force Set/Get method to be non-virtual ------------------------------------}
{$define DSEG}

{-- Determine of run-time settings can be changed -----------------------------}
{$define ForceRunTimeSettings}

{-- Comments regarding OPRO --}
{  if the conditional define OPro12 is defined, then this files is included
   in one of the OPRO units. OPRO handles some of the directives by itself
   (see list below). We should not tamper with these as it results in unwanted
   behaviour.

   Directives handled by OPRO:
       $A, $B, $F, $I, $O, $R, $S, $V
}

{-- Debugging settings ----------------------------------------------------}
  {$D+}               { Enables the generation of debug information }
  {$L+}               { Enables the generation of local symbol information }
  {$Y+}               { Enables generation of symbol reference information }

{-- Syntax settings -------------------------------------------------------}
  {$T+}               { Type-check pointers using the @operator }
{$ifndef OPro12}
  {$V+}               { Type-check the formal and actual string parameters }
{$endif OPro12}
  {$X+}               { Enables Turbo Pascal's extended syntax }

{-- Standaard run-time settings -------------------------------------------}
{$ifdef ForceRunTimeSettings}
  {$ifndef OPro12}
    {$ifdef d7up}
      {$A4}             { dword-align alles }
    {$else}
      {$A+}             { variables and typed constants larger than 1 byte
                          are aligned on a machine-word boundary }
    {$endif d7up}
    {$B-}               { short-circuit boolean-expression evaluation }
  {$endif  OPro12}

  {$ifdef coprocessor}
    {$E+}               { Enables linking with an 80x87-emulating run-time library }
  {$else}
    {$E-}               { Disables linking with an 80x87-emulating run-time library }
  {$endif coprocessor}

  {$ifndef OPro12}
    {$F+}               { Procedures and functions always use the FAR call model. }
  {$endif  OPro12}

  {$ifdef protected}
    {$G+}               { Uses 80286 instructions to improve code generation. }
  {$else}
  {$ifdef 16-bit}
    {$G-}               { Only generic 8086 instructions are generated. }
  {$endif 16-bit}
  {$endif protected}

  {$ifndef OPro12}
    {$I+}               { Enables code that checks the result of a call to an I/O procedure. }
  {$endif  OPro12}

  {$ifdef coprocessor}
    {$N+}               { Perform all real-type calculations in hardware }
  {$else}
    {$N-}               { Perform all real-type calculations in software }
  {$endif coprocessor}

  {$ifndef OPro12}
    {$ifdef MSDOS}
      {$O+}             { Enables overlay code generation }
    {$endif MSDOS}
  {$endif  OPro12}

    {$P-}               { Disables Open String Parameters }

  {$ifndef OPro12}
    {$S+}               { Enables stack-overflow checking code }
  {$endif  OPro12}
{$endif ForceRunTimeSettings}

{-- develop run-time settings -------------------------------------------}
{$ifdef ForceRunTimeSettings}
  {$ifdef develop}
    {$Q+}
    {$ifndef OPro12}
      {$R+}
    {$endif OPro12}
  {$endif develop}
{$endif ForceRunTimeSettings}

{-- test run-time settings ------------------------------------------}
{$ifdef ForceRunTimeSettings}
  {$ifdef test}
    {$Q+}
    {$ifndef OPro12}
      {$R+}
    {$endif OPro12}
  {$endif test}
{$endif ForceRunTimeSettings}

{-- ship run-time settings -------------------------------------------}
{$ifdef ForceRunTimeSettings}
  {$ifdef ship}
    {$Q-}
    {$ifndef OPro12}
      {$R-}
    {$endif OPro12}
    {$warn symbol_deprecated off}
    {$warn symbol_platform off}
    {$warn unit_platform off}
  {$endif ship}
{$endif ForceRunTimeSettings}


(* Test for development stage *)

{$ifdef develop}
  {$ifdef test}
    {$ifdef d6up}
      {$message fatal 'It is not allowed to combine stage directives develop and test'}
    {$else}
      It is not allowed to combine stage directives develop and test
    {$endif d6up}
  {$endif test}
  {$ifdef ship}
    {$ifdef d6up}
      {$message fatal 'It is not allowed to combine stage directives develop and ship'}
    {$else}
      It is not allowed to combine stage directives develop and ship
    {$endif d6up}
  {$endif ship}
{$endif develop}

{$ifdef ship}
  {$ifdef test}
    {$ifdef d6up}
      {$message fatal 'It is not allowed to combine stage directives ship and test'}
    {$else}
      It is not allowed to combine stage directives ship and test
    {$endif d6up}
  {$endif test}
  {$ifdef Korsakov}
    It is not allowed to combine stage directive ship with Korsakov
  {$endif Korsakov}
{$endif ship}

{$ifndef develop}
  {$ifndef ship}
    {$ifndef test}
      {$ifdef d6up}
        {$message fatal 'One of the stage defines develop, ship or test must be active'}
      {$else}
        One of the stage defines develop, ship or test must be active
      {$endif d6up}
    {$endif test}
  {$endif ship}
{$endif develop}


(* Test for development target *)

{$ifdef MSDOS}
  {$ifdef DPMI}
    {$ifdef d6up}
      {$message fatal 'Combining target directives MSDOS and DPMI is not allowed'}
    {$else}
      Combining target directives MSDOS and DPMI is not allowed
    {$endif d6up}
  {$endif DPMI}
  {$ifdef windows}
    {$ifdef d6up}
      {$message fatal 'Combining target directives MSDOS and windows is not allowed'}
    {$else}
      Combining target directives MSDOS and windows is not allowed
    {$endif d6up}
  {$endif windows}
  {$ifdef win32}
    {$ifdef d6up}
      {$message fatal 'Combining target directives MSDOS and win32 is not allowed'}
    {$else}
      Combining target directives MSDOS and win32 is not allowed
    {$endif d6up}
  {$endif win32}
{$endif MSDOS}

{$ifdef DPMI}
  {$ifdef windows}
    {$ifdef d6up}
      {$message fatal 'Combining target directives DPMI and windows is not allowed'}
    {$else}
      Combining target directives DPMI and windows is not allowed
    {$endif d6up}
  {$endif windows}
  {$ifdef win32}
    {$ifdef d6up}
      {$message fatal 'Combining target directives DPMI and win32 is not allowed'}
    {$else}
      Combining target directives DPMI and win32 is not allowed
    {$endif d6up}
  {$endif win32}
{$endif DPMI}

{$ifdef windows}
  {$ifdef win32}
    {$ifdef d6up}
      {$message fatal 'Combining target directives windows and win32 is not allowed'}
    {$else}
      Combining target directives windows and win32 is not allowed
    {$endif d6up}
  {$endif win32}
{$endif windows}

{$ifndef MSDOS}
  {$ifndef DPMI}
    {$ifndef windows}
      {$ifndef win32}
        {$ifdef d6up}
          {$message fatal 'One of the target defines MSDOS, DPMI, windows or win32 must be active'}
        {$else}
          One of the target defines MSDOS, DPMI, windows or win32 must be active
        {$endif d6up}
      {$endif win32}
    {$endif windows}
  {$endif DPMI}
{$endif MSDOS}

{ EPILOG - start ========================================================= }

{$undef include_prolog}
{$define include_epilog}
{$i Project.inc}
{$undef include_epilog}

{ EPILOG - finish ======================================================== }
