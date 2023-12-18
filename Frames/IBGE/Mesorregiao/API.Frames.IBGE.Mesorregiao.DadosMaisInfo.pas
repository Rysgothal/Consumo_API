unit API.Frames.IBGE.Mesorregiao.DadosMaisInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  API.Interfaces.Observer.Notificacao;

type
  TfrmMesorregiaoMaisInfo = class(TFrame, IObserver)
    memJson: TMemo;
  private
    { Private declarations }
  public
    procedure Atualizar;
    procedure Limpar;
    { Public declarations }
  end;

implementation

uses
  API.Classes.Singleton.Principal, API.Classes.JSON.IBGE.Metadados,
  API.Classes.Helpers.Enumerados;

{$R *.dfm}

{ TFrame1 }

procedure TfrmMesorregiaoMaisInfo.Atualizar;
var
  lApi: TApiSingleton;
  lMetadados: TJSONIBGEMetadado;
  lLimitrofe: Integer;
begin
  lApi := TApiSingleton.ObterInstancia(ejMesorregioes);
  lMetadados := lApi.Mesorregiao.JSON.Metadados;

  Limpar;
  memJson.Lines.Add('Informações detalhadas:');
  memJson.Lines.Add('');
  memJson.Lines.Add('> ID...............: ' + lMetadados.Id);
  memJson.Lines.Add('> Nível Geográfico.: ' + lMetadados.NivelGeografico);
  memJson.Lines.Add('> Centroide: ');
  memJson.Lines.Add('   - Longitude.....: ' + lMetadados.Centroide.Longitude);
  memJson.Lines.Add('   - Latitude......: ' + lMetadados.Centroide.Latitude);
  memJson.Lines.Add('> Área.............: ' + lMetadados.Area.Dimensao + ' ' + lMetadados.Area.Unidade.Nome);

  memJson.Lines.Add('> Limites:');

  lLimitrofe := 1;
  for var lRegiao in lMetadados.RegiaoLimitrofe do
  begin
    memJson.Lines.Add('> Ponto ' + lLimitrofe.ToString);
    memJson.Lines.Add('   - Longitude.: ' + lRegiao.Longitude);
    memJson.Lines.Add('   - Latitude..: ' + lRegiao.Latitude);
    Inc(lLimitrofe);
  end;
end;

procedure TfrmMesorregiaoMaisInfo.Limpar;
begin
  memJson.Clear;
end;

end.
