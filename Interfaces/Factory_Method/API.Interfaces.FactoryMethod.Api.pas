unit API.Interfaces.FactoryMethod.Api;

interface

uses
  API.Classes.Helpers.Enumerados;

type
  IApiTipo = interface
    procedure Consultar(const pValor: string);
  end;

  IApiFabrica = interface
    function SelecionarApi(pApiConsulta: TApiConsulta): IApiTipo;
  end;

implementation

end.
