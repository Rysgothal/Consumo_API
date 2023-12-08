unit API.Forms.IBGEMesorregiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  System.JSON, System.Generics.Collections, Vcl.Mask, REST.Json,
  API.Classes.JSON.IBGE.Metadados, API.Classes.Helpers.Exceptions,
  API.Classes.Base.IBGE.Mesorregiao, API.Classes.JSON.IBGE.Regiao,
  API.Classes.JSON.IBGE.UF, API.Classes.JSON.IBGE.Mesorregiao;

type
  TfrmIbgeMesorregiao = class(TForm)
    imgIcons: TImageList;
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
    procedure PreencherCamposMetadadosMesorregiao;
    procedure PreencherRegioesComboBox;
    procedure LimparFormulario;
    procedure LimparEdits;
    procedure LimparBottonPainel;
    procedure AbrirMapa;
    procedure BuscarRegioes(var pJson: TJSONValue);
    procedure BuscarEstadosDaRegiao(var pJson: TJSONValue);
    procedure BuscarMesorregioesDoEstado(var pJson: TJSONValue);
    procedure HabilitarCmbMesorregioes(pBoolean: Boolean);
    procedure HabilitarComboBoxEstados(pBoolean: Boolean);
    procedure HabilitarBotoesNavegacao(pBoolean: Boolean);
    procedure RetornarIdMesorregiaoSelecionada(var pId: Integer);
    procedure InserirNoMemo(pMetadados: TJSONIBGEMetadados);
    procedure SelecionarItemCmbMesorregioes(pItemLimite, pItem: Integer);

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

procedure TfrmIbgeMesorregiao.BuscarMesorregioesDoEstado(var pJson: TJSONValue);
var
  lApiIBGEMesorregiao: TApiIBGEMesorregiao;
begin
  lApiIBGEMesorregiao := TApiIBGEMesorregiao.ObterInstancia(opMesorregioes);          // Verificar...

  try
    pJson := lApiIBGEMesorregiao.ConsultarMesorregioesDoEstado(Copy(cmbEstado.Text, 1, 2));
  except
    on Exception do
    begin
      Application.MessageBox('Não foi possível buscar as Mesorregioes do Estado selecionado, Tente novamente!',
        'Atenção', MB_OK + MB_ICONINFORMATION);
      Abort;
    end;
  end;
end;

procedure TfrmIbgeMesorregiao.BuscarEstadosDaRegiao(var pJson: TJSONValue);
var
  lApiIBGERegiao: TApiIBGERegiao;
  lItem: Integer;
begin
  lItem := cmbRegiao.ItemIndex + 1;
  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(opRegiao);

  try
    pJson := lApiIBGERegiao.ListarEstadosDaRegiao(lItem.ToString);
  except
    on Exception do
    begin
      Application.MessageBox('Não foi possível buscar os Estados da Região selecionada, Tente novamente!', 'Atenção',
        MB_OK + MB_ICONINFORMATION);
      Abort;
    end;
  end;
end;

procedure TfrmIbgeMesorregiao.LimparBottonPainel;
begin
  memJson.Clear;
  cmbNomeMesorregiao.Clear;
  LimparEdits;
end;

procedure TfrmIbgeMesorregiao.HabilitarBotoesNavegacao(pBoolean: Boolean);
begin
  btnPrimeiroRegistro.Enabled := pBoolean;
  btnAnterior.Enabled := pBoolean;
  btnProximo.Enabled := pBoolean;
  btnUltimoRegistro.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.HabilitarCmbMesorregioes(pBoolean: Boolean);
begin
  lblNomeMesorregiao.Enabled := pBoolean;
  cmbNomeMesorregiao.Enabled := pBoolean;
end;

procedure TfrmIbgeMesorregiao.BuscarRegioes(var pJson: TJSONValue);
var
  lApiIBGERegiao: TApiIBGERegiao;
begin
  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(opRegiao);

  try
    pJson := lApiIBGERegiao.ListarRegioes;
  except
    Application.MessageBox('Houve uma falha inesperada no programa, Tente Novamente', 'Falha Desconhecida', MB_OK +
      MB_ICONINFORMATION);
    Close;
  end;
