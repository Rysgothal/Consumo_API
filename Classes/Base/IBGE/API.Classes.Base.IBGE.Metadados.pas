unit API.Classes.Base.IBGE.Metadados;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types;

type
  TApiIBGEMetadados = class(TApi)
  public
    function ConsultarMetadados(const pIdRegiao: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions;

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

end.
