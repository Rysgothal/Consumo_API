unit API.Classes.AbstractFactory.FabricaAPi;

interface

uses
  API.Interfaces.AbstractFactory.FabricaApi, API.Classes.Helpers.Enumerados;

type
  TFabricaApi = class(TInterfacedObject, IFabricaAPI)
  public
    function ConsultarIBGE: IApiIBGE;
    function ConsultarCep: IApiViaCep;
  end;

implementation

uses
  API.Classes.AbstractFactory.ProdutoViaCep,
  API.Classes.AbstractFactory.ProdutoIBGE;

{ TFabricaApi }

function TFabricaApi.ConsultarCep: IApiViaCep;
begin
  Result := TProdutoViaCep.Create;
end;

function TFabricaApi.ConsultarIBGE: IApiIBGE;
begin
  Result := TProdutosIBGE.Create;
end;

end.