end;

procedure TfrmIbgeMesorregiao.cmbEstadoChange(Sender: TObject);
begin
  LimparBottonPainel;

  if cmbEstado.ItemIndex = -1 then
  begin
    HabilitarCmbMesorregioes(False);
    Exit;
  end;

  HabilitarCmbMesorregioes(True);
  PreencherComboBoxMesorregiao;
end;

procedure TfrmIbgeMesorregiao.cmbNomeMesorregiaoChange(Sender: TObject);
begin
  PreencherCamposMetadadosMesorregiao;
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

procedure TfrmIbgeMesorregiao.HabilitarComboBoxEstados(pBoolean: Boolean);
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
  cmbNomeMesorregiao.OnChange(Self);
end;

procedure TfrmIbgeMesorregiao.InserirNoMemo(pMetadados: TJSONIBGEMetadados);
begin
  memJson.Clear;

  for var vMetadado in pMetadados.Metadados do
  begin
    memJson.Lines.Add('Mesorregiao: ' + cmbNomeMesorregiao.Text);
    memJson.Lines.Add('');
    memJson.Lines.Add(' ID: ' + vMetadado.Id);
    memJson.Lines.Add(' Nível Geográfico: ' + vMetadado.NivelGeografico);
    memJson.Lines.Add(' Centroide:');
    memJson.Lines.Add('     - Longitude: ' + vMetadado.Centroide.Longitude);
    memJson.Lines.Add('     - Latitude: ' + vMetadado.Centroide.Latitude);
    memJson.Lines.Add(' Área: ' + vMetadado.Area.Dimensao + ' ' + vMetadado.Area.Unidade.Id);
    memJson.Lines.Add('');
  end;
end;

procedure TfrmIbgeMesorregiao.AbrirMapa;
var
  vUrl: string;
  vUrlEncode: TUrlEncoding;
begin
  if cmbNomeMesorregiao.ItemIndex = -1 then
  begin
    Application.MessageBox('Nenhuma mesorregião selecionada, porfavor selecione!', 'Sem Mesorregiao', MB_OK +
    MB_ICONINFORMATION);
    Exit;
  end;

  if not Assigned(frmNavegador) then
  begin
    vUrl := 'https://servicodados.ibge.gov.br/api/v3/malhas/mesorregioes/' + lbeId.Text + '?formato=application/vnd';

    vUrlEncode := TURLEncoding.Create;
    try
      vUrl := vUrlEncode.Encode(vUrl);

      vUrl := 'http://geojson.io/#data=data:text/x-url,' + vUrl + '.geo+json';
      frmNavegador := TfrmNavegador.Create(vUrl);
    finally
      FreeAndNil(vUrlEncode);
    end;
  end;

  frmNavegador.Show;
end;

procedure TfrmIbgeMesorregiao.PreencherCamposMetadadosMesorregiao;
var
  lJson: TJSONValue;
  lMetadados: TJSONIBGEMetadados;
  lId: Integer;
  lApiIBGEMesorregiao: TApiIBGEMesorregiao;
begin
  if cmbNomeMesorregiao.ItemIndex = -1 then
  begin
    HabilitarBotoesNavegacao(False);
    Exit;
  end;

  lApiIBGEMesorregiao := TApiIBGEMesorregiao.ObterInstancia(opMesorregioes);
  RetornarIdMesorregiaoSelecionada(lId);

  try
    lJson := lApiIBGEMesorregiao.ConsultarMetadadosMesorregiao(lId.ToString);

