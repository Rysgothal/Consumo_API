unit API.Classes.Base.Principal;

interface

uses
  REST.Client, API.Interfaces.Strategy.Principal,
  API.Classes.Helpers.Enumerados, API.Interfaces.Bridge.JSONParaObject,
  API.Classes.Bridge.ViaCepBridge;

type
  TApi = class
  private
    FRequest: TRESTRequest;
    FClient: TRESTClient;
    FTransformar: ITransformar;
  protected
    FConfigRequest: IApiStrategy;
    constructor Create(const pURL: string; pTipoApi: TApiConsulta);
  public
    property Request: TRESTRequest read FRequest write FRequest;
    property Transformar: ITransformar read FTransformar write FTransformar;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, API.Classes.Strategy.ViaCepStrategy,
  API.Classes.Strategy.IBGERegioesStrategy,
  API.Classes.Strategy.IBGEMetadadosStrategy,
  API.Classes.Strategy.IBGEMesorregiaoStrategy;
//  API.Classes.Bridge.IBGERegiaoBridge,
//  API.Classes.Bridge.IBGEMesorregiaoBridge,
//  API.Classes.Bridge.IBGEMetadadosBridge;

{ TApi }

constructor TApi.Create(const pURL: string; pTipoApi: TApiConsulta);
begin
  FClient := TRESTClient.Create(pURL);
  FRequest := TRESTRequest.Create(FClient);

  case pTipoApi of
    acViaCep:
    begin
      FConfigRequest := TStrategyViaCep.Create;
//      FTransformar := TBridgeViaCep.Create;
    end;
    acMesorregiao:
    begin
      FConfigRequest := TStrategyIBGEMesorregiao.Create;
//      FTransformar := TBridgeIBGEMesorregiao.Create;
    end;
    acRegiao:
    begin
      FConfigRequest := TStrategyIBGERegiao.Create;
//      FTransformar := TBridgeIBGERegiao.Create;
    end;
    acMetadados:
    begin
      FConfigRequest := TStrategyIBGEMetadados.Create;
//      FTransformar := TBridgeIBGEMetadados.Create;
    end;
  end;
end;

destructor TApi.Destroy;
begin
  FreeAndNil(FRequest);
  FreeAndNil(FClient);
  inherited;
end;

end.
