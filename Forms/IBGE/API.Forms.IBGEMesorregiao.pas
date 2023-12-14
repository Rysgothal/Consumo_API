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
  API.Classes.Singleton.Principal;

type
  TfrmIbgeMesorregiao = class(TForm)
    pnlTop: TPanel;
    lblRegiao: TLabel;
    cmbRegiao: TComboBox;
    cmbEstado: TComboBox;
    lblEstado: TLabel;
    memJson: TMemo;
    pnlBotton: TPanel;
    cmbNomeMesorregiao: TComboBox;
    lblNomeMesorregiao: TLabel;
    lbeLatitude: TLabeledEdit;
    lbeLongitude: TLabeledEdit;
    lbeId: TLabeledEdit;
    lbeNome: TLabeledEdit;
    lblVezes: TLabel;
    lbeDimensao: TLabeledEdit;
    lblMedidaDimensao: TLabel;
    btnLimpar: TButton;
    btnMaps: TButton;
    btnPrimeiroRegistro: TButton;
    btnAnterior: TButton;
    btnProximo: TButton;
    btnUltimoRegistro: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimparClick(Sender: TObject);
    procedure btnMapsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbRegiaoChange(Sender: TObject);
    procedure cmbEstadoChange(Sender: TObject);
    procedure cmbNomeMesorregiaoChange(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnPrimeiroRegistroClick(Sender: TObject);
    procedure btnUltimoRegistroClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreencherComboBoxMesorregiao;
    procedure PreencherComboBoxEstados;
    procedure SelecionarMesorregiao;
    procedure PreencherRegioesComboBox;
    procedure LimparFormulario;
    procedure LimparEdits;
    procedure LimparBottonPainel;
    procedure AbrirMapa;
    procedure HabilitarCmbMesorregioes(pBoolean: Boolean = True);
    procedure HabilitarComboBoxEstados(pBoolean: Boolean = True);
    procedure HabilitarBotoesNavegacao(pBoolean: Boolean = True);
    function RetornarIdMesorregiao(pSiglaEstado: string): Integer;
    procedure InserirNoMemo(pMetadados: TJSONIBGEMetadado);
    procedure SelecionarItemCmbMesorregioes(pItemLimite, pItem: Integer);
    procedure LimparComponentesAoEscolherRegiao;
    procedure SelecionarEstado;
  public
    { Public declarations }
  end;

var
  frmIbgeMesorregiao: TfrmIbgeMesorregiao;

implementation

uses
  API.Forms.Navegador, System.SysUtils, System.NetEncoding,
  API.Classes.Helpers.Enumerados, API.Classes.Base.IBGE.Regiao;

{$R *.dfm}

procedure TfrmIbgeMesorregiao.btnAnteriorClick(Sender: TObject);
begin
  SelecionarItemCmbMesorregioes(0, cmbNomeMesorregiao.ItemIndex - 1);
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
  SelecionarItemCmbMesorregioes(cmbNomeMesorregiao.Items.Count, 0);
end;

procedure TfrmIbgeMesorregiao.btnProximoClick(Sender: TObject);
begin
  SelecionarItemCmbMesorregioes(cmbNomeMesorregiao.Items.Count, cmbNomeMesorregiao.ItemIndex + 1);
end;

procedure TfrmIbgeMesorregiao.btnUltimoRegistroClick(Sender: TObject);
begin
  SelecionarItemCmbMesorregioes(cmbNomeMesorregiao.Items.Count, cmbNomeMesorregiao.Items.Count -1);
end;

procedure TfrmIbgeMesorregiao.LimparBottonPainel;
begin
  memJson.Clear;
  cmbNomeMesorregiao.Clear;
  LimparEdits;
end;

procedure TfrmIbgeMesorregiao.LimparComponentesAoEscolherRegiao;
begin
  LimparEdits;
  memJson.Clear;
  cmbNomeMesorregiao.Clear;
  cmbEstado.Clear;
end;

procedure TfrmIbgeMesorregiao.SelecionarEstado;
begin
  LimparBottonPainel;

  if cmbEstado.ItemIndex = -1 then
  begin
    HabilitarCmbMesorregioes(False);
    Exit;
  end;

  HabilitarCmbMesorregioes;
  PreencherComboBoxMesorregiao;
end;

procedure TfrmIbgeMesorregiao.HabilitarBotoesNavegacao(pBoolean: Boolean = True);
begin
  btnPrimeiroRegistro.Enabled := pBoolean;
  btnAnterior.Enabled := pBoolean;
  btnProximo.Enabled := pBoolean;
  btnUltimoRegistro.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.HabilitarCmbMesorregioes(pBoolean: Boolean = True);
begin
  lblNomeMesorregiao.Enabled := pBoolean;
  cmbNomeMesorregiao.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.cmbEstadoChange(Sender: TObject);
begin
  SelecionarEstado;
end;

procedure TfrmIbgeMesorregiao.cmbNomeMesorregiaoChange(Sender: TObject);
begin
  SelecionarMesorregiao;
end;

procedure TfrmIbgeMesorregiao.cmbRegiaoChange(Sender: TObject);
begin
  PreencherComboBoxEstados;
end;

procedure TfrmIbgeMesorregiao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmIbgeMesorregiao := nil;
end;

procedure TfrmIbgeMesorregiao.FormCreate(Sender: TObject);
begin
  PreencherRegioesComboBox;
end;

procedure TfrmIbgeMesorregiao.HabilitarComboBoxEstados(pBoolean: Boolean = True);
begin
  lblEstado.Enabled := pBoolean;
  cmbEstado.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.SelecionarItemCmbMesorregioes(pItemLimite, pItem: Integer);
begin
  if cmbNomeMesorregiao.ItemIndex = pItemLimite then
  begin
    Exit;
  end;

  cmbNomeMesorregiao.ItemIndex := pItem;
  cmbNomeMesorregiao.OnChange(nil);
end;

procedure TfrmIbgeMesorregiao.InserirNoMemo(pMetadados: TJSONIBGEMetadado);
begin
  memJson.Clear;

  memJson.Lines.Add('Mesorregiao: ' + cmbNomeMesorregiao.Text);
  memJson.Lines.Add('');
  memJson.Lines.Add(' ID: ' + pMetadados.Id);
  memJson.Lines.Add(' N�vel Geogr�fico: ' + pMetadados.NivelGeografico);
  memJson.Lines.Add(' Centroide:');
  memJson.Lines.Add('     - Longitude: ' + pMetadados.Centroide.Longitude);
  memJson.Lines.Add('     - Latitude: ' + pMetadados.Centroide.Latitude);
  memJson.Lines.Add(' �rea: ' + pMetadados.Area.Dimensao + ' ' + pMetadados.Area.Unidade.Id);
  memJson.Lines.Add('');
end;

procedure TfrmIbgeMesorregiao.AbrirMapa;
var
  lUrl: string;
  lUrlEncode: TUrlEncoding;
begin
  if cmbNomeMesorregiao.ItemIndex = -1 then
  begin
    Application.MessageBox('Nenhuma mesorregi�o selecionada, porfavor selecione!', 'Sem Mesorregiao', MB_OK +
    MB_ICONINFORMATION);
    Exit;
  end;

  if not Assigned(frmTelaNavegador) then
  begin
    lUrl := 'https://servicodados.ibge.gov.br/api/v3/malhas/mesorregioes/' + lbeId.Text + '?formato=application/vnd';

    lUrlEncode := TURLEncoding.Create;
    try
      lUrl := lUrlEncode.Encode(lUrl);

      lUrl := 'http://geojson.io/#data=data:text/x-url,' + lUrl + '.geo+json';
      frmTelaNavegador := TfrmTelaNavegador.Create(lUrl);
    finally
      FreeAndNil(lUrlEncode);
    end;
  end;

  frmTelaNavegador.Show;
end;

procedure TfrmIbgeMesorregiao.SelecionarMesorregiao;
var
  lApi: TApiSingleton;
  lSiglaEstado: string;
  lId: Integer;
  lMetadados: TJSONIBGEMetadado;
begin
  if cmbNomeMesorregiao.ItemIndex = -1 then
  begin
    HabilitarBotoesNavegacao(False);
    Exit;
  end;

  lSiglaEstado := Copy(cmbEstado.Text, 1, 2);
  lId := RetornarIdMesorregiao(lSiglaEstado);
  lApi := TApiSingleton.ObterInstancia(ejMetadados);
  lApi.Mesorregiao.ConsultarMetadadosMesorregiao(lID.ToString);

  lMetadados := lApi.Mesorregiao.JSON.Metadados[0];

  lbeLatitude.Text := lMetadados.Centroide.Latitude;
  lbeLongitude.Text := lMetadados.Centroide.Longitude;
  lbeId.Text := lMetadados.Id;
  lbeNome.Text := cmbNomeMesorregiao.Text;
  lbeDimensao.Text := lMetadados.Area.Dimensao + ' ' + lMetadados.Area.Unidade.Nome;

  HabilitarBotoesNavegacao;
  InserirNoMemo(lMetadados);
end;

procedure TfrmIbgeMesorregiao.PreencherComboBoxEstados;
var
  lApi: TApiSingleton;
  lEstados: TJSONIbgeUFs;
  lJSON: TJSONValue;
begin
  LimparComponentesAoEscolherRegiao;
  HabilitarCmbMesorregioes(False);
  HabilitarBotoesNavegacao(False);
  HabilitarComboBoxEstados;

  if cmbRegiao.ItemIndex = -1 then
  begin
    HabilitarComboBoxEstados(False);
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
end;

procedure TfrmIbgeMesorregiao.PreencherComboBoxMesorregiao;
var
  lApi: TApiSingleton;
  lSiglaEstado: string;
begin
  lSiglaEstado := Copy(cmbEstado.Text, 1, 2);
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lApi.Estado.ConsultarMesorregioes(lSiglaEstado);

  for var lMesorregiao in lApi.Estado.JSON.Mesorregioes do
  begin
    cmbNomeMesorregiao.Items.Add(lMesorregiao.Nome);
  end;
end;

procedure TfrmIbgeMesorregiao.PreencherRegioesComboBox;
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
    if lMesorregiao.Nome <> cmbNomeMesorregiao.Text then
    begin
      Continue;
    end;

    Result := lMesorregiao.Id;
    Break;
  end;
end;

procedure TfrmIbgeMesorregiao.LimparEdits;
begin
  lbeLatitude.Clear;
  lbeLongitude.Clear;
  lbeId.Clear;
  lbeNome.Clear;
  lbeDimensao.Clear;
end;

procedure TfrmIbgeMesorregiao.LimparFormulario;
begin
  cmbRegiao.ItemIndex := -1;
  cmbNomeMesorregiao.Clear;
  cmbEstado.Clear;
  memJson.Clear;
  HabilitarComboBoxEstados(False);
  HabilitarCmbMesorregioes(False);
  HabilitarBotoesNavegacao(False);
  LimparEdits;
end;

end.
