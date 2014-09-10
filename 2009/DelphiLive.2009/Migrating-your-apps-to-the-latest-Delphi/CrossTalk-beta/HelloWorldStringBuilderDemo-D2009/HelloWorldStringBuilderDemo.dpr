program HelloWorldStringBuilderDemo;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  CT_System_Text_StringBuilder in 'CT_System_Text_StringBuilder.pas',
  CTObject in 'CTObject.pas',
  CTException in 'CTException.pas',
  CTClient in 'CTClient.pas';

procedure Run;
var
  MyStringBuilder: StringBuilder;
begin
  WriteLn('Start');

  MyStringBuilder := StringBuilder.Create('Hello CrossTalk!!!');
  WriteLn('Length: ', MyStringBuilder.Length);

  MyStringBuilder.Append('More');
  WriteLn('Length: ', MyStringBuilder.Length);

  WriteLn(MyStringBuilder.ToString());
end;

begin
  try
    try
      Run();
    except
      on E:Exception do
        Writeln(E.Classname, ': ', E.Message);
    end;
  finally
    Write('Press <Enter>');
    ReadLn;
  end;
end.
