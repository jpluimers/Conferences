{$i AlwaysInclude.inc}

unit NLRTLConsts;

{$T-} //##jpl: tijdelijk totdat we de code hebben opgeschoond

interface

implementation

uses
{$ifdef d7up}
  RTLConsts,
{$else}
  Consts,
{$endif d7up}
  ResourceUtils;

resourcestring
  SAssignError = 'Kan een %s niet toekennen aan een %s';
  SFCreateError = 'Bestand %s kan niet aangemaakt worden';
  SFOpenError = 'Bestand %s kan niet geopend worden';
  SReadError = 'Stream leesfout';
  SWriteError = 'Stream schrijffout';
  SMemoryStreamError = 'Onvoldoende geheugen bij uitpakken memory stream';
  SClassNotFound = 'Class %s niet gevonden';
  SResNotFound = 'Resource %s niet gevonden';
  SListIndexError = 'List index buiten de toegestane grenzen (%d)';
  SSortedListError = 'Bewerking niet toegestaan op gesorteerde string lists';
  SDuplicateString = 'String list accepteert geen duplikaten';
  SDuplicateName = 'Een component genaamd %s bestaat reeds';
  SInvalidName = '''''%s'''' is geen geldige component naam';
  SDuplicateClass = 'Een class genaamd %s bestaat reeds';
  SNoComSupport = '%s is niet geregistreerd als een COM class';
  SInvalidInteger = '''''%s'''' is geen geldige integer waarde';
  SLineTooLong = 'Regel te lang';
  SListCapacityError = 'List capaciteit buiten de toegestane grenzen (%d)';
  SListCountError = 'List teller buiten de toegestane grenzen (%d)';
  SInvalidPropertyValue = 'Ongeldige property waarde';
  SInvalidPropertyPath = 'Ongeldig property pad';
  SUnknownProperty = 'Property bestaat niet';
  SReadOnlyProperty = 'Property is alleen lezen';
  SPropertyException = 'Fout bij het lezen van %s.%s: %s';
  SAncestorNotFound = 'Ancestor van ''%s'' niet gevonden';
  SRegisterError = 'Ongeldige component registratie';
  SParseError = '%s op regel %d';
  SIdentifierExpected = 'Identifier verwacht';
  SStringExpected = 'String verwacht';
  SNumberExpected = 'Number verwacht';
  SCharExpected = '''''%s'''' verwacht';
  SSymbolExpected = '%s verwacht';
  SInvalidString = 'Ongeldige string konstante';
  SInvalidProperty = 'Ongeldige property waarde';
  SInvalidBinary = 'Ongeldige binaire waarde';
  STimeEncodeError = 'Ongeldige parameter bij tijd omzetting';
  SInvalidDate = '''''%s'''' is geen geldige datum';
  SInvalidTime = '''''%s'''' is geen geldige tijd';
  SInvalidDateTime = '''''%s'''' is geen geldige datum en tijd';
  SInvalidFileName = 'Ongeldige bestandsnaam - %s';
  SRegCreateFailed = 'Fout bij het aanmaken van key %s';
  SRegSetDataFailed = 'Fout bij het toewijzen van data aan ''%s''';
  SRegGetDataFailed = 'Fout bij het ophalen van data van ''%s''';

