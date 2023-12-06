unit API.Classes.Strategy.ViaCepStrategy;

interface

uses
  API.Interfaces.Strategy.Principal, REST.Client;

type
  TStrategyViaCep = class(TinterfacedObject, IApiStrategy)
  public
    procedure ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
  end;

implementation

{ TStrategyViaCep }

procedure TStrategyViaCep.ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
begin
  pRequest.Resource := '/{CEP}/json';
  pRequest.Params.AddUrlSegment('CEP', pValorRequisicao);
  pRequest.Execute;
end;

end.
