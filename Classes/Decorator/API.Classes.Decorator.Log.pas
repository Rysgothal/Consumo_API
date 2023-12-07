unit API.Classes.Decorator.Log;

interface

uses
  API.Classes.Helpers.Enumerados, API.Classes.Base.ViaCep, System.JSON;

type
  TDecoratorApiLog = class(TApiViaCep)
  public
    function ConsultarCep(const pCep: string): TJSONValue; override;
  end;

implementation

uses
  System.SysUtils;

{ TDecoratorApiLog }

function TDecoratorApiLog.ConsultarCep(const pCep: string): TJSONValue;
begin
  try
    Writeln('Iniciando requisi��o para consultar CEP:', pCep);
    Result := inherited ConsultarCep(pCep);
    Writeln('Requisi��o para consultar CEP conclu�da com sucesso');
  except
    on E: Exception do
    begin
      Writeln('Erro durante a requisi��o para consultar CEP:', E.Message);
      raise; // Re-raise the exception after logging
    end;
  end;
end;

end.
