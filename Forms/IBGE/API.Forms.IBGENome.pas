unit API.Forms.IBGENome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, VclTee.TeeGDIPlus, VCLTee.TeEngine, VCLTee.Series,
  Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, Vcl.StdCtrls, System.ImageList, Vcl.ImgList,
  System.Math, Vcl.Mask, Vcl.Buttons, System.JSON, System.TypInfo, RTTI;

type
  TfrmNomes = class(TForm)
    dbcGrafico: TDBChart;
    pnlTop: TPanel;
    imgIcons: TImageList;
    btnPesquisar: TButton;
    Series1: TBarSeries;
    lbeNome: TLabeledEdit;
    Series2: TPieSeries;
    Series3: THorizBarSeries;
    Series4: TAreaSeries;
    btnMudarGrafico: TButton;
    bntRanking: TButton;
    Bevel1: TBevel;
    rdgParametros: TRadioGroup;
    cmbValorParametros: TComboBox;
    lblValorParametros: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnMudarGraficoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbeNomeChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bntRankingClick(Sender: TObject);
    procedure rdgParametrosClick(Sender: TObject);
  private
    { Private declarations }
//    FApi: TApi;
    procedure PesquisarNome;
    function SortearCores: Cardinal;
//    procedure AdicionarDadosGraficoNome(const pNome: TIbgeNomesFrequecias);
    procedure FocarCampoNome;
    procedure BuscarRankingNomes;
//    procedure AdicionarRankingNomesGrafico(const pNome: TIbgeNomesRankings);
    procedure PesquisarPorParametro;
    procedure InserirDecadasNoComboBox;
    procedure HabilitarComboBoxValorParametros(pBoolean: Boolean);
//    procedure AlterarGrafico(pSeries: TChartSeries; pType: TPieSeries); overload;
//    procedure AlterarGrafico(pSeries: TChartSeries; pType: TBarSeries); overload;
  public
    { Public declarations }
  end;

var
  frmNomes: TfrmNomes;

implementation

{$R *.dfm}

//procedure TfrmNomes.AdicionarDadosGraficoNome(const pNome: TIbgeNomesFrequecias);
//begin
//  Series1.Clear;
//  Series1.Active := True;
//
//  dbcGrafico.Visible := True;
//  dbcGrafico.Legend.Title.Caption := 'Ano, Frequência';
//
//  for var vNome in pNome.NomesFrequencias do
//  begin
//    dbcGrafico.Title.Caption := 'Nome: ' + vNome.Nome;
//
//    for var vPeriodos in vNome.Res do
//    begin
//      Series1.Add(vPeriodos.Frequencia, StringReplace(vPeriodos.Periodo, '[', '', [rfReplaceAll]), SortearCores);
//    end;
//  end;
//end;

//procedure TfrmNomes.AdicionarRankingNomesGrafico(const pNome: TIbgeNomesRankings);
//begin
//  Series1.Clear;
//  Series1.Active := True;
//
//  dbcGrafico.Visible := True;
//  dbcGrafico.Title.Caption := 'Ranking De Nomes, por: ' + rdgParametros.Items[rdgParametros.ItemIndex];
//  dbcGrafico.Legend.Title.Caption := 'Nome, Frequência';
//
//  for var vNome in pNome.NomesRanking.Res do
//  begin
//    if Series1.Count = 10 then
//    begin
//      Break;
//    end;
//
//    Series1.Add(vNome.Frequencia, vNome.Nome, SortearCores);
//  end;
//end;

//procedure TfrmNomes.AlterarGrafico(pSeries: TChartSeries; pType: TPieSeries);
//begin
//  ChangeSeriesType(pSeries, TPieSeries);
//end;

//procedure TfrmNomes.AlterarGrafico(pSeries: TChartSeries; pType: TBarSeries);
//begin
//  ChangeSeriesType(pSeries, TBarSeries);
//end;

procedure TfrmNomes.bntRankingClick(Sender: TObject);
begin
  BuscarRankingNomes;
end;

procedure TfrmNomes.btnMudarGraficoClick(Sender: TObject);
var
  vSeries: TChartSeries;
//  Info: PTypeInfo;
//  vContext: TRTTIContext;
//  vType: TRTTIType;
//  DataList := context.GetType(obj.ClassType);
begin
  for var I := 0 to dbcGrafico.SeriesCount -1 do
  begin
    vSeries := dbcGrafico.Series[I];
    Break;
  end;

//  case vSeries of
//    TBarSeries: ;
//  end;

//  vContext := TRTTIContext.Create;
//  vType := vContext.GetType(vSeries.ClassType);
//  var v := vContext.GetType(vSeries.ClassType);

//  vSeries.ClassType;
//  vSeries.ClassInfo;

