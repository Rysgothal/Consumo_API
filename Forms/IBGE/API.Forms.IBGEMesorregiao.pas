unit API.Forms.IBGEMesorregiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  System.JSON, System.Generics.Collections, Vcl.Mask, REST.Json, API.DataModules.Principal,
  API.Classes.JSON.IBGE.Metadados, API.Classes.Helpers.Exceptions,
  API.Classes.Base.IBGE.Mesorregiao, API.Classes.JSON.IBGE.Regiao,
  API.Classes.JSON.IBGE.UF, API.Classes.JSON.IBGE.Mesorregiao,
  API.Classes.Base.IBGE.Estados, API.Classes.Base.IBGE.Metadados,
  API.Classes.Singleton.Principal, API.Frames.IBGE.Mesorregiao.Dados, API.Frames.IBGE.Mesorregiao.DadosMaisInfo,
  API.Classes.Helpers.Enumerados;

type
  TfrmIbgeMesorregiao = class(TForm)
    pnlTop: TPanel;
    lblRegiao: TLabel;
    cmbRegiao: TComboBox;
    cmbEstado: TComboBox;
    lblEstado: TLabel;
    pnlBotton: TPanel;
    cmbMesorregiao: TComboBox;
    lblNomeMesorregiao: TLabel;
    btnLimpar: TButton;
    btnMaps: TButton;
    btnPrimeiroRegistro: TButton;
    btnAnterior: TButton;
    btnProximo: TButton;
    btnUltimoRegistro: TButton;
    frmDadosMesorregiao: TfrmDadosMesorregiao;
    frmMesorregiaoMaisInfo: TfrmMesorregiaoMaisInfo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimparClick(Sender: TObject);
    procedure btnMapsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbRegiaoChange(Sender: TObject);
    procedure cmbEstadoChange(Sender: TObject);
    procedure cmbMesorregiaoChange(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnPrimeiroRegistroClick(Sender: TObject);
    procedure btnUltimoRegistroClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure PopularMesorregioes;
    procedure PopularEstados;
    procedure PopularRegioes;
    procedure SelecionarMesorregiao;
    procedure SelecionarEstado;
    procedure LimparFormulario;
    procedure LimparBottonPainel;
    procedure AbrirMapa;
    procedure HabilitarSelecaoMesorregiao(pBoolean: Boolean = True);
    procedure HabilitarSelecaoEstados(pBoolean: Boolean = True);
    procedure HabilitarBotoesNavegacao(pBoolean: Boolean = True);
    function RetornarIdMesorregiao(pSiglaEstado: string): Integer;
    procedure SelecionarItemMesorregiao(pItemLimite, pItem: Integer);
    procedure NavegarMesorregioes(pDirecao: TNavegarBotoes);
    procedure SelecionarPrimeiraMesorregiao;
    procedure SelecionarAnteriorMesorregiao;
    procedure SelecionarProximaMesorregiao;
    procedure SelecionarUltimaMesorregiao;
    procedure LimparComponentesAoEscolherRegiao;
    procedure RemoverObservers;
    procedure AdicionarObservers;
    function RetornarURLParaPesquisa: string;
  public
    { Public declarations }
  end;

var
  frmIbgeMesorregiao: TfrmIbgeMesorregiao;

implementation

uses
  API.Forms.Navegador, System.SysUtils, System.NetEncoding, API.Classes.Base.IBGE.Regiao;

{$R *.dfm}

procedure TfrmIbgeMesorregiao.btnAnteriorClick(Sender: TObject);
begin
  NavegarMesorregioes(nbAnterior);
end;

procedure TfrmIbgeMesorregiao.btnLimparClick(Sender: TObject);
begin
  LimparFormulario;
end;

procedure TfrmIbgeMesorregiao.btnMapsClick(Sender: TObject);
begin
  AbrirMapa;
end;

procedure TfrmIbgeMesorregiao.btnPrimeiroRegistroClick(Sender: TObject);
begin
  NavegarMesorregioes(nbPrimeiro);
end;

procedure TfrmIbgeMesorregiao.btnProximoClick(Sender: TObject);
begin
  NavegarMesorregioes(nbProximo);
end;

procedure TfrmIbgeMesorregiao.btnUltimoRegistroClick(Sender: TObject);
begin
  NavegarMesorregioes(nbUltimo);
end;

procedure TfrmIbgeMesorregiao.LimparBottonPainel;
begin
  frmMesorregiaoMaisInfo.Limpar;
  frmDadosMesorregiao.LimparEdits;
end;

procedure TfrmIbgeMesorregiao.LimparComponentesAoEscolherRegiao;
begin
  frmDadosMesorregiao.LimparEdits;
  frmMesorregiaoMaisInfo.Limpar;
  cmbMesorregiao.Clear;
  cmbEstado.Clear;
end;

procedure TfrmIbgeMesorregiao.SelecionarEstado;
begin
  LimparBottonPainel;

  if cmbEstado.ItemIndex = -1 then
  begin
    HabilitarSelecaoMesorregiao(False);
    Exit;
  end;

  HabilitarSelecaoMesorregiao;
  PopularMesorregioes;
end;

procedure TfrmIbgeMesorregiao.RemoverObservers;
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lApi.RemoverObserver(frmDadosMesorregiao);
  lApi.RemoverObserver(frmMesorregiaoMaisInfo);
end;

procedure TfrmIbgeMesorregiao.AdicionarObservers;
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lApi.AdicionarObserver(frmDadosMesorregiao);
  lApi.AdicionarObserver(frmMesorregiaoMaisInfo);
end;

function TfrmIbgeMesorregiao.RetornarURLParaPesquisa: string;
var
  lUrlEncode: TURLEncoding;
begin
  lUrlEncode := TURLEncoding.Create;

  try
    Result  := 'https://servicodados.ibge.gov.br/api/v3/malhas/mesorregioes/' + frmDadosMesorregiao.lbeId.Text +
      '?formato=application/vnd';

    Result := lUrlEncode.Encode(Result);
    Result := 'http://geojson.io/#data=data:text/x-url,' + Result + '.geo+json';
  finally
    FreeAndNil(lUrlEncode);
  end;
end;

procedure TfrmIbgeMesorregiao.HabilitarBotoesNavegacao(pBoolean: Boolean = True);
begin
  btnPrimeiroRegistro.Enabled := pBoolean;
  btnAnterior.Enabled := pBoolean;
  btnProximo.Enabled := pBoolean;
  btnUltimoRegistro.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.HabilitarSelecaoMesorregiao(pBoolean: Boolean = True);
begin
  lblNomeMesorregiao.Enabled := pBoolean;
  cmbMesorregiao.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.cmbEstadoChange(Sender: TObject);
begin
  SelecionarEstado;
end;

procedure TfrmIbgeMesorregiao.cmbMesorregiaoChange(Sender: TObject);
begin
  SelecionarMesorregiao;
end;

procedure TfrmIbgeMesorregiao.cmbRegiaoChange(Sender: TObject);
begin
  PopularEstados;
end;

procedure TfrmIbgeMesorregiao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RemoverObservers;
  Action := TCloseAction.caFree;
  frmIbgeMesorregiao := nil;
end;

procedure TfrmIbgeMesorregiao.FormCreate(Sender: TObject);
begin
  AdicionarObservers;
  PopularRegioes;
end;

procedure TfrmIbgeMesorregiao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

procedure TfrmIbgeMesorregiao.HabilitarSelecaoEstados(pBoolean: Boolean = True);
begin
  lblEstado.Enabled := pBoolean;
  cmbEstado.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.AbrirMapa;
var
  lURL: string;
begin
  if cmbMesorregiao.ItemIndex = -1 then
  begin
    Application.MessageBox('Nenhuma mesorregião selecionada, porfavor selecione!', 'Sem Mesorregiao', MB_OK +
    MB_ICONINFORMATION);
    Exit;
  end;

  if not Assigned(frmTelaNavegador) then
  begin
    lUrl := RetornarURLParaPesquisa;
    frmTelaNavegador := TfrmTelaNavegador.Create(lURL);
  end;

  frmTelaNavegador.Show;
end;

procedure TfrmIbgeMesorregiao.SelecionarMesorregiao;
var
  lApi: TApiSingleton;
  lSiglaEstado: string;
  lId: Integer;
begin
  if cmbMesorregiao.ItemIndex = -1 then
  begin
    HabilitarBotoesNavegacao(False);
    Exit;
  end;

  lSiglaEstado := Copy(cmbEstado.Text, 1, 2);
  lId := RetornarIdMesorregiao(lSiglaEstado);
  lApi := TApiSingleton.ObterInstancia(ejMetadados);
  lApi.Mesorregiao.ConsultarMetadadosMesorregiao(lID.ToString);

  for var lObserver in lApi.Observers do
  begin
    if not Assigned(lObserver) then
    begin
      Continue;
    end;

    lObserver.Atualizar;
  end;

  HabilitarBotoesNavegacao;
  btnMaps.Enabled := True;
end;

procedure TfrmIbgeMesorregiao.SelecionarPrimeiraMesorregiao;
begin
  SelecionarItemMesorregiao(0, 0);
end;

procedure TfrmIbgeMesorregiao.SelecionarProximaMesorregiao;
begin
  SelecionarItemMesorregiao(Pred(cmbMesorregiao.Items.Count), Succ(cmbMesorregiao.ItemIndex));
end;

procedure TfrmIbgeMesorregiao.SelecionarUltimaMesorregiao;
begin
  SelecionarItemMesorregiao(Pred(cmbMesorregiao.Items.Count), Pred(cmbMesorregiao.Items.Count));
end;

procedure TfrmIbgeMesorregiao.SelecionarAnteriorMesorregiao;
begin
  SelecionarItemMesorregiao(0, Pred(cmbMesorregiao.ItemIndex))
end;

procedure TfrmIbgeMesorregiao.PopularEstados;
var
  lApi: TApiSingleton;
  lEstados: TJSONIbgeUFs;
  lJSON: TJSONValue;
begin
  try
    LimparComponentesAoEscolherRegiao;
    HabilitarSelecaoMesorregiao(False);
    HabilitarBotoesNavegacao(False);
    HabilitarSelecaoEstados;

    if cmbRegiao.ItemIndex = -1 then
    begin
      HabilitarSelecaoEstados(False);
      Exit;
    end;

    lApi := TApiSingleton.ObterInstancia(ejUfs);
    lJSON := lApi.Regiao.ListarEstadosDaRegiao((cmbRegiao.ItemIndex + 1).ToString);

    try
      lEstados := TJSONIBGEUFs(lApi.Transformar.ParaObjeto(lJSON));

      for var lEstado in lEstados.Ufs do
      begin
        cmbEstado.Items.Add(lEstado.Sigla + ' - ' + lEstado.Nome);
      end;
    finally
      FreeAndNil(lEstados);
    end;
  except
    on E: Exception do
    begin
      THelpersException.TratarExceptions(E);
    end;
  end;
end;

procedure TfrmIbgeMesorregiao.PopularMesorregioes;
var
  lApi: TApiSingleton;
  lSiglaEstado: string;
begin
  lSiglaEstado := Copy(cmbEstado.Text, 1, 2);
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lApi.Estado.ConsultarMesorregioes(lSiglaEstado);

  cmbMesorregiao.Clear;
  for var lMesorregiao in lApi.Estado.JSON.Mesorregioes do
  begin
    cmbMesorregiao.Items.Add(lMesorregiao.Nome);
  end;
end;

procedure TfrmIbgeMesorregiao.PopularRegioes;
var
  lApi: TApiSingleton;
  lRegioes: TJSONIBGERegioes;
begin
  lApi := TApiSingleton.ObterInstancia(ejRegioes);
  lRegioes := TJSONIBGERegioes(lApi.Transformar.ParaObjeto(lApi.Regiao.ListarRegioes));

  try
    cmbRegiao.Clear;

    for var lRegiao in lRegioes.Regiao do
    begin
      cmbRegiao.Items.Add(lRegiao.Nome);
    end;
  finally
    FreeAndNil(lRegioes);
  end;
end;

function TfrmIbgeMesorregiao.RetornarIdMesorregiao(pSiglaEstado: string): Integer;
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lApi.Estado.ConsultarMesorregioes(pSiglaEstado);
  Result := 0;

  for var lMesorregiao in lApi.Estado.JSON.Mesorregioes do
  begin
    if lMesorregiao.Nome <> cmbMesorregiao.Text then
    begin
      Continue;
    end;

    Result := lMesorregiao.Id;
    Break;
  end;
end;

procedure TfrmIbgeMesorregiao.LimparFormulario;
begin
  cmbRegiao.ItemIndex := -1;
  cmbMesorregiao.Clear;
  cmbEstado.Clear;
  frmMesorregiaoMaisInfo.Limpar;
  HabilitarSelecaoEstados(False);
  HabilitarSelecaoMesorregiao(False);
  HabilitarBotoesNavegacao(False);
  btnMaps.Enabled := False;
  frmDadosMesorregiao.LimparEdits;
end;

procedure TfrmIbgeMesorregiao.NavegarMesorregioes(pDirecao: TNavegarBotoes);
begin
  case pDirecao of
    nbPrimeiro: SelecionarPrimeiraMesorregiao;
    nbAnterior: SelecionarAnteriorMesorregiao;
    nbProximo: SelecionarProximaMesorregiao;
    nbUltimo: SelecionarUltimaMesorregiao;
  end;
end;

procedure TfrmIbgeMesorregiao.SelecionarItemMesorregiao(pItemLimite, pItem: Integer);
begin
  if cmbMesorregiao.ItemIndex = pItemLimite then
  begin
    Exit;
  end;

  cmbMesorregiao.ItemIndex := pItem;
  cmbMesorregiao.OnChange(nil);
end;

end.
