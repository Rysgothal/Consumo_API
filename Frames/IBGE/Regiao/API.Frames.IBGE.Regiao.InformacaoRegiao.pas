unit API.Frames.IBGE.Regiao.InformacaoRegiao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  API.Interfaces.Observer.Notificacao, System.JSON;

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
    procedure LimparEdits;
    { Private declarations }
  public
    { Public declarations }
    procedure Atualizar;
  end;

implementation

uses
  API.Classes.JSON.IBGE.Metadados, API.Classes.Singleton.Principal,
  API.Classes.Helpers.Enumerados;

{$R *.dfm}

{ TfrmDadosRegiao }

procedure TfrmDadosRegiao.Atualizar;
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ojMetadados);
  lApi.Metadados.ConsultarMetadados(lApi.Regiao.JSON.Nome, lApi.Transformar);
  LimparEdits;

  for var lRegiao in lApi.Metadados.JSON.Metadados do
  begin
    lbeNome.Text := lApi.Regiao.JSON.Nome;
    lbeCentroideLong.Text := lRegiao.CentroIde.Longitude;
    lbeId.Text := lRegiao.Id;
    lbeArea.Text := lRegiao.Area.Dimensao + ' ' + lRegiao.Area.Unidade.Id;
    lbeNivelGeografico.Text := lRegiao.NivelGeografico;
    lbeCentroideLat.Text := lRegiao.CentroIde.Latitude;
    lbeSigla.Text := lApi.Regiao.JSON.Sigla;
  end;
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

end.
