unit API.Classes.Helpers.Exceptions;

interface

uses
  System.SysUtils, Vcl.Forms, Winapi.Windows;

type
  { API }
  EErroDeRota = class(Exception);

  { API ViaCep }
  ECepNaoInformado = class(Exception);
  ECepInvalido = class(Exception);
  ECepInexistente = class(Exception);

  { API IBGE Nomes }
  ENomeNaoInformado = class(Exception);
  ENomeSemRegistros = class(Exception);

  THelpersException = class abstract
  public
    class procedure TratarExceptions(pE: Exception);
  end;

implementation

{ THelpersException }

class procedure THelpersException.TratarExceptions(pE: Exception);
begin
  Application.MessageBox(PChar('Foi encontrado um inconsist�ncia: ' + sLineBreak + pE.Message),
    'Aten��o', MB_OK + MB_ICONINFORMATION);
end;

end.
