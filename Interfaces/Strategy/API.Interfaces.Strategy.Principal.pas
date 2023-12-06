unit API.Interfaces.Strategy.Principal;

interface

uses
  REST.Client;

type
  IApiStrategy = interface
    procedure ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
  end;

implementation

end.
