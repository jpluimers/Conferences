{ Deze file NOOIT rechtstreeks in een unit includen, maar altijd via Project.inc }

{ PROLOG - start ========================================================= }
{$ifdef nndefine_prolog}
  { Alle projecten: niets }
{$endif nndefine_prolog}
{ PROLOG - finish ======================================================== }

{ EPILOG - start ========================================================= }
{$ifdef nndefine_epilog}
  { Alle projecten: in de initiele migratie even alle warnings uit zetten
    die we later gaan fixen }
  {$ifdef d7up}
    {$warn Symbol_Platform off}
    {$warn Symbol_Deprecated off}
    {$warn Unit_Platform off}
  {$endif d7up}
{$endif nndefine_epilog}
{ EPILOG - finish ======================================================== }
