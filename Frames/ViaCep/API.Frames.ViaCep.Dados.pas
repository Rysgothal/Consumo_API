unit API.Frames.ViaCep.Dados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  API.Interfaces.Observer.Notificacao, System.JSON, API.Classes.JSON.ViaCep;

type
  TfrmDadosViaCep = class(TFrame, IObserver)
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
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirMapa;
    procedure LimparComponentes;
    procedure PreencherEdits;
  public
    procedure Atualizar;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  API.Forms.Navegador, API.Classes.Singleton.Principal, API.Classes.Helpers.Enumerados;

procedure TfrmDadosViaCep.AbrirMapa;
var
  lPesquisa: string;
begin
  if lbeCep.Text = EmptyStr then
  begin
    Exit;
  end;

  if not Assigned(frmTelaNavegador) then
  begin
    lPesquisa := 'https://www.google.com.br/maps/search/' + lbeCep.Text;
    frmTelaNavegador := TfrmTelaNavegador.Create(lPesquisa);
  end;

  frmTelaNavegador.Show;
end;

procedure TfrmDadosViaCep.Atualizar;
begin
  PreencherEdits;
end;

procedure TfrmDadosViaCep.btnLimparClick(Sender: TObject);
begin
  LimparComponentes;
end;

procedure TfrmDadosViaCep.btnMapsClick(Sender: TObject);
begin
  AbrirMapa;
end;

procedure TfrmDadosViaCep.LimparComponentes;
begin
  for var I := 0 to Pred(Self.ComponentCount) do
  begin
    if not (Self.Components[I] is TLabeledEdit) then
    begin
      Continue;
    end;

    TLabeledEdit(Self.Components[I]).Clear;
  end;
end;

procedure TfrmDadosViaCep.PreencherEdits;
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ojViaCep);

  lbeCep.Text := lApi.ViaCep.JSON.Cep;
  lbeBairro.Text := lApi.ViaCep.JSON.Bairro;
  lbeLogradouro.Text := lApi.ViaCep.JSON.Logradouro;
  lbeCidade.Text := lApi.ViaCep.JSON.Cidade;
  lbeEstado.Text := lApi.ViaCep.JSON.Uf;
  lbeComplemento.Text := lApi.ViaCep.JSON.Complemento;
  lbeIBGE.Text := lApi.ViaCep.JSON.Ibge.ToString;
  lbeGIA.Text := lApi.ViaCep.JSON.Gia.ToString;
  lbeDDD.Text := lApi.ViaCep.JSON.Ddd.ToString;
  lbeSIAFI.Text := lApi.ViaCep.JSON.Siafi.ToString;
end;

end.
