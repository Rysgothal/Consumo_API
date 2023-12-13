unit API.Frames.ViaCep.BuscarCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  System.JSON, API.Interfaces.Observer.Subject;

type
  TfrmBuscarCep = class(TFrame, ISubject)
    lbeCepConsulta: TLabeledEdit;
    btnPesquisar: TButton;
    procedure lbeCepConsultaChange(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    procedure Notificar;
    procedure PesquisarCep;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  API.Classes.Helpers.Strings, API.Classes.Singleton.Principal,
  API.Classes.Helpers.Enumerados, API.Classes.JSON.ViaCep,
  API.Interfaces.Observer.Notificacao, API.Classes.Helpers.Exceptions;

{$R *.dfm}

procedure TfrmBuscarCep.btnPesquisarClick(Sender: TObject);
begin
  PesquisarCep;
end;

procedure TfrmBuscarCep.lbeCepConsultaChange(Sender: TObject);
begin
  TStringHelper.FormatarCep(lbeCepConsulta);
end;

procedure TfrmBuscarCep.Notificar;
var
  lCep: string;
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejViaCep);
  lCep := TStringHelper.DigitarSomenteNumeros(lbeCepConsulta.Text);
  lApi.ViaCep.ConsultarCep(lCep, lApi.Transformar);

  for var lObserver in lApi.Observers do
  begin
    if not Assigned(lObserver) then
    begin
      Continue;
    end;

    lObserver.Atualizar;
  end;
end;

procedure TfrmBuscarCep.PesquisarCep;
begin
  try
    Notificar;
  except
    on E: Exception do
    begin
      THelpersException.TratarExceptions(E);
    end;
  end;
end;

end.
