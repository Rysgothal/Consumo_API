unit API.Classes.Base.IBGE.Mesorregiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados;

type
  TApiIBGEMesorregiao = class(TApi)
  public
    function ConsultarMetadadosMesorregiao(const pIdMesorregiao: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEMetadadosStrategy, API.Classes.Bridge.IBGEUFBridge,
  API.Classes.Bridge.IBGEMesorregiaoBridge,
  API.Classes.Bridge.IBGEMetadadosBridge, API.Interfaces.Strategy.Principal;

{ TIBGEMesorregiao }

function TApiIBGEMesorregiao.ConsultarMetadadosMesorregiao(const pIdMesorregiao: string): TJSONValue;
var
  lConfig: IApiStrategy;
begin
  lConfig := FConfigRequest;
  FConfigRequest := TStrategyIBGEMetadados.Create;

  try
    FConfigRequest.ConfigurarRequisicao(Request, pIdMesorregiao);
  except
    on ERESTException do
    begin
      raise EErroDeRota.Create('Erro de rota');
    end;
  end;

  FConfigRequest := lConfig;
  Result := Request.Response.JSONValue;
end;

end.
