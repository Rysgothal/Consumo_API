unit API.Classes.Base.ViaCep;

interface

uses
  API.Classes.Base.Principal, System.JSON, API.Classes.Helpers.Enumerados,
  API.Classes.JSON.ViaCep,
  API.Interfaces.Bridge.JSONParaObject;

type
  TApiViaCep = class(TApi)
  private
    FJSON: TJSONViaCep;
  public
    class function ObterInstancia: TApiViaCep;
    destructor Destroy; override;
    property JSON: TJSONViaCep read FJSON;
    procedure ConsultarCep(const pCep: string; pTransformar: ITransformar);
  end;

var
  FApiViaCep: TApiViaCep;

implementation

uses
  System.SysUtils, API.Classes.Helpers.Exceptions, System.StrUtils,
  API.Classes.Bridge.ViaCepBridge;

{ TViaCep }

procedure TApiViaCep.ConsultarCep(const pCep: string; pTransformar: ITransformar);
begin
  if pCep = EmptyStr then
  begin
    raise ECepNaoInformado.Create('Nenhum CEP informado');
  end;

  if pCep.Length < 8 then
  begin
    raise ECepInvalido.Create('O CEP est� inv�lido');
  end;

  FConfigRequest.ConfigurarRequisicao(Request, pCep);

  if ContainsStr(Request.Response.JSONText, 'erro') then
  begin
    raise ECepInexistente.Create('O CEP informado n�o foi encontrado');
  end;

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  FJSON := TJSONViaCep(pTransformar.ParaObjeto(Request.Response.JSONValue));
end;

destructor TApiViaCep.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

class function TApiViaCep.ObterInstancia: TApiViaCep;
begin
  if not Assigned(FApiViaCep) then
  begin
    FApiViaCep := TApiViaCep(inherited Create('https://viacep.com.br/ws/', acViaCep));
  end;

  Result := FApiViaCep;
end;

initialization

finalization
  FreeAndNil(FApiViaCep);

end.
