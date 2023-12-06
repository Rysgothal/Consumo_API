unit API.Classes.Strategy.IBGEMetadadosStrategy;

interface

uses
  API.Interfaces.Strategy.Principal, REST.Client;

type
  TStrategyIBGEMetadados = class(TinterfacedObject, IApiStrategy)
  public
    procedure ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
  end;

implementation

{ TStrategyIBGEMetadados }

procedure TStrategyIBGEMetadados.ConfigurarRequisicao(pRequest: TRESTRequest; pValorRequisicao: string);
begin
  pRequest.Resource := '/{id}/metadados';
  pRequest.Params.AddUrlSegment('id', pValorRequisicao);
  pRequest.Execute;
end;

end.
