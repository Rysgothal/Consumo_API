unit API.Forms.ViaCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, System.StrUtils, JSON,
  System.ImageList, Vcl.ImgList, API.Classes.Helpers.Strings, API.DataModules.Principal,
  API.Classes.Base.ViaCep, API.Classes.Decorator.Log, API.Frames.ViaCep.BuscarCep,
  API.Frames.ViaCep.Dados;

type
  TfrmViaCep = class(TForm)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    frmDadosViaCep: TfrmDadosViaCep;
    frmBuscarCep: TfrmBuscarCep;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure frmDadosViaCepbtnLimparClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViaCep: TfrmViaCep;

implementation

uses
  REST.Json, API.Classes.JSON.ViaCep, API.Classes.Helpers.Enumerados,
  API.Forms.Navegador, API.Classes.Singleton.Principal;

{$R *.dfm}

procedure TfrmViaCep.FormClose(Sender: TObject; var Action: TCloseAction);
var
  lApi: TApiSingleton;
begin
  lAPi := TApiSingleton.ObterInstancia(ejViaCep);
  lApi.RemoverObserver(frmDadosViaCep);

  Action := TCloseAction.caFree;
  frmViaCep := nil;
end;

procedure TfrmViaCep.FormCreate(Sender: TObject);
var
  lApi: TApiSingleton;
begin
  lApi := TApiSingleton.ObterInstancia(ejViaCep);
  lApi.AdicionarObserver(frmDadosViaCep);
end;

procedure TfrmViaCep.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

procedure TfrmViaCep.frmDadosViaCepbtnLimparClick(Sender: TObject);
begin
  frmDadosViaCep.btnLimparClick(Sender);
  frmBuscarCep.lbeCepConsulta.Clear;
  frmBuscarCep.lbeCepConsulta.SetFocus;
end;

end.
