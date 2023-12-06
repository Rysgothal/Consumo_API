unit API.Classes.Strategy.IBGERegioesStrategy;

interface

uses
  API.Interfaces.Strategy.Principal, REST.Client;

type
  TStrategyIBGERegiao = class(TinterfacedObject, IApiStrategy)
  public
    procedure ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
  end;

implementation

{ TStrategyIBGERegiao }

procedure TStrategyIBGERegiao.ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
begin
  pRequest.Resource := '/{Regiao}';
  pRequest.Params.AddUrlSegment('Regiao', pValorRequisicao);
  pRequest.Execute;
end;

end.
