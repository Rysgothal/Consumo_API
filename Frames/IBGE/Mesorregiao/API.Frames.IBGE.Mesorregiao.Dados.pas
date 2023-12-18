unit API.Frames.IBGE.Mesorregiao.Dados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  API.Interfaces.Observer.Notificacao, API.Classes.Helpers.Enumerados;

type
  TfrmDadosMesorregiao = class(TFrame, IObserver)
    lbeId: TLabeledEdit;
    lbeDimensao: TLabeledEdit;
    lbeLatitude: TLabeledEdit;
    lbeLongitude: TLabeledEdit;
    lblVezes: TLabel;
  private
    { Private declarations }
    procedure HabilitarComponentes(pHabilitar: Boolean = True);
  public
    procedure Atualizar;
    procedure LimparEdits;
    { Public declarations }
  end;

implementation

uses
  API.Classes.Singleton.Principal, API.Classes.JSON.IBGE.Metadados;

{$R *.dfm}

{ TfrmDadosMesorregiao }

procedure TfrmDadosMesorregiao.Atualizar;
var
  lApi: TApiSingleton;
  lMetadados: TJSONIBGEMetadado;
begin
  HabilitarComponentes;
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lMetadados := lApi.Mesorregiao.JSON.Metadados;   //

  lbeLatitude.Text := lMetadados.Centroide.Latitude;
  lbeLongitude.Text := lMetadados.Centroide.Longitude;
  lbeId.Text := lMetadados.Id;
  lbeDimensao.Text := lMetadados.Area.Dimensao + ' ' + lMetadados.Area.Unidade.Nome;
end;

procedure TfrmDadosMesorregiao.HabilitarComponentes(pHabilitar: Boolean);
begin
  lbeLatitude.Enabled := pHabilitar;
  lbeLongitude.Enabled := pHabilitar;
  lbeId.Enabled := pHabilitar;
  lbeDimensao.Enabled := pHabilitar;
  lblVezes.Enabled := pHabilitar;
end;

procedure TfrmDadosMesorregiao.LimparEdits;
begin
  lbeLatitude.Clear;
  lbeLongitude.Clear;
  lbeId.Clear;
  lbeDimensao.Clear;
  HabilitarComponentes(False);
end;

end.
