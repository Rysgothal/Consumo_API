unit API.Forms.Navegador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge;

type
  TfrmTelaNavegador = class(TForm)
    edbNavegador: TEdgeBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(const pValor: string); reintroduce; overload;
  end;

var
  frmTelaNavegador: TfrmTelaNavegador;

implementation

{$R *.dfm}

{ TfrmTelaNavegador }

constructor TfrmTelaNavegador.Create(const pValor: string);
begin
  inherited Create(Owner);
  edbNavegador.Navigate(pValor);
end;

procedure TfrmTelaNavegador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmTelaNavegador := nil;
end;

procedure TfrmTelaNavegador.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    Close;
  end;
end;

end.
