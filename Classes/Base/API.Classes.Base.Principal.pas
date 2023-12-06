unit API.Classes.Base.Principal;

interface

uses
  REST.Client, API.Interfaces.Strategy.Principal,
  API.Classes.Helpers.Enumerados;

type
  TApi = class
  private
    FRequest: TRESTRequest;
    FClient: TRESTClient;
  protected
    FConfigRequest: IApiStrategy;
  public
    property Request: TRESTRequest read FRequest write FRequest;
    constructor Create(const pURL: string; pTipoApi: TTipoApi);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, API.Classes.Strategy.ViaCepStrategy,
  API.Classes.Strategy.IBGERegioesStrategy,
  API.Classes.Strategy.IBGEMetadadosStrategy,
  API.Classes.Strategy.IBGEMesorregiaoStrategy;

{ TApi }

constructor TApi.Create(const pURL: string; pTipoApi: TTipoApi);
begin
  FClient := TRESTClient.Create(pURL);
  FRequest := TRESTRequest.Create(FClient);

  case pTipoApi of
    taViaCep: FConfigRequest := TStrategyViaCep.Create;
    taMesorregiao: FConfigRequest := TStrategyIBGEMesorregiao.Create;
    taRegiao: FConfigRequest := TStrategyIBGERegiao.Create;
    taMetadados: FConfigRequest := TStrategyIBGEMetadados.Create;
  end;
end;

destructor TApi.Destroy;
begin
  FreeAndNil(FRequest);
  FreeAndNil(FClient);
  inherited;
end;

end.
