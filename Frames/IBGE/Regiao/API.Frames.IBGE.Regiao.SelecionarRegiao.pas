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
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    procedure Notificar;
    procedure SelecionarRegiao;
    procedure Limpar;
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

procedure TfrmSelecionarRegiao.btnLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TfrmSelecionarRegiao.cmbRegiaoChange(Sender: TObject);
begin
  SelecionarRegiao;
end;

procedure TfrmSelecionarRegiao.Notificar;
var
  lApi: TApiSingleton;
  lRegiaoSel: Integer;
begin
  lRegiaoSel := cmbRegiao.ItemIndex;

  if lRegiaoSel = -1 then
  begin
    Application.MessageBox('Selecione ao menos uma região', 'Atenção', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  lApi := TApiSingleton.ObterInstancia(ejRegiao);
  lApi.Regiao.ConsultarRegiao((lRegiaoSel + 1).ToString, lApi.Transformar);

  for var lObserver in lApi.Observers do
  begin
    if not Assigned(lObserver) then
    begin
      Continue;
    end;

    lObserver.Atualizar;
  end;
end;

procedure TfrmSelecionarRegiao.PreencherComboBoxRegioes;
var
  lApi: TApiSingleton;
  lRegioes: TJSONIBGERegioes;
begin
  lApi := TApiSingleton.ObterInstancia(ejRegioes);

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

procedure TfrmSelecionarRegiao.SelecionarRegiao;
begin
  Notificar;

  if not btnInformacoes.Enabled then
  begin
    btnInformacoes.Enabled := True;
  end;
end;

procedure TfrmSelecionarRegiao.Limpar;
begin
  cmbRegiao.ItemIndex := -1;
  btnInformacoes.Enabled := False;
end;

end.
