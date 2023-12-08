unit API.Classes.Base.IBGE.Metadados;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados, API.Classes.Bridge.IBGEMetadadosBridge;

type
  TApiIBGEMetadados = class(TApi)
  public
    class function ObterInstancia(pTransformar: TObjetoPara): TApiIBGEMetadados;
    function ConsultarMetadados(const pIdRegiao: string): TJSONValue;
  end;

var
  FApiIBGEMetadados: TApiIBGEMetadados;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Bridge.IBGEMesorregiaoBridge;

{ TApiIBGEMetadados }

function TApiIBGEMetadados.ConsultarMetadados(const pIdRegiao: string): TJSONValue;
begin
  try
    FConfigRequest.ConfigurarRequisicao(Request, pIdRegiao);
  except
    on ERESTException do
    begin
      raise EErroDeRota.Create('Erro de rota');
    end;
  end;

  Result := Request.Response.JSONValue;
end;

class function TApiIBGEMetadados.ObterInstancia(pTransformar: TObjetoPara): TApiIBGEMetadados;
begin
  if not Assigned(FApiIBGEMetadados) then
  begin
    FApiIBGEMetadados := TApiIBGEMetadados(inherited Create('https://servicodados.ibge.gov.br/api/v3/malhas/regioes/',
      acMetadados));
  end;

  case pTransformar of
//    opMesorregioes: TBridgeIBGEMesorregioes.Create;
//    opRegiao: ;
//    opRegioes: ;
    opMetadados: FApiIBGEMetadados.Transformar := TBridgeIBGEMetadados.Create;
//    opUfs: ;
  end;

  Result := FApiIBGEMetadados;
end;

initialization

finalization
  FreeAndNil(FApiIBGEMetadados);

end.
