unit API.Classes.Base.IBGE.Mesorregiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados;

type
  TApiIBGEMesorregiao = class(TApi)
  public
    class function ObterInstancia(pTransformar: TObjetoPara): TApiIBGEMesorregiao;
    function ConsultarMetadadosMesorregiao(const pIdMesorregiao: string): TJSONValue;
    function ConsultarMesorregioesDoEstado(const pUF: string): TJSONValue; // TApiIBGEEstado
  end;

var
  FApiIBGEMesorregiao: TApiIBGEMesorregiao;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEMetadadosStrategy, API.Classes.Bridge.IBGEUFBridge;

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

class function TApiIBGEMesorregiao.ObterInstancia(pTransformar: TObjetoPara): TApiIBGEMesorregiao;
begin
  if not Assigned(FApiIBGEMesorregiao) then
  begin
    FApiIBGEMesorregiao := TApiIBGEMesorregiao(inherited Create('https://servicodados.ibge.gov.br/api/v3/malhas/' +
      'mesorregioes/', acMesorregiao));
  end;

  case pTransformar of
//    opMesorregioes: ;
//    opRegiao: ;
//    opRegioes: ;
//    opMetadados: ;
    opUfs: FApiIBGEMesorregiao.Transformar := TBridgeIBGEUFs.Create;
  end;

  Result := FApiIBGEMesorregiao;
end;

function TApiIBGEMesorregiao.ConsultarMesorregioesDoEstado(const pUF: string): TJSONValue;
begin
  FConfigRequest.ConfigurarRequisicao(Request, pUF);
  Result := Request.Response.JSONValue;
end;

initialization

finalization
  FreeAndNil(FApiIBGEMesorregiao);

end.
