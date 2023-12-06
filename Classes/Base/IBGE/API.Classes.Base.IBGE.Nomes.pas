unit API.Classes.Base.IBGE.Nomes;

interface

uses
  API.Classes.Base.Principal, System.JSON;

type
  TApiIBGENomes = class(TApi)
  public
    function ConsultarNomes(const pNome: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils;

{ TIBGENomes }

function TApiIBGENomes.ConsultarNomes(const pNome: string): TJSONValue;
begin
  if pNome = EmptyStr then
  begin
    raise ENomeNaoInformado.Create('Nome não inserido');
  end;

  FConfigRequest.ConfigurarRequisicao(Request, pNome);

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  if Request.Response.ContentLength = 2 then
  begin
    raise ENomeSemRegistros.Create('Sem Dados sobre o nome informado');
  end;

  Result := Request.Response.JSONValue;
end;

end.
