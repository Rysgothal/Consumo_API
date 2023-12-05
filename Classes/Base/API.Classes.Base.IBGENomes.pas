unit API.Classes.Base.IBGENomes;

interface

uses
  API.Classes.Base.Principal, System.JSON;

type
  TIBGENomes = class(TApi)
  public
    function ConsultarNomes(const pNome: string): TJSONValue;
  end;

implementation

uses
  API.Classes.Helpers.Exceptions, System.SysUtils;

{ TIBGENomes }

function TIBGENomes.ConsultarNomes(const pNome: string): TJSONValue;
begin
  if pNome = EmptyStr then
  begin
    raise ENomeNaoInformado.Create('Nome não inserido');
  end;

  ConfigurarRequisicao('/{nome}/', 'nome', pNome);

  if Request.Response.StatusCode <> 200 then
  begin
    raise EErroDeRota.Create('Erro de Rota');
  end;

  if Request.Response.ContentLength = 2 then
  begin
    raise ENomeSemRegistros.Create('Sem Dados sobre o nome informado');
  end;

  Result := Request.Response.JSONValue;
end;

end.
