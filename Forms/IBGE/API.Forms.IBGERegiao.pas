unit API.Forms.IBGERegiao;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Winapi.Windows, System.Math,
  System.JSON, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, API.DataModules.Principal,
  API.Classes.Base.IBGE.Regiao, API.Classes.JSON.IBGE.Metadados, API.Frames.IBGE.Regiao.SelecionarRegiao,
  API.Frames.IBGE.Regiao.InformacaoRegiao;

type
  TfrmIbgeRegiao = class(TForm)
    pnlTop: TPanel;
    edbNavegador: TEdgeBrowser;
    pnlInformacoes: TPanel;
    frmSelecionarRegiao: TfrmSelecionarRegiao;
    frmMetadadosRegiao: TfrmDadosRegiao;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimparClick(Sender: TObject);
    procedure btnInformacoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbRegiaoChange(Sender: TObject);
    procedure frmSelecionarRegiaobtnInformacoesClick(Sender: TObject);
    procedure frmSelecionarRegiaocmbRegiaoChange(Sender: TObject);
  private
    procedure PreencherEdits(pJson: TJSONValue);
    procedure LimparFormulario;
//    procedure InserirRegioesComboBox;
    procedure BuscarInformacoesPnlInformacoes;
    function RetornarMetadadosRegiao: TJSONValue;
    procedure BuscarRegiao;
    procedure PesquisarRegiao(pRegiao: string);
    function BuscarSiglaRegiao: string;
    procedure MensagemItemNaoSelecionado;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIbgeRegiao: TfrmIbgeRegiao;

implementation

uses
  API.Classes.JSON.IBGE.Regiao, REST.Json, API.Classes.Helpers.Enumerados,
  API.Classes.Base.Principal, API.Classes.Base.IBGE.Metadados,
  API.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmIbgeRegiao.btnLimparClick(Sender: TObject);
begin
  LimparFormulario;
end;

procedure TfrmIbgeRegiao.BuscarInformacoesPnlInformacoes;
begin
//  if cmbRegiao.ItemIndex = -1 then
//  begin
//    MensagemItemNaoSelecionado;
//    Exit;
//  end;
//
//  LimparEdits;
//  pnlInformacoes.Visible := not pnlInformacoes.Visible;
//
//  if not (pnlInformacoes.Visible) then
//  begin
//    Exit;
//  end;
//
//  PreencherEdits(RetornarMetadadosRegiao);
end;

function TfrmIbgeRegiao.RetornarMetadadosRegiao: TJSONValue;
//var
//  lJson: TJSONValue;
//  lApiIBGEMetadados: TApiIBGEMetadados;
begin
//  lApiIBGEMetadados := TApiIBGEMetadados.ObterInstancia;
//  lJson := lApiIBGEMetadados.ConsultarMetadados((cmbRegiao.ItemIndex + 1).ToString);
//
//  Result := lJson;
end;

procedure TfrmIbgeRegiao.BuscarRegiao;
//var
//  lApi: TApiSingleton;
//  lRegiao: TJSONIBGERegiao;
//  lRegiaoSel: Integer;
begin
//  lRegiaoSel := cmbRegiao.ItemIndex + 1;
//
//  if lRegiaoSel = 0 then
//  begin
//    MensagemItemNaoSelecionado;
//    Exit;
//  end;
//
//  lApi := TApiSingleton.ObterInstancia(ojRegiao);
//  try
//    lRegiao := TJSONIBGERegiao(lApi.Transformar.ParaObjeto(lApi.Regiao.ConsultarRegiao(lRegiaoSel.ToString)));
//    PesquisarRegiao(lRegiao.Nome);
//
//    if pnlInformacoes.Visible then
//    begin
//      PreencherEdits(RetornarMetadadosRegiao);
//    end;
//  finally
//    FreeAndNil(lRegiao);
//  end;
end;

function TfrmIbgeRegiao.BuscarSiglaRegiao: string;
//var
//  lJSON: TJSONValue;
//  lRegiao: TJSONIBGERegiao;
//  lApiIBGERegiao: TApiIBGERegiao;
begin
//  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(ojRegiao);
//
//  try
//    lJSON := lApiIBGERegiao.ConsultarRegiao((cmbRegiao.ItemIndex + 1).ToString);
//    lRegiao := TJSONIBGERegiao(lApiIBGERegiao.Transformar.ParaObjeto(lJSON));
//    Result := lRegiao.Sigla;
//  finally
//    FreeAndNil(lRegiao);
//  end;
end;

