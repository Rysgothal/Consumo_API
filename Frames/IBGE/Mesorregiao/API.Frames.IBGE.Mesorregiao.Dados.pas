unit API.Frames.IBGE.Mesorregiao.Dados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  API.Interfaces.Observer.Notificacao;

type
  TfrmDadosMesorregiao = class(TFrame, IObserver)
    lbeId: TLabeledEdit;
    lbeDimensao: TLabeledEdit;
    lbeLatitude: TLabeledEdit;
    lbeLongitude: TLabeledEdit;
  private
    { Private declarations }
  public
    procedure Atualizar;
    { Public declarations }
  end;

implementation

uses
  API.Classes.Singleton.Principal;

{$R *.dfm}

{ TfrmDadosMesorregiao }

procedure TfrmDadosMesorregiao.Atualizar;
var
  lApi: TApiSingleton;
begin

end;

end.
