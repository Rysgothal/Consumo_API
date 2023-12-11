unit API.Interfaces.Observer.Notificacao;

interface

uses
  System.JSON;

type
  IObserver = interface
    procedure Atualizar;
//    procedure Atualizar(pValor: string);
  end;

implementation

end.
