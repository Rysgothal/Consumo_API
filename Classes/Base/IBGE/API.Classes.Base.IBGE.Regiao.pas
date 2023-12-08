unit API.Classes.Base.IBGE.Regiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados, API.Classes.Bridge.IBGERegiaoBridge;

type
  TApiIBGERegiao = class(TApi)
  public
    class function ObterInstancia(pTransformar: TObjetoPara): TApiIBGERegiao;
    function ConsultarRegiao(const pRegiao: string): TJSONValue;
    function ListarRegioes: TJSONValue;
    function ListarEstadosDaRegiao(const pRegiao: string): TJSONValue;
  end;

var
  FApiIBGERegiao: TApiIBGERegiao;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEEstadosStrategy,
  API.Classes.Bridge.IBGEMesorregiaoBridge, API.Interfaces.Strategy.Principal;

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
var
  lConfig: IAPIStrategy;
begin
  lConfig := FConfigRequest;

  FConfigRequest := TStrategyIBGEEstados.Create;
  FConfigRequest.ConfigurarRequisicao(Request, pRegiao);
  FConfigRequest := lConfig;

  Result := Request.Response.JSONValue;
end;

function TApiIBGERegiao.ListarRegioes: TJSONValue;
begin
  FConfigRequest.ConfigurarRequisicao(Request, EmptyStr);
  Result := Request.Response.JSONValue;
end;

class function TApiIBGERegiao.ObterInstancia(pTransformar: TObjetoPara): TApiIBGERegiao;
begin
  if not Assigned(FApiIBGERegiao) then
  begin
    FApiIBGERegiao := TApiIBGERegiao(inherited Create('https://servicodados.ibge.gov.br/api/v1/localidades/regioes/',
      acRegiao));
  end;

  case pTransformar of
    opRegioes: FApiIBGERegiao.Transformar := TBridgeIBGERegioes.Create;
    opRegiao: FApiIBGERegiao.Transformar := TBridgeIBGERegiao.Create;
  end;

  Result := FApiIBGERegiao;
end;

initialization

finalization
  FreeAndNil(FApiIBGERegiao);

end.
