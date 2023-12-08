unit API.Classes.Base.IBGE.Estados;

interface

uses
  API.Classes.Base.Principal, API.Classes.Helpers.Enumerados, System.JSON;

type
  TApiIBGEEstado = class(TApi)
  public
    class function ObterInstancia: TApiIBGEEstado;
    function ConsultarMesorregioes(const pUF: string): TJSONValue;
  end;

var
  FApiIBGEEstado: TApiIBGEEstado;

implementation

uses
  API.Classes.Bridge.IBGEUFBridge, API.Classes.Bridge.IBGEMesorregiaoBridge,
  System.SysUtils;

{ TApiIBGEEstado }

function TApiIBGEEstado.ConsultarMesorregioes(const pUF: string): TJSONValue;
begin
  FConfigRequest.ConfigurarRequisicao(Request, pUF);
  Result := Request.Response.JSONValue;
end;

class function TApiIBGEEstado.ObterInstancia: TApiIBGEEstado;
begin
  if not Assigned(FApiIBGEEstado) then
  begin
    FApiIBGEEstado := TApiIBGEEstado(inherited Create('https://servicodados.ibge.gov.br/api/v1/localidades/' +
      'estados/', acMesorregiao));
  end;

  FApiIBGEEstado.Transformar := TBridgeIBGEMesorregioes.Create;
  Result := FApiIBGEEstado;
end;

initialization

finalization
  FreeAndNil(FApiIBGEEstado);

end.
