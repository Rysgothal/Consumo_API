unit API.Classes.AbstractFactory.ProdutoIBGE;

interface

uses
  API.Interfaces.AbstractFactory.FabricaApi, API.Classes.Base.IBGEMesorregiao,
  API.Classes.Base.IBGERegiao, API.Classes.Base.IBGENomes;

type
  TProdutosIBGE = class(TInterfacedObject, IApiIBGE)
  public
    function ApiMesorregiao: TIBGEMesorregiao;
    function ApiRegiao: TIBGERegiao;
    function ApiNome: TIBGENomes;
//    function ApiMesorregiao: TIBGEMesorregiao;
  end;

implementation

{ TProdutosIBGE }

function TProdutosIBGE.ApiMesorregiao: TIBGEMesorregiao;
begin
  Result := TIBGEMesorregiao.Create('https://servicodados.ibge.gov.br/api/v3/malhas/mesorregioes/');
end;

function TProdutosIBGE.ApiNome: TIBGENomes;
begin
  Result := TIBGENomes.Create('https://servicodados.ibge.gov.br/api/v2/censos/nomes/');
end;

function TProdutosIBGE.ApiRegiao: TIBGERegiao;
begin
  Result := TIBGERegiao.Create('https://servicodados.ibge.gov.br/api/v3/malhas/regioes/');
end;

end.
