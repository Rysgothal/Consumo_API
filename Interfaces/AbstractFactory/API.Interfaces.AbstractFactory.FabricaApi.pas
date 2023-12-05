unit API.Interfaces.AbstractFactory.FabricaApi;

interface

uses
  API.Classes.Base.ViaCep, API.Classes.Base.IBGEMesorregiao,
  API.Classes.Base.IBGERegiao, API.Classes.Base.IBGENomes;

type
  IApiIBGE = interface
    function ApiMesorregiao: TIBGEMesorregiao;
    function ApiRegiao: TIBGERegiao;
    function ApiNome: TIBGENomes;
  end;

  IApiViaCep = interface
    function ApiViaCep: TApiViaCep;
  end;

  IFabricaAPI = interface
    function ConsultarIBGE: IApiIBGE;
    function ConsultarCep: IApiViaCep;
  end;

implementation

end.
