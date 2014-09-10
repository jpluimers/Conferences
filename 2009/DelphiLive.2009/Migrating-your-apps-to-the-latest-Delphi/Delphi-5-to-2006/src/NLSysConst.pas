{$i AlwaysInclude.inc}

unit NLSysConst;

{$T-} //##jpl: tijdelijk totdat we de code hebben opgeschoond

interface

implementation

uses
{$ifdef d7up}
  SysConst,
{$else}
  Consts,
{$endif d7up}
  ResourceUtils;

resourcestring
  SCannotCreateDir = 'Onmogelijk om de directory aan te maken';

procedure HookResources;
begin
  CopyResString(@NLSysConst.SCannotCreateDir              , @{$ifdef d7up}SysConst{$else}Consts{$endif d7up}.SCannotCreateDir              , True);
end;

procedure UnhookResources;
begin
  RestoreResString(@{$ifdef d7up}SysConst{$else}Consts{$endif d7up}.SCannotCreateDir);
end;

initialization
  HookResources;
finalization
  UnhookResources;
end.
