{ De Project.inc geeft aan in welke state deze het laatst is opgeleverd.
  In dit geval dus Develop }

{ Project.inc mag deze dingen aanzetten:
  develop,test, ship (1 van deze drie)
  hicApp, serviceApp (1 van deze twee)
  FastMM (memory manager selectie) }

{ PROLOG - start ============================================================= }
{$ifdef nndefine_prolog}

  {-- Stage (select only 1 entry) -------------------------------------------- }
  {$define develop}
  {.define test}
  {.define ship}

  {-- Application Type (select only 1 entry) --------------------------------- }
  {$define hicApp}
  {.define serviceApp}

  {-- Memory Manager --------------------------------------------------------- }
  {.define FastMM} { hier moet je je .dpr of main project unit op aanpassen! }
  
{$endif nndefine_prolog}
{ PROLOG - finish ============================================================ }


{ Eventueel een overkoepelende ProjectGroup.inc of andere overkoepelende
  include file: }
{.i ProjectGroup.inc}


{ EPILOG - start ============================================================= }
{$ifdef nndefine_epilog}
  { initieel in de de migratie:
    in de epilog wat warnings off die we later gaan fixen }
  {$ifdef d7up}
    {$warn Symbol_Platform off}
    {$warn Symbol_Deprecated off}
    {$warn Unit_Platform off}
  {$endif d7up}
{$endif nndefine_epilog}
{ EPILOG - finish ============================================================ }
