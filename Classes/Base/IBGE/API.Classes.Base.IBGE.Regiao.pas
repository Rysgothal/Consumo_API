unit API.Classes.Base.IBGE.Regiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types;

type
  TApiIBGERegiao = class(TApi)
  public
    function ConsultarRegiao(const pRegiao: string): TJSONValue;
    function ListarRegioes: TJSONValue;
    function ListarEstadosDaRegiao(const pRegiao: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEEstadosStrategy;

{ TApiIBGERegiao }

function TApiIBGERegiao.ConsultarRegiao(const pRegiao: string): TJSONValue;
begin
  FConfigRequest.ConfigurarRequisicao(Request, pRegiao);

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  Result := Request.Response.JSONValue;
end;

function TApiIBGERegiao.ListarEstadosDaRegiao(const pRegiao: string): TJSONValue;
begin
  FConfigRequest := TStrategyIBGEEstados.Create;
  FConfigRequest.ConfigurarRequisicao(Request, pRegiao);
  Result := Request.Response.JSONValue;
end;

function TApiIBGERegiao.ListarRegioes: TJSONValue;
begin
  FConfigRequest.ConfigurarRequisicao(Request, EmptyStr);
  Result := Request.Response.JSONValue;
end;

end.