procedure TfrmIbgeRegiao.MensagemItemNaoSelecionado;
begin
  Application.MessageBox('Porfavor, selecione ao menos uma Região', 'Atenção', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmIbgeRegiao.PesquisarRegiao(pRegiao: string);
var
  lPesquisa: string;
begin
  edbNavegador.ReinitializeWebView;

  lPesquisa := 'https://www.google.com.br/maps/search/Região ';
  lPesquisa := lPesquisa + pRegiao + ' do Brasil';
  edbNavegador.Navigate(lPesquisa);
end;

procedure TfrmIbgeRegiao.btnInformacoesClick(Sender: TObject);
begin
  BuscarInformacoesPnlInformacoes;
end;

procedure TfrmIbgeRegiao.cmbRegiaoChange(Sender: TObject);
begin
  BuscarRegiao;
end;

procedure TfrmIbgeRegiao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmIbgeRegiao := nil;
end;

procedure TfrmIbgeRegiao.FormCreate(Sender: TObject);
var
  lApi: TApiSingleton;
begin
  lAPi := TApiSingleton.ObterInstancia(ojRegiao);
  lApi.AdicionarObserver(ojRegiao, frmMetadadosRegiao);
  frmSelecionarRegiao.PreencherComboBoxRegioes;

//  InserirRegioesComboBox;
end;

procedure TfrmIbgeRegiao.frmSelecionarRegiaobtnInformacoesClick(Sender: TObject);
begin
  pnlInformacoes.Visible := not pnlInformacoes.Visible;
  frmSelecionarRegiao.btnInformacoesClick(Sender);
end;

procedure TfrmIbgeRegiao.frmSelecionarRegiaocmbRegiaoChange(Sender: TObject);
begin
  frmSelecionarRegiao.cmbRegiaoChange(Sender);
  PesquisarRegiao(frmSelecionarRegiao.cmbRegiao.Text);
end;

//procedure TfrmIbgeRegiao.InserirRegioesComboBox;
//var
//  lApi: TApiSingleton;
//  lRegioes: TJSONIBGERegioes;
//begin
//  lApi := TApiSingleton.ObterInstancia(ojRegioes);
//
//  try
//    lRegioes := TJSONIBGERegioes(lApi.Transformar.ParaObjeto(lApi.Regiao.ListarRegioes));
//
//    for var lRegiao in lRegioes.Regiao do
//    begin
//      cmbRegiao.Items.Add(lRegiao.Nome);
//    end;
//  finally
//    FreeAndNil(lRegioes);
//  end;
//end;

procedure TfrmIbgeRegiao.PreencherEdits(pJson: TJSONValue);
//var
//  lMetadados: TJSONIBGEMetadados;
//  lApiIBGEMetadados: TApiIBGEMetadados;
begin
//  lApiIBGEMetadados := TApiIBGEMetadados.ObterInstancia;
//  lMetadados := TJSONIBGEMetadados(lApiIBGEMEtadados.Transformar.ParaObjeto(pJson));
//
//  try
//    for var lRegiao in lMetadados.Metadados do
//    begin
//      lbeNome.Text := cmbRegiao.Text;
//      lbeCentroideLong.Text := lRegiao.CentroIde.Longitude;
//      lbeId.Text := lRegiao.Id;
//      lbeArea.Text := lRegiao.Area.Dimensao + ' ' + lRegiao.Area.Unidade.Id;
//      lbeNivelGeografico.Text := lRegiao.NivelGeografico;
//      lbeCentroideLat.Text := lRegiao.CentroIde.Latitude;
//      lbeSigla.Text := BuscarSiglaRegiao;
//    end;
//  finally
//    FreeAndNil(lMetadados);
//  end;
end;

procedure TfrmIbgeRegiao.LimparFormulario;
begin
  pnlInformacoes.Visible := False;
  edbNavegador.CloseWebView;
end;

end.
