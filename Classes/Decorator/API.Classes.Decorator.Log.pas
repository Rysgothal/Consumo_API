unit API.Classes.Decorator.Log;

interface

uses
  API.Classes.Helpers.Enumerados, API.Classes.Base.ViaCep, System.JSON;

//type
//  TDecoratorApiLog = class(TApiViaCep)
//  public
//    function ConsultarCep(const pCep: string): TJSONValue;
//  end;

implementation

uses
  System.SysUtils;

{ TDecoratorApiLog }

//function TDecoratorApiLog.ConsultarCep(const pCep: string): TJSONValue;
//begin
//  try
//    Writeln('Iniciando requisição para consultar CEP:', pCep);
//    Result := inherited ConsultarCep(pCep);
//    Writeln('Requisição para consultar CEP concluída com sucesso');
//  except
//    on E: Exception do
//    begin
//      Writeln('Erro durante a requisição para consultar CEP:', E.Message);
//      raise;
//    end;
//  end;
//end;

end.
