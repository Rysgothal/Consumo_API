unit API.Classes.Singleton.Principal;

interface

uses
  API.Classes.Base.ViaCep, API.Classes.Base.IBGE.Mesorregiao, API.Classes.Base.IBGE.Regiao,
  API.Classes.Base.IBGE.Metadados, API.Classes.Base.IBGE.Estados, API.Interfaces.Bridge.JSONParaObject,
  API.Classes.Helpers.Enumerados, System.Classes, System.Generics.Collections,
  API.Interfaces.Observer.Notificacao, API.Interfaces.FactoryMethod.Api;

type
  TApiSingleton = class
  private
//    FViaCep: TApiViaCep;
    FMesorregiao: TApiIBGEMesorregiao;
    FRegiao: TApiIBGERegiao;
    FMetadados: TApiIBGEMetadados;
    FEstado: TApiIBGEEstado;
    FTransformar: ITransformar;
    FObservers: TList<IObserver>;
    FApi: IApiTipo;
    constructor Create;
  public
    destructor Destroy; override;
    class function ObterInstancia(pTransformar: TEstruturaJSON): TApiSingleton;
    property Api: IApiTipo read FApi write FApi;
//    property ViaCep: TApiViaCep read FViaCep write FViaCep;
    property Mesorregiao: TApiIBGEMesorregiao read FMesorregiao write FMesorregiao;
    property Regiao: TApiIBGERegiao read FRegiao write FRegiao;
    property Metadados: TApiIBGEMetadados read FMetadados write FMetadados;
    property Estado: TApiIBGEEstado read FEstado write FEstado;
    property Transformar: ITransformar read FTransformar write FTransformar;
    property Observers: TList<IObserver> read FObservers write FObservers;
    procedure AdicionarObserver(pObserver: IObserver);
    procedure RemoverObserver(pObserver: IObserver);
  end;

var
  FApiSingleton: TApiSingleton;

implementation

uses
  System.SysUtils, API.Classes.Bridge.ViaCepBridge, API.Classes.Bridge.IBGERegiaoBridge,
  API.Classes.Bridge.IBGEMetadadosBridge, API.Classes.Bridge.IBGEUFBridge, API.Classes.Bridge.IBGEMesorregiaoBridge,
  API.Classes.FactoryMethod.Fabrica;

{ TApiSingleton }

procedure TApiSingleton.AdicionarObserver(pObserver: IObserver);
begin
  FObservers.Add(pObserver);
end;

constructor TApiSingleton.Create;
var
  lFabricaApi: IApiFabrica;
begin
  lFabricaApi := TFabricaApi.Create;
  FApi := lFabricaApi.SelecionarApi(acViaCep);

//  FViaCep := TApiViaCep.Create('https://viacep.com.br/ws/', acViaCep);
  FMetadados := TApiIBGEMetadados.Create('https://servicodados.ibge.gov.br/api/v3/malhas/regioes/',acMetadados);
  FEstado := TApiIBGEEstado.Create('https://servicodados.ibge.gov.br/api/v1/localidades/estados/', acMesorregiao);
  FMesorregiao := TApiIBGEMesorregiao.Create('https://servicodados.ibge.gov.br/api/v3/malhas/mesorregioes/', acMesorregiao);
  FRegiao := TApiIBGERegiao.Create('https://servicodados.ibge.gov.br/api/v1/localidades/regioes/', acRegiao);

  FObservers := TList<IObserver>.Create;
end;

destructor TApiSingleton.Destroy;
begin
//  FreeAndNil(FViaCep);
  FreeAndNil(FMetadados);
  FreeAndNil(FEstado);
  FreeAndNil(FMesorregiao);
  FreeAndNil(FRegiao);
  FreeAndNil(FObservers);
  inherited;
end;

class function TApiSingleton.ObterInstancia(pTransformar: TEstruturaJSON): TApiSingleton;
begin
  if not Assigned(FApiSingleton) then
  begin
    FApiSingleton := TApiSingleton.Create;
  end;

  case pTransformar of
    ejViaCep: FApiSingleton.FTransformar := TBridgeViaCep.Create;
    ejMesorregioes: FApiSingleton.FTransformar := TBridgeIBGEMesorregioes.Create;
    ejRegiao: FApiSingleton.FTransformar := TBridgeIBGERegiao.Create;
    ejRegioes: FApiSingleton.FTransformar := TBridgeIBGERegioes.Create;
    ejMetadados: FApiSingleton.FTransformar := TBridgeIBGEMetadados.Create;
    ejUfs: FApiSingleton.FTransformar := TBridgeIBGEUFs.Create;
  end;

  Result := FApiSingleton;
end;

procedure TApiSingleton.RemoverObserver(pObserver: IObserver);
begin
  FObservers.Remove(pObserver);
end;

initialization

finalization
  FreeAndNil(FApiSingleton);

end.
