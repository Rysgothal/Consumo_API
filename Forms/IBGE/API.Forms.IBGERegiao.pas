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
    procedure FormCreate(Sender: TObject);
    procedure frmSelecionarRegiaobtnInformacoesClick(Sender: TObject);
    procedure frmSelecionarRegiaocmbRegiaoChange(Sender: TObject);
    procedure frmSelecionarRegiaobtnLimparClick(Sender: TObject);
  private
    procedure LimparFormulario;
    procedure PesquisarRegiao(pRegiao: string);
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

procedure TfrmIbgeRegiao.PesquisarRegiao(pRegiao: string);
var
  lPesquisa: string;
begin
  edbNavegador.ReinitializeWebView;

  lPesquisa := 'https://www.google.com.br/maps/search/Região ';
  lPesquisa := lPesquisa + pRegiao + ' do Brasil';
  edbNavegador.Navigate(lPesquisa);
end;

procedure TfrmIbgeRegiao.FormClose(Sender: TObject; var Action: TCloseAction);
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejRegiao);
  lApi.RemoverObserver(frmMetadadosRegiao);

  Action := TCloseAction.caFree;
  frmIbgeRegiao := nil;
end;

procedure TfrmIbgeRegiao.FormCreate(Sender: TObject);
var
  lApi: TApiSingleton;
begin
  lAPi := TApiSingleton.ObterInstancia(ejRegiao);
  lApi.AdicionarObserver(frmMetadadosRegiao);
  frmSelecionarRegiao.PreencherComboBoxRegioes;
end;

procedure TfrmIbgeRegiao.frmSelecionarRegiaobtnInformacoesClick(Sender: TObject);
begin
  pnlInformacoes.Visible := not pnlInformacoes.Visible;

  if pnlInformacoes.Visible then
  begin
    frmSelecionarRegiao.btnInformacoesClick(Sender);
  end;
end;

procedure TfrmIbgeRegiao.frmSelecionarRegiaobtnLimparClick(Sender: TObject);
begin
  frmMetadadosRegiao.LimparEdits;
  LimparFormulario;
end;

procedure TfrmIbgeRegiao.frmSelecionarRegiaocmbRegiaoChange(Sender: TObject);
begin
  frmSelecionarRegiao.cmbRegiaoChange(Sender);
  PesquisarRegiao(frmSelecionarRegiao.cmbRegiao.Text);
end;

procedure TfrmIbgeRegiao.LimparFormulario;
begin
  pnlInformacoes.Visible := False;
  edbNavegador.CloseWebView;
end;

end.
