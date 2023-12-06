unit API.Classes.Base.ViaCep;

interface

uses
  API.Classes.Base.Principal, System.JSON;

type
  TApiViaCep = class(TApi)
  public
    function ConsultarCep(const pCep: string): TJSONValue;
  end;

implementation

uses
  System.SysUtils, API.Classes.Helpers.Exceptions, System.StrUtils;

{ TViaCep }

function TApiViaCep.ConsultarCep(const pCep: string): TJSONValue;
begin
  if pCep = EmptyStr then
  begin
    raise ECepNaoInformado.Create('Nenhum CEP informado');
  end;

  if pCep.Length < 8 then
  begin
    raise ECepInvalido.Create('O CEP está inválido');
  end;

  FConfigRequest.ConfigurarRequisicao(Request, pCep);

  if ContainsStr(Request.Response.JSONText, 'erro') then
  begin
    raise ECepInexistente.Create('O CEP informado não foi encontrado');
  end;

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  Result := Request.Response.JSONValue;
end;

end.
