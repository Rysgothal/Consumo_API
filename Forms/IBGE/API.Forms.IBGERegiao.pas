unit API.Forms.IBGERegiao;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Winapi.Windows, System.Math,
  System.JSON, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge,
  API.Classes.Base.IBGE.Regiao, API.Classes.JSON.IBGE.Metadados;

type
  TfrmIbgeRegiao = class(TForm)
    pnlTop: TPanel;
    imgIcons: TImageList;
    cmbRegiao: TComboBox;
    lblRegiao: TLabel;
    edbNavegador: TEdgeBrowser;
    pnlInformacoes: TPanel;
    lbeId: TLabeledEdit;
    lbeCentroideLong: TLabeledEdit;
    lbeArea: TLabeledEdit;
    lbeNivelGeografico: TLabeledEdit;
    lbeCentroideLat: TLabeledEdit;
    lbeNome: TLabeledEdit;
    lbeSigla: TLabeledEdit;
    btnLimpar: TButton;
    btnInformacoes: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnInformacoesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbRegiaoChange(Sender: TObject);
  private
    procedure PreencherEdits(pJson: TJSONValue);
    procedure LimparFormulario;
    procedure LimparEdits;
    procedure InserirRegioesComboBox;
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
  API.Classes.Base.Principal, API.Classes.Base.IBGE.Metadados;

{$R *.dfm}

procedure TfrmIbgeRegiao.btnLimparClick(Sender: TObject);
begin
  LimparFormulario;
end;

procedure TfrmIbgeRegiao.btnPesquisarClick(Sender: TObject);
begin
  LimparEdits;
end;

procedure TfrmIbgeRegiao.BuscarInformacoesPnlInformacoes;
begin
  if cmbRegiao.ItemIndex = -1 then
  begin
    MensagemItemNaoSelecionado;
    Exit;
  end;

  LimparEdits;
  pnlInformacoes.Visible := not pnlInformacoes.Visible;

  if not (pnlInformacoes.Visible) then
  begin
    Exit;
  end;

  PreencherEdits(RetornarMetadadosRegiao);
end;

function TfrmIbgeRegiao.RetornarMetadadosRegiao: TJSONValue;
var
  lJson: TJSONValue;
  lApiIBGEMetadados: TApiIBGEMetadados;
begin
  lApiIBGEMetadados := TApiIBGEMetadados.ObterInstancia(opMetadados);
  lJson := lApiIBGEMetadados.ConsultarMetadados((cmbRegiao.ItemIndex + 1).ToString);

  Result := lJson;
end;

procedure TfrmIbgeRegiao.BuscarRegiao;
var
  lRegiaoSel: Integer;
  lApiIBGERegiao: TApiIBGERegiao;
  lRegiao: TJSONIBGERegiao;
  lJSON: TJSONValue;
begin
  lRegiaoSel := cmbRegiao.ItemIndex;

  if lRegiaoSel = -1 then
  begin
    MensagemItemNaoSelecionado;
    Exit;
  end;

  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(opRegiao);

  try
    lJSON := lApiIBGERegiao.ConsultarRegiao((lRegiaoSel + 1).ToString);
    lRegiao := TJSONIBGERegiao(lApiIBGERegiao.Transformar.ParaObjeto(lJSON));

    PesquisarRegiao(lRegiao.Nome);

    if pnlInformacoes.Visible then
    begin
      PreencherEdits(RetornarMetadadosRegiao);
    end;
  finally
    FreeAndNil(lRegiao);
//    FreeAndNil(lJSON);
  end;
end;

function TfrmIbgeRegiao.BuscarSiglaRegiao: string;
var
  lJSON: TJSONValue;
  lRegiao: TJSONIBGERegiao;
  lApiIBGERegiao: TApiIBGERegiao;
begin
  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(opRegiao);

  try
    lJSON := lApiIBGERegiao.ConsultarRegiao((cmbRegiao.ItemIndex + 1).ToString);
    lRegiao := TJSONIBGERegiao(lApiIBGERegiao.Transformar.ParaObjeto(lJSON));
    Result := lRegiao.Sigla;
  finally
    FreeAndNil(lRegiao);
  end;
end;

procedure TfrmIbgeRegiao.MensagemItemNaoSelecionado;
begin
  Application.MessageBox('Porfavor, selecione ao menos uma Região', 'Atenção', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmIbgeRegiao.PesquisarRegiao(pRegiao: string);
var
  vPesquisa: string;
begin
  edbNavegador.ReinitializeWebView;

  vPesquisa := 'https://www.google.com.br/maps/search/Região ';
  vPesquisa := vPesquisa + pRegiao + ' do Brasil';
  edbNavegador.Navigate(vPesquisa);
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
begin
  InserirRegioesComboBox;
end;

procedure TfrmIbgeRegiao.InserirRegioesComboBox;
var
  lJson: TJSONValue;
  lRegioes: TJSONIBGERegioes;
  lApiIBGERegiao: TApiIBGERegiao;
begin
  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(opRegioes);

  try
    lJson := lApiIBGERegiao.ListarRegioes;
    lRegioes := TJSONIBGERegioes(lApiIBGERegiao.Transformar.ParaObjeto(lJson));

    cmbRegiao.Clear;
    for var lRegiao in lRegioes.Regiao do
    begin
      cmbRegiao.Items.Add(lRegiao.Nome);            // Revisar não liberando da memória
    end;
  finally
    FreeAndNil(lRegioes);
  end;
end;

procedure TfrmIbgeRegiao.PreencherEdits(pJson: TJSONValue);
var
  lMetadados: TJSONIBGEMetadados;
  lApiIBGEMetadados: TApiIBGEMetadados;
begin
  lApiIBGEMetadados := TApiIBGEMetadados.ObterInstancia(opMetadados);
  lMetadados := TJSONIBGEMetadados(lApiIBGEMEtadados.Transformar.ParaObjeto(pJson));

  try
    for var lRegiao in lMetadados.Metadados do
    begin
      lbeNome.Text := cmbRegiao.Text;
      lbeCentroideLong.Text := lRegiao.CentroIde.Longitude;
      lbeId.Text := lRegiao.Id;
      lbeArea.Text := lRegiao.Area.Dimensao + ' ' + lRegiao.Area.Unidade.Id;
      lbeNivelGeografico.Text := lRegiao.NivelGeografico;
      lbeCentroideLat.Text := lRegiao.CentroIde.Latitude;
      lbeSigla.Text := BuscarSiglaRegiao;
    end;
  finally
    FreeAndNil(lMetadados);
  end;
end;

procedure TfrmIbgeRegiao.LimparEdits;
begin
  lbeId.Clear;
  lbeCentroideLong.Clear;
  lbeArea.Clear;
  lbeNivelGeografico.Clear;
  lbeCentroideLat.Clear;
  lbeNome.Clear;
  lbeSigla.Clear;
end;

procedure TfrmIbgeRegiao.LimparFormulario;
begin
  pnlInformacoes.Visible := False;
  LimparEdits;
  cmbRegiao.ItemIndex := -1;
  edbNavegador.CloseWebView;
end;

end.
