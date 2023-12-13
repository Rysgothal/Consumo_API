unit API.Classes.Singleton.Principal;

interface

uses
  API.Classes.Base.ViaCep, API.Classes.Base.IBGE.Mesorregiao, API.Classes.Base.IBGE.Regiao,
  API.Classes.Base.IBGE.Metadados, API.Classes.Base.IBGE.Estados, API.Interfaces.Bridge.JSONParaObject,
  API.Classes.Helpers.Enumerados, System.Classes, System.Generics.Collections,
  API.Interfaces.Observer.Notificacao;

type
  TApiSingleton = class
  private
    FViaCep: TApiViaCep;
    FMesorregiao: TApiIBGEMesorregiao;
    FRegiao: TApiIBGERegiao;
    FMetadados: TApiIBGEMetadados;
    FEstado: TApiIBGEEstado;
    FTransformar: ITransformar;
//    FObservers: TDictionary<TEstruturaJSON, IObserver>;
    FObservers: TList<IObserver>;
    constructor Create;
  public
    destructor Destroy; override;
    class function ObterInstancia(pTransformar: TEstruturaJSON): TApiSingleton;
    property ViaCep: TApiViaCep read FViaCep write FViaCep;
    property Mesorregiao: TApiIBGEMesorregiao read FMesorregiao write FMesorregiao;
    property Regiao: TApiIBGERegiao read FRegiao write FRegiao;
    property Metadados: TApiIBGEMetadados read FMetadados write FMetadados;
    property Estado: TApiIBGEEstado read FEstado write FEstado;
    property Transformar: ITransformar read FTransformar write FTransformar;
//    property Observers: TDictionary<TEstruturaJSON, IObserver> read FObservers write FObservers;
    property Observers: TList<IObserver> read FObservers write FObservers;
    procedure AdicionarObserver(pObserver: IObserver);
    procedure RemoverObserver(pObserver: IObserver);
  end;

var
  FApi: TApiSingleton;

implementation

uses
  System.SysUtils, API.Classes.Bridge.ViaCepBridge, API.Classes.Bridge.IBGERegiaoBridge,
  API.Classes.Bridge.IBGEMetadadosBridge, API.Classes.Bridge.IBGEUFBridge, API.Classes.Bridge.IBGEMesorregiaoBridge;

{ TApiSingleton }

procedure TApiSingleton.AdicionarObserver(pObserver: IObserver);
begin
  FObservers.Add(pObserver);
end;

constructor TApiSingleton.Create;
begin
  FViaCep := TApiViaCep.ObterInstancia;
  FMetadados := TApiIBGEMetadados.ObterInstancia;
  FEstado := TApiIBGEEstado.ObterInstancia;
  FMesorregiao := TApiIBGEMesorregiao.ObterInstancia;
  FRegiao := TApiIBGERegiao.ObterInstancia;

  FObservers := TList<IObserver>.Create;
end;

destructor TApiSingleton.Destroy;
begin
  FreeAndNil(FObservers);
  inherited;
end;

class function TApiSingleton.ObterInstancia(pTransformar: TEstruturaJSON): TApiSingleton;
begin
  if not Assigned(FApi) then
  begin
    FApi := TApiSingleton.Create;
  end;

  case pTransformar of
    ejViaCep: FApi.FTransformar := TBridgeViaCep.Create;
    ejMesorregioes: FApi.FTransformar := TBridgeIBGEMesorregioes.Create;
    ejRegiao: FApi.FTransformar := TBridgeIBGERegiao.Create;
    ejRegioes: FApi.FTransformar := TBridgeIBGERegioes.Create;
    ejMetadados: FApi.FTransformar := TBridgeIBGEMetadados.Create;
    ejUfs: FApi.FTransformar := TBridgeIBGEUFs.Create;
  end;

  Result := FApi;
end;

procedure TApiSingleton.RemoverObserver(pObserver: IObserver);
begin
  FObservers.Remove(pObserver);
end;

initialization

finalization
  FreeAndNil(FApi);

end.
