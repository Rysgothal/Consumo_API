unit API.Frames.Navegador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge,
  API.Interfaces.Observer.Notificacao;

type
  TframeNavegador = class(TFrame, IObserver)
    edbNavegador: TEdgeBrowser;
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
    procedure Atualizar; overload;
    procedure Atualizar(const pLink: string); overload;
  end;

implementation

{$R *.dfm}

{ TframeNavegador }

procedure TframeNavegador.Atualizar;
begin
end;

procedure TframeNavegador.Atualizar(const pLink: string);
begin

end;

procedure TframeNavegador.Pesquisar;
var
  lPesquisa: string;
begin
  edbNavegador.ReinitializeWebView;

  lPesquisa := 'https://www.google.com.br/maps/search/Região ';
//  lPesquisa := lPesquisa + pRegiao + ' do Brasil';
  edbNavegador.Navigate(lPesquisa);
end;

end.
