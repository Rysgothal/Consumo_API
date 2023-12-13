unit API.Classes.Base.IBGE.Regiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados, API.Classes.Bridge.IBGERegiaoBridge,
  API.Classes.JSON.IBGE.Regiao, API.Interfaces.Bridge.JSONParaObject;

type
  TApiIBGERegiao = class(TApi)
  private
    FJSON: TJSONIBGERegiao;
  public
    property JSON: TJSONIBGERegiao read FJSON write FJSON;
    destructor Destroy; override;
    procedure ConsultarRegiao(const pRegiao: string; pTransformar: ITransformar);
    function ListarRegioes: TJSONValue;
    function ListarEstadosDaRegiao(const pRegiao: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEEstadosStrategy,
  API.Classes.Bridge.IBGEMesorregiaoBridge, API.Interfaces.Strategy.Principal;

{ TApiIBGERegiao }

procedure TApiIBGERegiao.ConsultarRegiao(const pRegiao: string; pTransformar: ITransformar);
begin
  FConfigRequest.ConfigurarRequisicao(Request, pRegiao);

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  if Assigned(FJSON) then
  begin
    FreeAndNil(FJSON);
  end;

  FJSON := TJSONIBGERegiao(pTransformar.ParaObjeto(Request.Response.JSONValue));
end;

destructor TApiIBGERegiao.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
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

end.
