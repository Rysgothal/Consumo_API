unit API.Classes.Base.IBGE.Mesorregiao;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados, API.Classes.JSON.IBGE.Metadados,
  API.Interfaces.Bridge.JSONParaObject;

type
  TApiIBGEMesorregiao = class(TApi)
  private
    FJSON: TJSONIBGEMetadados;
  public
    destructor Destroy; override;
    property JSON: TJSONIBGEMetadados read FJSON write FJSON;
    procedure ConsultarMetadadosMesorregiao(const pIdMesorregiao: string);
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Strategy.IBGEMetadadosStrategy, API.Classes.Bridge.IBGEUFBridge,
  API.Classes.Bridge.IBGEMesorregiaoBridge,
  API.Classes.Bridge.IBGEMetadadosBridge, API.Interfaces.Strategy.Principal;

{ TIBGEMesorregiao }

procedure TApiIBGEMesorregiao.ConsultarMetadadosMesorregiao(const pIdMesorregiao: string);
var
  lConfig: IApiStrategy;
  lTransformar: ITransformar;
begin
  lConfig := TStrategyIBGEMetadados.Create;

  try
    lConfig.ConfigurarRequisicao(Request, pIdMesorregiao);
  except
    on ERESTException do
    begin
      raise EErroDeRota.Create('Erro de rota');
    end;
  end;

  lTransformar := TBridgeIBGEMetadados.Create;
  if Assigned(FJSON) then
  begin
    FreeAndNil(FJSON);
  end;

  FJSON := TJSONIBGEMetadados(lTransformar.ParaObjeto(Request.Response.JSONValue));
end;

destructor TApiIBGEMesorregiao.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

end.
