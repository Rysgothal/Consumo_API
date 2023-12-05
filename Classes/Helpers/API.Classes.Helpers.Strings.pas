unit API.Classes.Helpers.Strings;

interface

uses
  System.SysUtils, Vcl.StdCtrls;

type
  TStringHelper = class abstract
  public
    class function DigitarSomenteNumeros(pValor: string): string;
    class function FormatarCep(const pValor: string): string; overload;
    class procedure FormatarCep(const pEdit: TCustomEdit); overload;
    class procedure MoverFinal(const pEdit: TCustomEdit);
    class procedure InsertChar(var pValor: string; const pPos: Integer; const pChar: Char);
  end;

implementation

{ TStringHelper }

class function TStringHelper.DigitarSomenteNumeros(pValor: string): string;
begin
  for var lChar in pValor do
  begin
    if CharInSet(lChar, ['0'..'9']) then
    begin
      Result := Result + lChar;
    end;
  end;
end;

class procedure TStringHelper.FormatarCep(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarCep(pEdit.Text);
  MoverFinal(pEdit);
end;

class procedure TStringHelper.InsertChar(var pValor: string; const pPos: Integer; const pChar: Char);
begin
  if pValor.Length > pPos then
  begin
    pValor.Insert(pPos, pChar);
  end;
end;

class procedure TStringHelper.MoverFinal(const pEdit: TCustomEdit);
begin
  pEdit.SelStart := Length(pEdit.Text);
end;

class function TStringHelper.FormatarCep(const pValor: string): string;
begin
  Result := DigitarSomenteNumeros(pValor).Substring(0, 8);
  InsertChar(Result, 5, '-');
end;

end.
