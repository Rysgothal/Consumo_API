unit API.Classes.Base.IBGEMesorregiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types;

type
  TIBGEMesorregiao = class(TApi)
  public
    function ConsultarMesorregiao(const pIdMesorregiao: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions;

{ TIBGEMesorregiao }

function TIBGEMesorregiao.ConsultarMesorregiao(const pIdMesorregiao: string): TJSONValue;
begin
  try
    ConfigurarRequisicao('{mesorregiao}/metadados', 'mesorregiao', pIdMesorregiao);
  except
    on ERESTException do
    begin
      raise EErroDeRota.Create('Erro de rota');
    end;
  end;

  Result := Request.Response.JSONValue;
end;

end.
