unit ControlUtilsUnit;

interface

uses Controls, SysUtils, NullablesUnit;

type
  TControlUtils = class
  public
    //##jpl: remove all the SetCaption as it is not needed in D2007 any more.
    // C1624 in Delphi 2006 Update 2 compiler, or
    // URW821 in Delphi 2006 Update 2 compiler, caused by the ToString() call.
    // Delphi 2007 does not have this: it properly supports function results on record methods.
    // see http://qc.borland.com/wc/qcmain.aspx?d=30131
    // s := FGlassPriceData.SphCylData[aCyl, aSph].ToString();
    class procedure SetCaption(aControl: TControl; aValue: TNullableCurrency); overload;
    // C1624 in Delphi 2006 Update 2 compiler, or
    // URW821 in Delphi 2006 Update 2 compiler, caused by the ToString() call.
    // Delphi 2007 does not have this: it properly supports function results on record methods.
    // see http://qc.borland.com/wc/qcmain.aspx?d=30131
    // s := FGlassPriceData.SphCylData[aCyl, aSph].ToString();
    class procedure SetCaption(aControl: TControl; aValue: TNullableDouble); overload;
    // C1624 in Delphi 2006 Update 2 compiler, or
    // URW821 in Delphi 2006 Update 2 compiler, caused by the ToString() call.
    // Delphi 2007 does not have this: it properly supports function results on record methods.
    // see http://qc.borland.com/wc/qcmain.aspx?d=30131
    // s := FGlassPriceData.SphCylData[aCyl, aSph].ToString();
    class procedure SetCaption(aControl: TControl; aValue: TNullableDouble; Digits: Integer); overload;
    // C1624 in Delphi 2006 Update 2 compiler, or
    // URW821 in Delphi 2006 Update 2 compiler, caused by the ToString() call.
    // Delphi 2007 does not have this: it properly supports function results on record methods.
    // see http://qc.borland.com/wc/qcmain.aspx?d=30131
    // s := FGlassPriceData.SphCylData[aCyl, aSph].ToString();
    class procedure SetCaption(aControl: TControl; aValue: string); overload;
    class procedure SyncControlTextIfEmpty(Target: TControl; Source: TControl); static;
    class procedure CalculateText(Control: TControl;
      const FormatSettings: TFormatSettings;
      const NewValue: TNullableDouble); overload; static;
    class procedure CalculateText(Control: TControl;
      const FormatSettings: TFormatSettings;
      const DateTimeFormat: TDateTimeFormat;
      const NewValue: TNullableDateTime); overload; static;
    class procedure CalculateText(Control: TControl;
      const FormatSettings: TFormatSettings;
      const NewValue: TNullableCurrency); overload; static;
    // C1624 in Delphi 2006 Update 2 compiler, or
    // URW821 in Delphi 2006 Update 2 compiler, caused by the ToString() call.
    // Delphi 2007 does not have this: it properly supports function results on record methods.
    // see http://qc.borland.com/wc/qcmain.aspx?d=30131
    // s := FGlassPriceData.SphCylData[aCyl, aSph].ToString();
    class procedure SetCaption(aControl: TControl; aValue: TNullableInteger); overload;
  end;

implementation

type
  TControlProtectionCracker = class(TControl);

  { TNumEditAlign }

class procedure TControlUtils.CalculateText(
  Control: TControl;
  const FormatSettings: TFormatSettings;
  const NewValue: TNullableDouble);
var
  NewText: string;
  CrackedControl: TControlProtectionCracker;
begin
  NewText := NewValue.ToString(FormatSettings);
  CrackedControl := TControlProtectionCracker(Control);
  if NewText <> CrackedControl.Text then
    CrackedControl.Text := NewText;
end;

  { TNumEditAlign }

class procedure TControlUtils.CalculateText(Control: TControl; const FormatSettings: TFormatSettings; const
    DateTimeFormat: TDateTimeFormat; const NewValue: TNullableDateTime);
var
  NewText: string;
  CrackedControl: TControlProtectionCracker;
begin
  NewText := NewValue.ToString(FormatSettings, DateTimeFormat);
  CrackedControl := TControlProtectionCracker(Control);
  if NewText <> CrackedControl.Text then
    CrackedControl.Text := NewText;
end;

  { TNumEditAlign }

class procedure TControlUtils.CalculateText(
  Control: TControl;
  const FormatSettings: TFormatSettings;
  const NewValue: TNullableCurrency);
var
  NewText: string;
  CrackedControl: TControlProtectionCracker;
begin
  NewText := NewValue.ToString(FormatSettings);
  CrackedControl := TControlProtectionCracker(Control);
  if NewText <> CrackedControl.Text then
    CrackedControl.Text := NewText;
end;

class procedure TControlUtils.SetCaption(aControl: TControl; aValue: TNullableCurrency);
begin
  TControlProtectionCracker(aControl).Caption := aValue.ToString();
end;

class procedure TControlUtils.SetCaption(aControl: TControl; aValue: TNullableDouble);
begin
  TControlProtectionCracker(aControl).Caption := aValue.ToString();
end;

class procedure TControlUtils.SetCaption(aControl: TControl; aValue: TNullableDouble; Digits: Integer);
begin
  TControlProtectionCracker(aControl).Caption := aValue.ToString(Digits);
end;

class procedure TControlUtils.SetCaption(aControl: TControl; aValue: string);
begin
  TControlProtectionCracker(aControl).Caption := aValue;
end;

class procedure TControlUtils.SetCaption(aControl: TControl; aValue: TNullableInteger);
begin
  TControlProtectionCracker(aControl).Caption := aValue.ToString();
end;

class procedure TControlUtils.SyncControlTextIfEmpty(Target: TControl; Source: TControl);
var
  CrackedSource: TControlProtectionCracker;
  CrackedTarget: TControlProtectionCracker;
begin
  CrackedTarget := TControlProtectionCracker(Target);
    CrackedSource := TControlProtectionCracker(Source);
  if CrackedTarget.Text = '' then
    if CrackedSource.Text <> '' then
      CrackedTarget.Text := CrackedSource.Text;
end;

end.

