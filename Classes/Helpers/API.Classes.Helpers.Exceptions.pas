unit API.Classes.Helpers.Exceptions;

interface

uses
  System.SysUtils;

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

implementation

end.
