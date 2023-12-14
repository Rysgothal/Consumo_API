unit API.Classes.Base.Principal;

interface

uses
  REST.Client, API.Interfaces.Strategy.Principal,
  API.Classes.Helpers.Enumerados, API.Interfaces.Bridge.JSONParaObject,
  API.Classes.Bridge.ViaCepBridge, API.Interfaces.factoryMethod.Api;

type
  TTeste = class(TInterfacedObject, IApiTipo)
  public
   procedure Consultar(const pValor: string);
  end;

  TApi = class(TTeste)
  private
    FRequest: TRESTRequest;
    FClient: TRESTClient;
  protected
    FConfigRequest: IApiStrategy;
  public
    constructor Create(const pURL: string; pTipoApi: TApiConsulta);
    property Request: TRESTRequest read FRequest write FRequest;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, API.Classes.Strategy.ViaCepStrategy,
  API.Classes.Strategy.IBGERegioesStrategy,
  API.Classes.Strategy.IBGEMetadadosStrategy,
  API.Classes.Strategy.IBGEMesorregiaoStrategy;

{ TApi }

constructor TApi.Create(const pURL: string; pTipoApi: TApiConsulta);
begin
  FClient := TRESTClient.Create(pURL);
  FRequest := TRESTRequest.Create(FClient);

  case pTipoApi of
    acViaCep: FConfigRequest := TStrategyViaCep.Create;
    acMesorregiao: FConfigRequest := TStrategyIBGEMesorregiao.Create;
    acRegiao: FConfigRequest := TStrategyIBGERegiao.Create;
    acMetadados: FConfigRequest := TStrategyIBGEMetadados.Create;
  end;
end;

destructor TApi.Destroy;
begin
  FreeAndNil(FRequest);
  FreeAndNil(FClient);
  inherited;
end;

{ TTeste }

procedure TTeste.Consultar(const pValor: string);
begin

end;

end.
