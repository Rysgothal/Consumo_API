unit API.Classes.Strategy.IBGEEstadosStrategy;

interface

uses
  API.Interfaces.Strategy.Principal, REST.Client;

type
  TStrategyIBGEEstados = class(TinterfacedObject, IApiStrategy)
  public
    procedure ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
  end;

implementation

{ TStrategyIBGEEstados }

procedure TStrategyIBGEEstados.ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
begin
  pRequest.Resource := '/{Regiao}/estados';
  pRequest.Params.AddUrlSegment('Regiao', pValorRequisicao);
  pRequest.Execute;
end;

end.