//  AlterarGrafico(vSeries, vSeries.ClassType);

  if vSeries is TBarSeries then
  begin
    ChangeSeriesType(vSeries, TPieSeries);
  end else
  if vSeries is TPieSeries then
  begin
    ChangeSeriesType(vSeries, THorizBarSeries);
  end else
  if vSeries is THorizBarSeries then
  begin
    ChangeSeriesType(vSeries, TLineSeries);
  end else
  if vSeries is TLineSeries then
  begin
    ChangeSeriesType(vSeries, TBarSeries);
  end;

end;

procedure TfrmNomes.btnPesquisarClick(Sender: TObject);
begin
  PesquisarNome;
end;

procedure TfrmNomes.BuscarRankingNomes;
var
  vJson: TJSONValue;
//  vNomes: TIbgeNomesRankings;
begin
  if cmbValorParametros.ItemIndex = -1 then
  begin
    Exit;
  end;

//  case rdgParametros.ItemIndex of
//    0: FApi.ConfigurarAPI('/ranking/?decada={data}', 'data', cmbValorParametros.Text);
//    else FApi.ConfigurarAPI('/ranking/?sexo={sexo}', 'sexo', Copy(cmbValorParametros.Text, 1, 1));
//  end;

//  vJson := FApi.Request.Response.JSONValue;
//  vNomes := TIbgeNomesRankings.Create(vJson, 'nome-ranking');
//
//  AdicionarRankingNomesGrafico(vNomes);
end;

procedure TfrmNomes.FocarCampoNome;
begin
  if lbeNome.CanFocus then
  begin
    lbeNome.SetFocus;
  end;
end;

procedure TfrmNomes.FormActivate(Sender: TObject);
begin
  FocarCampoNome;
end;

procedure TfrmNomes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmNomes := nil;
end;

procedure TfrmNomes.FormCreate(Sender: TObject);
begin
//  FApi := TApi.Create('https://servicodados.ibge.gov.br/api/v2/censos/nomes/');
end;

procedure TfrmNomes.HabilitarComboBoxValorParametros(pBoolean: Boolean);
begin
  cmbValorParametros.Enabled := pBoolean;
  lblValorParametros.Enabled := pBoolean;
end;

procedure TfrmNomes.InserirDecadasNoComboBox;
var
  vDecadas: Integer;
begin
  vDecadas := 1930;

  while vDecadas <= 2010 do
  begin
    cmbValorParametros.Items.Add(vDecadas.ToString);
    vDecadas := vDecadas + 10;
  end;
end;

procedure TfrmNomes.lbeNomeChange(Sender: TObject);
begin
//  lbeNome.Text := TFuncoes.SomenteLetras(lbeNome.Text);
end;

procedure TfrmNomes.PesquisarNome;
//var
//  vJson: TJSONValue;
//  vNomes: TIbgeNomesFrequecias;
begin
  try
//    vJson := TBuscarDaApi.RetornarFrequenciasNomes(FApi, lbeNome.Text);
//    vNomes := TIbgeNomesFrequecias.Create(vJson, 'nome-frequencia');
//
//    AdicionarDadosGraficoNome(vNomes);
  except
//    on EErroDeRota do
//    begin
//      Application.MessageBox(pChar('Não foi possível estabelecer a rota'), 'Rota Não Estabelecida', MB_OK +
//        MB_ICONINFORMATION);
//      FocarCampoNome;
//    end;
//
//    on ENomeSemRegistros do
//    begin
//      Application.MessageBox(pChar('O nome informado não possui registros'), 'Nome Sem Registro', MB_OK +
//        MB_ICONINFORMATION);
//      FocarCampoNome;
//    end;
//
//    on EValorNaoInserido do
//    begin
//      Application.MessageBox(pChar('O nome não foi informado'), 'Sem Nome', MB_OK + MB_ICONINFORMATION);
//      FocarCampoNome;
//    end;

    on Exception do
    begin
      Application.MessageBox(pChar('Houve uma falha desconhecida, por favor tente novamente'), 'Falha Desconhecida',
        MB_OK + MB_ICONINFORMATION);
      FocarCampoNome;
    end;
  end;
end;

procedure TfrmNomes.PesquisarPorParametro;
begin
  cmbValorParametros.Clear;

  dbcGrafico.Visible := False;
  HabilitarComboBoxValorParametros(True);

  lblValorParametros.Caption := rdgParametros.Items[rdgParametros.ItemIndex] + ':';

  case rdgParametros.ItemIndex of
    0: InserirDecadasNoComboBox;
    1: cmbValorParametros.Items.AddStrings(['Masculino', 'Feminino']);
  end;
end;

procedure TfrmNomes.rdgParametrosClick(Sender: TObject);
begin
  PesquisarPorParametro;
end;

function TfrmNomes.SortearCores: Cardinal;
begin
  Result := RGB(RandomRange(0, 150), RandomRange(0, 150), RandomRange(0, 150));
end;

end.
