unit API.Classes.FactoryMethod.Fabrica;

interface

uses
  API.Interfaces.FactoryMethod.Api, API.Classes.Helpers.Enumerados;

type
  TFabricaApi = class(TInterfacedObject, IApiFabrica)
  public
    function SelecionarApi(pApiConsulta: TApiConsulta): IApiTipo;
  end;

implementation

uses
  API.Classes.Base.ViaCep;

{ TFabricaApi }

function TFabricaApi.SelecionarApi(pApiConsulta: TApiConsulta): IApiTipo;
begin
  case pApiConsulta of
    acViaCep: TApiViaCep.Create('', pApiConsulta);
    acMesorregiao: ;
    acRegiao: ;
    acMetadados: ;
  end;
end;

end.
