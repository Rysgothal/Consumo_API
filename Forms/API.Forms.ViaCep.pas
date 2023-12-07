unit API.Forms.ViaCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, System.StrUtils, JSON,
  System.ImageList, Vcl.ImgList, API.Classes.Helpers.Strings,
  API.Classes.Base.ViaCep, API.Classes.Decorator.Log;

type
  TfrmViaCep = class(TForm)
    pnlTop: TPanel;
    lbeCepConsulta: TLabeledEdit;
    btnPesquisar: TButton;
    pnlBottom: TPanel;
    lbeBairro: TLabeledEdit;
    lbeCep: TLabeledEdit;
    lbeLogradouro: TLabeledEdit;
    lbeCidade: TLabeledEdit;
    btnMaps: TButton;
    imgIcons: TImageList;
    btnLimpar: TButton;
    lbeEstado: TLabeledEdit;
    lbeComplemento: TLabeledEdit;
    lbeIBGE: TLabeledEdit;
    lbeGIA: TLabeledEdit;
    lbeDDD: TLabeledEdit;
    lbeSIAFI: TLabeledEdit;
    procedure lbeCepConsultaChange(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimparClick(Sender: TObject);
    procedure btnMapsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FViaCep: TApiViaCep;
    procedure PesquisarCep;
    procedure PreencherEdits(pJson: TJSONValue);
    procedure LimparFormulario;
    procedure LimparPnlBottom;
    procedure AbrirMapa;
  public
    { Public declarations }
  end;

var
  frmViaCep: TfrmViaCep;

implementation

uses
  REST.Json, API.Classes.JSON.ViaCep, API.Classes.Helpers.Enumerados,
  API.Forms.Navegador;

{$R *.dfm}

procedure TfrmViaCep.btnLimparClick(Sender: TObject);
begin
  LimparFormulario;
end;

procedure TfrmViaCep.btnPesquisarClick(Sender: TObject);
begin
  PesquisarCep;
end;

procedure TfrmViaCep.btnMapsClick(Sender: TObject);
begin
  btnPesquisar.Click;
  AbrirMapa;
end;

procedure TfrmViaCep.PesquisarCep;
var
  lCep: string;
  lJson: TJSONValue;
  lApiViaCepLog: TApiViaCep;
begin
  lCep := TStringHelper.DigitarSomenteNumeros(lbeCepConsulta.Text);

  try
    lApiViaCepLog := TDecoratorApiLog.Create('https://viacep.com.br/ws/', taViaCep);
    lJson := lApiViaCepLog.ConsultarCep(lCep);

    PreencherEdits(lJson);
  except
//    on ECepNaoExiste do
//    begin
//      Application.MessageBox(pChar('O Cep informado não existe'), 'Cep Inexistente', MB_OK + MB_ICONINFORMATION);
//      LimparPnlBottom;
//      FocarEdtCep;
//    end;
//
//    on EErroDeRota do
//    begin
//      Application.MessageBox(pChar('Não foi possivel trazer as informações, Verifique'), 'Rota não estabelecida', MB_OK +
//        MB_ICONINFORMATION);
//      LimparPnlBottom;
//      FocarEdtCep;
//    end;
//
//    on EValorNaoInserido do
//    begin
//      Application.MessageBox(pChar('O Cep não foi Informado'), 'Campo Vazio', MB_OK + MB_ICONINFORMATION);
//      LimparPnlBottom;
//      FocarEdtCep;
//    end;
//
//    on ECepInvalido do
//    begin
//      Application.MessageBox(pChar('O Cep Informado não esta completo, por favor verifique'), 'Campo Vazio', MB_OK +
//        MB_ICONINFORMATION);
//      LimparPnlBottom;
//      FocarEdtCep;
//    end;

    on Exception do
    begin
      Application.MessageBox(pChar('Falha inesperada, por favor tente novamente'), 'Falha Desconhecida', MB_OK +
        MB_ICONINFORMATION);
    end;
  end;
end;

procedure TfrmViaCep.PreencherEdits(pJson: TJSONValue);
var
  lInfoCEP: TJSONViaCep;
begin
  lInfoCEP := TJson.JsonToObject<TJSONViaCep>(TJSONObject(pJson));

  lbeCep.Text := lInfoCEP.Cep;
  lbeBairro.Text := lInfoCEP.Bairro;
  lbeLogradouro.Text := lInfoCEP.Logradouro;
  lbeCidade.Text := lInfoCEP.Cidade;
  lbeEstado.Text := lInfoCEP.Uf;
  lbeComplemento.Text := lInfoCEP.Complemento;
  lbeIBGE.Text := lInfoCEP.Ibge.ToString;
  lbeGIA.Text := lInfoCEP.Gia.ToString;
  lbeDDD.Text := lInfoCEP.Ddd.ToString;
  lbeSIAFI.Text := lInfoCEP.Siafi.ToString;
end;

procedure TfrmViaCep.LimparFormulario;
begin
  lbeCepConsulta.Clear;
  LimparPnlBottom;
end;

procedure TfrmViaCep.LimparPnlBottom;
begin
  lbeBairro.Clear;
  lbeCep.Clear;
  lbeLogradouro.Clear;
  lbeCidade.Clear;
  lbeEstado.Clear;
end;

procedure TfrmViaCep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FViaCep.Destroy;
  Action := TCloseAction.caFree;
  frmViaCep := nil;
end;

procedure TfrmViaCep.FormCreate(Sender: TObject);
begin
  if not Assigned(FViaCep) then
  begin
    FViaCep := TApiViaCep.Create('https://viacep.com.br/ws/', taViaCep);
  end;
end;

procedure TfrmViaCep.lbeCepConsultaChange(Sender: TObject);
begin
  TStringHelper.FormatarCep(lbeCepConsulta);
end;

procedure TfrmViaCep.AbrirMapa;
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

end.
