unit API.Classes.Base.IBGE.Metadados;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados;

type
  TApiIBGEMetadados = class(TApi)
  public
    class function ObterInstancia(TTipoApi: TApiConsulta): TApiIBGEMetadados;
    function ConsultarMetadados(const pIdRegiao: string): TJSONValue;
  end;

var
  FApiIBGEMetadados: TApiIBGEMetadados;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils;

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

class function TApiIBGEMetadados.ObterInstancia(TTipoApi: TApiConsulta): TApiIBGEMetadados;
begin
  if not Assigned(FApiIBGEMetadados) then
  begin
    FApiIBGEMetadados := TApiIBGEMetadados(inherited Create('https://servicodados.ibge.gov.br/api/v3/malhas/regioes/',
      acMetadados));
  end;

  Result := FApiIBGEMetadados;
end;

initialization

finalization
  FreeAndNil(FApiIBGEMetadados);

end.
