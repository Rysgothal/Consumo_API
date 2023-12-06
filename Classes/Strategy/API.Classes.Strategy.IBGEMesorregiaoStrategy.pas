unit API.Classes.Strategy.IBGEMesorregiaoStrategy;

interface

uses
  API.Interfaces.Strategy.Principal, REST.Client;

type
  TStrategyIBGEMesorregiao = class(TinterfacedObject, IApiStrategy)
  public
    procedure ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
  end;

implementation

{ TStrategyIBGEMesorregiao }

procedure TStrategyIBGEMesorregiao.ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
begin
  pRequest.Resource := '/{UF}/mesorregioes';
  pRequest.Params.AddUrlSegment('UF', pValorRequisicao);
  pRequest.Execute;
end;

end.
