unit API.Classes.AbstractFactory.ProdutoViaCep;

interface

uses
  API.Interfaces.AbstractFactory.FabricaApi, API.Classes.Base.ViaCep;

type
  TProdutoViaCep = class(TInterfacedObject, IApiViaCep)
  public
    function ApiViaCep: TApiViaCep;
  end;

implementation

{ TProdutoViaCep }

function TProdutoViaCep.ApiViaCep: TApiViaCep;
begin
  Result := TApiViaCep.Create('https://viacep.com.br/ws/')
end;

end.