//    lMetadados := TJSONIBGEMetadados.Create(lJson, 'metadados');
    lMetadados := TJSONIBGEMetadados(lApiIBGEMesorregiao.Transformar.ParaObjeto(lJson));
  except
    on EErroDeRota do
    begin
      Application.MessageBox('Não foi possivel estabelecer uma rota, por favor, tente novamente', 'Erro de Rota',
        MB_OK + MB_ICONINFORMATION);
      Exit;
    end;

    on Exception do
    begin
      Application.MessageBox('Ouve uma falha desconhecida, tente novamente', 'Falha Desconhecida', MB_OK +
        MB_ICONINFORMATION);
      Exit;
    end;
  end;

  for var vMetadado in lMetadados.Metadados do
  begin
    lbeLatitude.Text := vMetadado.Centroide.Latitude;
    lbeLongitude.Text := vMetadado.Centroide.Latitude;
    lbeId.Text := vMetadado.Id;
    lbeNome.Text := cmbNomeMesorregiao.Text;
    lbeDimensao.Text := vMetadado.Area.Dimensao + ' ' + vMetadado.Area.Unidade.Nome;
  end;

  HabilitarBotoesNavegacao(True);
  InserirNoMemo(lMetadados);
end;

procedure TfrmIbgeMesorregiao.PreencherComboBoxEstados;
var
  lJson: TJSONValue;
  lUf: TJSONIbgeUFs;
  lApiIBGEMesorregiao: TApiIBGEMesorregiao;
begin
  LimparEdits;
  memJson.Clear;
  cmbNomeMesorregiao.Clear;

  HabilitarCmbMesorregioes(False);
  HabilitarComboBoxEstados(True);
  cmbEstado.Clear;

  if cmbRegiao.ItemIndex = -1 then
  begin
    HabilitarComboBoxEstados(False);
    Exit;
  end;

  BuscarEstadosDaRegiao(lJson);
  lApiIBGEMesorregiao := TApiIBGEMesorregiao.ObterInstancia(opUfs);
  lUf := TJSONIbgeUFs(lApiIBGEMesorregiao.Transformar.ParaObjeto(lJson));

  try
    for var lEstado in lUf.Ufs do
    begin
      cmbEstado.Items.Add(lEstado.Sigla + ' - ' + lEstado.Nome);
    end;
  finally
    FreeAndNil(lUf);
  end;
end;

procedure TfrmIbgeMesorregiao.PreencherComboBoxMesorregiao;
var
  lJson: TJSONValue;
  lMesorregioes: TJSONIBGEMesorregioes;
  lApiIBGEMesorregiao: TApiIBGEMesorregiao;
begin
  BuscarMesorregioesDoEstado(lJson);
  lApiIBGEMesorregiao := TApiIBGEMesorregiao.ObterInstancia(opMesorregioes);
  lMesorregioes := TJSONIBGEMesorregioes(lApiIBGEMesorregiao.Transformar.ParaObjeto(lJson));

  try
    for var lMesorregiao in lMesorregioes.Mesorregioes do
    begin
      cmbNomeMesorregiao.Items.Add(lMesorregiao.Nome);
    end;
  finally
    FreeAndNil(lMesorregioes);
  end;
end;

procedure TfrmIbgeMesorregiao.PreencherRegioesComboBox;
var
  lJson: TJSONValue;
  lRegioes: TJSONIBGERegioes;
  lApiIBGERegiao: TApiIBGERegiao;
begin
  BuscarRegioes(lJson);
  lApiIBGERegiao := TApiIBGERegiao.ObterInstancia(opRegioes);
  lRegioes := TJSONIbgeRegioes(lApiIBGERegiao.Transformar.ParaObjeto(lJson));

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

procedure TfrmIbgeMesorregiao.RetornarIdMesorregiaoSelecionada(var pId: Integer);
var
  vJson: TJSONValue;
  vMesorregioes: TJSONIBGEMesorregioes;
  lApiIBGEMesorregiao: TApiIBGEMesorregiao;
begin
  BuscarMesorregioesDoEstado(vJson);
  lApiIBGEMesorregiao := TApiIBGEMesorregiao.ObterInstancia(opMesorregioes);

  vMesorregioes := TJSONIBGEMesorregioes(lApiIBGEMesorregiao.Transformar.ParaObjeto(vJson));

  for var vMesorregiao in vMesorregioes.Mesorregioes do
  begin
    if vMesorregiao.Nome <> cmbNomeMesorregiao.Text then
    begin
      Continue;
    end;

    pId := vMesorregiao.Id;
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
