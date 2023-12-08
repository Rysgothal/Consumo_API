unit API.Frames.ViaCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmDadosViaCep = class(TFrame)
    lbeLogradouro: TLabeledEdit;
    lbeCidade: TLabeledEdit;
    lbeEstado: TLabeledEdit;
    lbeBairro: TLabeledEdit;
    lbeCep: TLabeledEdit;
    lbeComplemento: TLabeledEdit;
    lbeSIAFI: TLabeledEdit;
    lbeIBGE: TLabeledEdit;
    lbeGIA: TLabeledEdit;
    lbeDDD: TLabeledEdit;
    btnLimpar: TButton;
    btnMaps: TButton;
    procedure btnMapsClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirMapa;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses API.Forms.Navegador;

procedure TfrmDadosViaCep.AbrirMapa;
var
  lPesquisa: string;
begin
  if lbeCep.Text = EmptyStr then
  begin
    Exit;
  end;

  if not Assigned(frmNavegador) then
  begin
    lPesquisa := 'https://www.google.com.br/maps/search/' + lbeCep.Text;
    frmNavegador := TfrmNavegador.Create(lPesquisa);
  end;

  frmNavegador.Show;
end;

procedure TfrmDadosViaCep.btnMapsClick(Sender: TObject);
begin
  AbrirMapa;
end;

end.
