unit API.Frames.IBGE.Regiao.InformacaoRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  API.Interfaces.Observer.Notificacao, System.JSON,
  API.Classes.JSON.IBGE.Metadados;

type
  TfrmDadosRegiao = class(TFrame, IObserver)
    lbeId: TLabeledEdit;
    lbeNome: TLabeledEdit;
    lbeSigla: TLabeledEdit;
    lbeCentroideLat: TLabeledEdit;
    lbeCentroideLong: TLabeledEdit;
    lbeArea: TLabeledEdit;
    lbeNivelGeografico: TLabeledEdit;
  private
    procedure PreencherEdits(lMetadadosRegiao: TJSONIBGEMetadado);
    { Private declarations }
  public
    { Public declarations }
    procedure Atualizar;
    procedure LimparEdits;
  end;

implementation

uses
  API.Classes.Singleton.Principal,
  API.Classes.Helpers.Enumerados;

{$R *.dfm}

{ TfrmDadosRegiao }

procedure TfrmDadosRegiao.Atualizar;
var
  lApi: TApiSingleton;
  lMetadadosRegiao: TJSONIBGEMetadado;
begin
  lApi := TApiSingleton.ObterInstancia(ejMetadados);
  lApi.Metadados.ConsultarMetadados(lApi.Regiao.JSON.Id.ToString, lApi.Transformar);
  LimparEdits;

  lMetadadosRegiao := lApi.Metadados.JSON.Metadados;
  PreencherEdits(lMetadadosRegiao);
end;

procedure TfrmDadosRegiao.LimparEdits;
begin
  lbeId.Clear;
  lbeCentroideLong.Clear;
  lbeArea.Clear;
  lbeNivelGeografico.Clear;
  lbeCentroideLat.Clear;
  lbeNome.Clear;
  lbeSigla.Clear;
end;

procedure TfrmDadosRegiao.PreencherEdits(lMetadadosRegiao: TJSONIBGEMetadado);
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejMetadados);

  lbeNome.Text := lApi.Regiao.JSON.Nome;
  lbeCentroideLong.Text := lMetadadosRegiao.CentroIde.Longitude;
  lbeId.Text := lMetadadosRegiao.Id;
  lbeArea.Text := lMetadadosRegiao.Area.Dimensao + ' ' + lMetadadosRegiao.Area.Unidade.Id;
  lbeNivelGeografico.Text := lMetadadosRegiao.NivelGeografico;
  lbeCentroideLat.Text := lMetadadosRegiao.CentroIde.Latitude;
  lbeSigla.Text := lApi.Regiao.JSON.Sigla;
end;

end.
