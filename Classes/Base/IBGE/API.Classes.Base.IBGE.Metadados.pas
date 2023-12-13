unit API.Classes.Base.IBGE.Metadados;

interface

uses
  API.Classes.Base.Principal, System.JSON, REST.Types,
  API.Classes.Helpers.Enumerados, API.Classes.Bridge.IBGEMetadadosBridge,
  API.Classes.JSON.IBGE.Metadados, API.Interfaces.Bridge.JSONParaObject;

type
  TApiIBGEMetadados = class(TApi)
  private
    FJSON: TJSONIBGEMetadados;
  public
    class function ObterInstancia: TApiIBGEMetadados;
    destructor Destroy; override;
    property JSON: TJSONIBGEMetadados read FJSON write FJSON;
    procedure ConsultarMetadados(const pIdRegiao: string; pTransformar: ITransformar);
  end;

var
  FApiIBGEMetadados: TApiIBGEMetadados;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils,
  API.Classes.Bridge.IBGEMesorregiaoBridge;

{ TApiIBGEMetadados }

procedure TApiIBGEMetadados.ConsultarMetadados(const pIdRegiao: string; pTransformar: ITransformar);
begin
  try
    FConfigRequest.ConfigurarRequisicao(Request, pIdRegiao);
  except
    on ERESTException do
    begin
      raise EErroDeRota.Create('Erro de rota');
    end;
  end;

  FJSON := TJSONIBGEMetadados(pTransformar.ParaObjeto(Request.Response.JSONValue));
end;

destructor TApiIBGEMetadados.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

class function TApiIBGEMetadados.ObterInstancia: TApiIBGEMetadados;
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
