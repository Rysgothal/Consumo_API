unit API.Classes.Base.Principal;

interface

uses
  REST.Client;

type
  TApi = class
  private
    FRequest: TRESTRequest;
    FClient: TRESTClient;
  protected
    procedure ConfigurarRequisicao(pEstrutura, pParametro, pValorParametro: string);
  public
    property Request: TRESTRequest read FRequest write FRequest;
    constructor Create(const pURL: string);
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TApi }

procedure TApi.ConfigurarRequisicao(pEstrutura, pParametro, pValorParametro: string);
begin
  Request.Resource := pEstrutura;
  Request.Params.AddUrlSegment(pParametro, pValorParametro);
  Request.Execute;
end;

constructor TApi.Create(const pURL: string);
begin
  FClient := TRESTClient.Create(pURL);
  FRequest := TRESTRequest.Create(FClient);
end;

destructor TApi.Destroy;
begin
  FreeAndNil(FRequest);
  FreeAndNil(FClient);
  inherited;
end;

end.
