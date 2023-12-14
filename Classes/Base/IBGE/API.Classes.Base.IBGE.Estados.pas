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
    destructor Destroy; override;
    property JSON: TJSONIBGEMesorregioes read FJSON;
    procedure ConsultarMesorregioes(const pUF: string);
  end;

implementation

uses
  API.Classes.Bridge.IBGEUFBridge, API.Classes.Bridge.IBGEMesorregiaoBridge,
  System.SysUtils;

{ TApiIBGEEstado }

procedure TApiIBGEEstado.ConsultarMesorregioes(const pUF: string);
var
  lTransformar: ITransformar;
begin
  FConfigRequest.ConfigurarRequisicao(Request, pUF);

  if Assigned(FJSON) then
  begin
    FreeAndNil(FJSON);
  end;

  lTransformar := TBridgeIBGEMesorregioes.Create;
  FJSON := TJSONIBGEMesorregioes(lTransformar.ParaObjeto(Request.Response.JSONValue));
end;

destructor TApiIBGEEstado.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

end.
