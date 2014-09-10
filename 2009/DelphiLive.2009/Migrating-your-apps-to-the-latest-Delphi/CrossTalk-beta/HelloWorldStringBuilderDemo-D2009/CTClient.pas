unit CTClient;

interface

uses
  CTObject;

// Procs
  function Ping: integer;
   cdecl; external 'CrossTalkMiddle.dll' name 'Controller_Ping';

  procedure GetResultString(
    aResult: PCTChar
  )
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_GetResultString';

  function MethodCall(
    aObj: TCTObject;
    aMethodName: PCTChar;
    var rResult: Longword;
    aParamCount: Integer;
    aParams: Pointer
  ): integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_MethodCall';

  procedure ResultObjectsClear();
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_ResultObjectsClear';

  function ObjectMatch(
    aTempObjID: Integer;
    var rObj: TCTObject
  ): Integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_ObjectMatch';

  function ObjectTransform(
    aTempObjID: Integer;
    aObjID: TCTObject
  ): Integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_ObjectTransform';

  function ObjectCreate(
    aName: PCTChar;
    aObj: TCTObject;
    aParamCount: Integer;
    aParams: Pointer
  ): integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_ObjectCreate';

  function ObjectDestroy(
    aObj: TCTObject
  ): integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_ObjectDestroy';

  function PropGet(
    aObj: TCTObject;
    aName: PCTChar;
    aIndexCount: Integer;
    aIndices: Pointer;
    var rValue: Longword
  ): integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_PropGet';

  function PropSet(
    aObj: TCTObject;
    aName: PCTChar;
    aIndexCount: Integer;
    aIndices: Pointer;
    aValue: Longword
  ): integer;
  cdecl; external 'CrossTalkMiddle.dll'
  name 'Controller_PropSet';

implementation

end.
