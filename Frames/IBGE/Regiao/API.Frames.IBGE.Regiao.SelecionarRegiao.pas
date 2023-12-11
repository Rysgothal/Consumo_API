unit API.Frames.IBGE.Regiao.SelecionarRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  API.Interfaces.Observer.Subject;

type
  TfrmSelecionarRegiao = class(TFrame, ISubject)
    cmbRegiao: TComboBox;
    lblRegiao: TLabel;
    btnInformacoes: TButton;
    btnLimpar: TButton;
    procedure cmbRegiaoChange(Sender: TObject);
    procedure btnInformacoesClick(Sender: TObject);
  private
    { Private declarations }
    procedure Notificar;
    procedure PesquisarRegiao;
  public
    { Public declarations }
    procedure PreencherComboBoxRegioes;
  end;

implementation

uses
  API.Classes.Singleton.Principal, API.Classes.JSON.IBGE.Regiao,
  API.Classes.Helpers.Enumerados, API.Interfaces.Observer.Notificacao;

{$R *.dfm}

{ TfrmSelecionarRegiao }

procedure TfrmSelecionarRegiao.btnInformacoesClick(Sender: TObject);
begin
  Notificar;
end;

procedure TfrmSelecionarRegiao.cmbRegiaoChange(Sender: TObject);
begin
//  PesquisarRegiao;
end;

procedure TfrmSelecionarRegiao.Notificar;
var
  lApi: TApiSingleton;
  lObserver: IObserver;
  lRegiaoSel: Integer;
begin
  lRegiaoSel := cmbRegiao.ItemIndex;

  if lRegiaoSel = -1 then
  begin
    Application.MessageBox('Selecione ao menos uma regi�o', 'Aten��o', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  lApi := TApiSingleton.ObterInstancia(ojRegiao);

  if not lApi.Observers.TryGetValue(ojRegiao, lObserver) then
  begin
    Exit;
  end;

  lApi.Regiao.ConsultarRegiao((lRegiaoSel + 1).ToString, lApi.Transformar);
  lObserver.Atualizar;
//  LimparEdits;
//  pnlInformacoes.Visible := not pnlInformacoes.Visible;
//
//  if not (pnlInformacoes.Visible) then
//  begin
//    Exit;
//  end;

//  PreencherEdits(RetornarMetadadosRegiao);
end;

procedure TfrmSelecionarRegiao.PesquisarRegiao;
//var
//  lApi: TApiSingleton;
//  lRegiao: TJSONIBGERegiao;
//  lRegiaoSel: Integer;
begin
//  lRegiaoSel := cmbRegiao.ItemIndex;
//
//  if lRegiaoSel = -1 then
//  begin
//    Application.MessageBox('Selecione ao menos uma regi�o', 'Aten��o', MB_OK + MB_ICONINFORMATION);
//    Exit;
//  end;
//
//  lApi := TApiSingleton.ObterInstancia(ojRegiao);
//  try
//    lRegiao := TJSONIBGERegiao(lApi.Transformar.ParaObjeto(lApi.Regiao.ConsultarRegiao((lRegiaoSel + 1).ToString)));
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

procedure TfrmSelecionarRegiao.PreencherComboBoxRegioes;
var
  lApi: TApiSingleton;
  lRegioes: TJSONIBGERegioes;
begin
  lApi := TApiSingleton.ObterInstancia(ojRegioes);

  try
    lRegioes := TJSONIBGERegioes(lApi.Transformar.ParaObjeto(lApi.Regiao.ListarRegioes));

    for var lRegiao in lRegioes.Regiao do
    begin
      cmbRegiao.Items.Add(lRegiao.Nome);
    end;
  finally
    FreeAndNil(lRegioes);
  end;
end;

end.
