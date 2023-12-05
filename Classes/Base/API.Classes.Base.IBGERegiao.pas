unit API.Classes.Base.IBGERegiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types;

type
  TIBGERegiao = class(TApi)
  public
    function ConsultarRegiao(const pRegiao: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions;

{ TIBGERegiao }

function TIBGERegiao.ConsultarRegiao(const pRegiao: string): TJSONValue;
begin
  ConfigurarRequisicao('/{Regiao}', 'Regiao', pRegiao);

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  Result := Request.Response.JSONValue;
end;

end.
