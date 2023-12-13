unit API.Classes.Base.IBGE.Estados;

interface

uses
  API.Classes.Base.Principal, API.Classes.Helpers.Enumerados, System.JSON,
  API.Classes.JSON.IBGE.Mesorregiao, API.Interfaces.Bridge.JSONParaObject;

type
  TApiIBGEEstado = class(TApi)
  private
    FJSON: TJSONIBGEMesorregioes;
  public
    property JSON: TJSONIBGEMesorregioes read FJSON;
    procedure ConsultarMesorregioes(const pUF: string; pTransformar: ITransformar);
  end;

implementation

uses
  API.Classes.Bridge.IBGEUFBridge, API.Classes.Bridge.IBGEMesorregiaoBridge,
  System.SysUtils;

{ TApiIBGEEstado }

procedure TApiIBGEEstado.ConsultarMesorregioes(const pUF: string; pTransformar: ITransformar);
begin
  FConfigRequest.ConfigurarRequisicao(Request, pUF);

  if Assigned(FJSON) then
  begin
    FreeAndNil(FJSON);
  end;

  FJSON := TJSONIBGEMesorregioes(pTransformar.ParaObjeto(Request.Response.JSONValue));
end;

end.
