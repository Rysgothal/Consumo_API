unit API.Forms.Navegador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge;

type
  TfrmNavegador = class(TForm)
    edbNavegador: TEdgeBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(const pValor: string); reintroduce; overload;
  end;

var
  frmNavegador: TfrmNavegador;

implementation

{$R *.dfm}

{ TForm1 }

constructor TfrmNavegador.Create(const pValor: string);
begin
  inherited Create(Owner);
//  edbNavegador.CreateWebView;
  edbNavegador.Navigate(pValor);
//  edbNavegador.ZoomFactor := 25;
end;

procedure TfrmNavegador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmNavegador := nil;
end;

end.
