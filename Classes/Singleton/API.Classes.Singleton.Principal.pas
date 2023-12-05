unit API.Classes.Singleton.Principal;

interface

uses
  API.Classes.Helpers.Enumerados, System.SysUtils,
  API.Interfaces.AbstractFactory.FabricaApi, API.Classes.Base.ViaCep;

type
  TSingletonAPI = class
  private
    FRequisicao: TApiViaCep;
    constructor Create(pTipoApi: TTipoApi);
  public
    property Requisicao: TApiViaCep read FRequisicao write FRequisicao;
    class function ObterInstancia(pTipoApi: TTipoApi): TSingletonAPI;
    class function NewInstance: TObject; override;
  end;

var
  FAPI: TSingletonAPI;

implementation

uses
  API.Classes.AbstractFactory.FabricaAPi;

{ TSingletonAPI }

constructor TSingletonAPI.Create(pTipoApi: TTipoApi);
var
  lFabricaApi: IFabricaApi;
begin
  lFabricaApi := TFabricaApi.Create;
//  ApiGenerica := lFabricaApi.ConsultarAPI(pTipoApi);
end;

class function TSingletonAPI.NewInstance: TObject;
begin
  if not Assigned(FAPI) then
  begin
    FAPI := TSingletonAPI(inherited NewInstance);
  end;

  Result := FAPI;
//  FAPI.ApiGenerica.ViaCep.
end;

class function TSingletonAPI.ObterInstancia(pTipoApi: TTipoApi): TSingletonAPI;
begin
  Result := TSingletonAPI.Create(pTipoApi);
end;

initialization

finalization
  FreeAndNil(FAPI);

end.