procedure HookResources;
begin
  CopyResString(@NLRTLConsts.SAssignError                  , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SAssignError                  , True);
  CopyResString(@NLRTLConsts.SFCreateError                 , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SFCreateError                 , True);
  CopyResString(@NLRTLConsts.SFOpenError                   , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SFOpenError                   , True);
  CopyResString(@NLRTLConsts.SReadError                    , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SReadError                    , True);
  CopyResString(@NLRTLConsts.SWriteError                   , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SWriteError                   , True);
  CopyResString(@NLRTLConsts.SMemoryStreamError            , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SMemoryStreamError            , True);
  CopyResString(@NLRTLConsts.SClassNotFound                , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SClassNotFound                , True);
  CopyResString(@NLRTLConsts.SResNotFound                  , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SResNotFound                  , True);
  CopyResString(@NLRTLConsts.SListIndexError               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SListIndexError               , True);
  CopyResString(@NLRTLConsts.SSortedListError              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SSortedListError              , True);
  CopyResString(@NLRTLConsts.SDuplicateString              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SDuplicateString              , True);
  CopyResString(@NLRTLConsts.SDuplicateName                , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SDuplicateName                , True);
  CopyResString(@NLRTLConsts.SInvalidName                  , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidName                  , True);
  CopyResString(@NLRTLConsts.SDuplicateClass               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SDuplicateClass               , True);
  CopyResString(@NLRTLConsts.SNoComSupport                 , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SNoComSupport                 , True);
  CopyResString(@NLRTLConsts.SInvalidInteger               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidInteger               , True);
  CopyResString(@NLRTLConsts.SLineTooLong                  , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SLineTooLong                  , True);
  CopyResString(@NLRTLConsts.SListCapacityError            , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SListCapacityError            , True);
  CopyResString(@NLRTLConsts.SListCountError               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SListCountError               , True);
  CopyResString(@NLRTLConsts.SInvalidPropertyValue         , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidPropertyValue         , True);
  CopyResString(@NLRTLConsts.SInvalidPropertyPath          , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidPropertyPath          , True);
  CopyResString(@NLRTLConsts.SUnknownProperty              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SUnknownProperty              , True);
  CopyResString(@NLRTLConsts.SReadOnlyProperty             , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SReadOnlyProperty             , True);
  CopyResString(@NLRTLConsts.SPropertyException            , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SPropertyException            , True);
  CopyResString(@NLRTLConsts.SAncestorNotFound             , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SAncestorNotFound             , True);
  CopyResString(@NLRTLConsts.SRegisterError                , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegisterError                , True);
  CopyResString(@NLRTLConsts.SParseError                   , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SParseError                   , True);
  CopyResString(@NLRTLConsts.SIdentifierExpected           , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SIdentifierExpected           , True);
  CopyResString(@NLRTLConsts.SStringExpected               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SStringExpected               , True);
  CopyResString(@NLRTLConsts.SNumberExpected               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SNumberExpected               , True);
  CopyResString(@NLRTLConsts.SCharExpected                 , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SCharExpected                 , True);
  CopyResString(@NLRTLConsts.SSymbolExpected               , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SSymbolExpected               , True);
  CopyResString(@NLRTLConsts.SInvalidString                , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidString                , True);
  CopyResString(@NLRTLConsts.SInvalidProperty              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidProperty              , True);
  CopyResString(@NLRTLConsts.SInvalidBinary                , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidBinary                , True);
  CopyResString(@NLRTLConsts.STimeEncodeError              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.STimeEncodeError              , True);
  CopyResString(@NLRTLConsts.SInvalidDate                  , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidDate                  , True);
  CopyResString(@NLRTLConsts.SInvalidTime                  , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidTime                  , True);
  CopyResString(@NLRTLConsts.SInvalidDateTime              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidDateTime              , True);
  CopyResString(@NLRTLConsts.SInvalidFileName              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidFileName              , True);
  CopyResString(@NLRTLConsts.SRegCreateFailed              , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegCreateFailed              , True);
  CopyResString(@NLRTLConsts.SRegSetDataFailed             , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegSetDataFailed             , True);
  CopyResString(@NLRTLConsts.SRegGetDataFailed             , @{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegGetDataFailed             , True);
end;

procedure UnhookResources;
begin
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SAssignError                  );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SFCreateError                 );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SFOpenError                   );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SReadError                    );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SWriteError                   );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SMemoryStreamError            );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SClassNotFound                );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SResNotFound                  );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SListIndexError               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SSortedListError              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SDuplicateString              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SDuplicateName                );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidName                  );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SDuplicateClass               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SNoComSupport                 );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidInteger               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SLineTooLong                  );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SListCapacityError            );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SListCountError               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidPropertyValue         );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidPropertyPath          );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SUnknownProperty              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SReadOnlyProperty             );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SPropertyException            );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SAncestorNotFound             );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegisterError                );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SParseError                   );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SIdentifierExpected           );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SStringExpected               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SNumberExpected               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SCharExpected                 );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SSymbolExpected               );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidString                );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidProperty              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidBinary                );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.STimeEncodeError              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidDate                  );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidTime                  );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidDateTime              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SInvalidFileName              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegCreateFailed              );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegSetDataFailed             );
  RestoreResString(@{$ifdef d7up}RTLConsts{$else}Consts{$endif d7up}.SRegGetDataFailed             );
end;

initialization
  HookResources;
finalization
  UnhookResources;
(*
//##jpl: D5 untranslated
RTLConsts.SDuplicateItem - untranslated: English = "List does not allow duplicates ($0%x)"
RTLConsts.SInvalidActionCreation - untranslated: English = "Invalid action creation"
RTLConsts.SInvalidActionEnumeration - untranslated: English = "Invalid action enumeration"
RTLConsts.SInvalidActionRegistration - untranslated: English = "Invalid action registration"
RTLConsts.SInvalidActionUnregistration - untranslated: English = "Invalid action unregistration"
RTLConsts.SInvalidMask - untranslated: English = "'%s' is an invalid mask at (%d)"
RTLConsts.SInvalidPropertyElement - untranslated: English = "Invalid property element: %s"
RTLConsts.SInvalidPropertyType - untranslated: English = "Invalid property type: %s"
RTLConsts.sWindowsSocketError - untranslated: English = "Windows socket error: %s (%d), on API '%s'"
RTLConsts.sAsyncSocketError - untranslated: English = "Asynchronous socket error %d"
RTLConsts.sNoAddress - untranslated: English = "No address specified"
RTLConsts.sCannotListenOnOpen - untranslated: English = "Can't listen on an open socket"
RTLConsts.sCannotCreateSocket - untranslated: English = "Can't create new socket"
RTLConsts.sSocketAlreadyOpen - untranslated: English = "Socket already open"
RTLConsts.sCantChangeWhileActive - untranslated: English = "Can't change value while socket is active"
RTLConsts.sSocketMustBeBlocking - untranslated: English = "Socket must be in blocking mode"
RTLConsts.sSocketIOError - untranslated: English = "%s error %d, %s"
RTLConsts.sSocketRead - untranslated: English = "Read"
RTLConsts.sSocketWrite - untranslated: English = "Write"
*)
end.
