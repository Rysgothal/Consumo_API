unit API.Classes.Singleton.Principal;

interface

uses
//  API.Classes.Base.IBGE.Nomes,
  API.Classes.Base.ViaCep, API.Classes.Base.IBGE.Mesorregiao, API.Classes.Base.IBGE.Regiao,
  API.Classes.Base.IBGE.Metadados, API.Classes.Base.IBGE.Estados, API.Interfaces.Bridge.JSONParaObject,
  API.Classes.Helpers.Enumerados;

type
  TApiSingleton = class
  private
    FViaCep: TApiViaCep;
    FMesorregiao: TApiIBGEMesorregiao;
    FRegiao: TApiIBGERegiao;
    FMetadados: TApiIBGEMetadados;
    FEstado: TApiIBGEEstado;
    FTransformar: ITransformar;
    constructor Create;
  public
    class function ObterInstancia(pTransformar: TObjetoJSON): TApiSingleton;
    destructor Destroy; override;
    property ViaCep: TApiViaCep read FViaCep write FViaCep;
    property Mesorregiao: TApiIBGEMesorregiao read FMesorregiao write FMesorregiao;
    property Regiao: TApiIBGERegiao read FRegiao write FRegiao;
    property Metadados: TApiIBGEMetadados read FMetadados write FMetadados;
    property Estado: TApiIBGEEstado read FEstado write FEstado;
    property Transformar: ITransformar read FTransformar write FTransformar;
  end;

var
  FApi: TApiSingleton;

implementation

uses
  System.SysUtils, API.Classes.Bridge.ViaCepBridge, API.Classes.Bridge.IBGERegiaoBridge,
  API.Classes.Bridge.IBGEMetadadosBridge, API.Classes.Bridge.IBGEUFBridge, API.Classes.Bridge.IBGEMesorregiaoBridge;

{ TApiSingleton }

constructor TApiSingleton.Create;
begin
  FViaCep := TApiViaCep.ObterInstancia;
  FMetadados := TApiIBGEMetadados.ObterInstancia;
  FEstado := TApiIBGEEstado.ObterInstancia;
  FMesorregiao := TApiIBGEMesorregiao.ObterInstancia;  // Verificar...
  FRegiao := TApiIBGERegiao.ObterInstancia;            // Verificar...
end;

destructor TApiSingleton.Destroy;
begin
  FreeAndNil(FViaCep);
  FreeAndNil(FMesorregiao);
  FreeAndNil(FRegiao);
  FreeAndNil(FMetadados);
  FreeAndNil(FEstado);

  inherited;
end;

class function TApiSingleton.ObterInstancia(pTransformar: TObjetoJSON): TApiSingleton;
begin
  if not Assigned(FApi) then
  begin
    FApi := TApiSingleton.Create;
  end;

  case pTransformar of
    ojViaCep: FApi.FTransformar := TBridgeViaCep.Create;
    ojMesorregioes: FApi.FTransformar := TBridgeIBGEMesorregioes.Create;
    ojRegiao: FApi.FTransformar := TBridgeIBGERegiao.Create;
    ojRegioes: FApi.FTransformar := TBridgeIBGERegioes.Create;
    ojMetadados: FApi.FTransformar := TBridgeIBGEMetadados.Create;
    ojUfs: FApi.FTransformar := TBridgeIBGEUFs.Create;
  end;

  Result := FApi;
end;

initialization

finalization
  FreeAndNil(FApi);

end.
