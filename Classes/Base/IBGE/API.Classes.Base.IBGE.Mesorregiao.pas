unit API.Classes.Base.IBGE.Mesorregiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types;

type
  TApiIBGEMesorregiao = class(TApi)
  public
    function ConsultarMetadadosMesorregiao(const pIdMesorregiao: string): TJSONValue;
    function ConsultarMesorregioesDoEstado(const pUF: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEMetadadosStrategy;

{ TIBGEMesorregiao }

function TApiIBGEMesorregiao.ConsultarMetadadosMesorregiao(const pIdMesorregiao: string): TJSONValue;
begin
  FConfigRequest := TStrategyIBGEMetadados.Create;

  try
    FConfigRequest.ConfigurarRequisicao(Request, pIdMesorregiao);
  except
    on ERESTException do
    begin
      raise EErroDeRota.Create('Erro de rota');
    end;
  end;

  Result := Request.Response.JSONValue;
end;

function TApiIBGEMesorregiao.ConsultarMesorregioesDoEstado(const pUF: string): TJSONValue;
begin
  FConfigRequest.ConfigurarRequisicao(Request, pUF);
  Result := Request.Response.JSONValue;
end;

end.
