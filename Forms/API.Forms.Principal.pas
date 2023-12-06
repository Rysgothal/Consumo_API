unit API.Forms.Principal;

interface

uses
  System.Variants, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls,
  Vcl.StdCtrls, Vcl.Menus, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, SHDocVw, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.Imaging.pngimage,
  System.UITypes, Winapi.Windows, Vcl.Graphics, API.DataModules.Principal;

type
  TfrmPrincipal = class(TForm)
    imgLogoGanso: TImage;
    sttsbarBarraStatus: TStatusBar;
    tmrTempoAtual: TTimer;
    mmnMenuPrincipal: TMainMenu;
    menuConsultar: TMenuItem;
    menuConsultarViaCep: TMenuItem;
    mmnIBGE: TMenuItem;
    mmnIBGERegioes: TMenuItem;
    mmnMesorregioes: TMenuItem;
    procedure imgLogoGansoMouseLeave(Sender: TObject);
    procedure imgLogoGansoMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrTempoAtualTimer(Sender: TObject);
    procedure menuConsultarViaCepClick(Sender: TObject);
    procedure mmnIBGERegioesClick(Sender: TObject);
    procedure mmnMesorregioesClick(Sender: TObject);
  private
    procedure CarregarImagemLogo(pNomeImagem: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  System.SysUtils, API.Forms.ViaCep, API.Forms.IBGERegiao,
  API.Forms.IBGEMesorregiao;

{$R *.dfm}

procedure TfrmPrincipal.CarregarImagemLogo(pNomeImagem: string);
var
  lRStream: TResourceStream;
  lLogo: TPngImage;
begin
  lRStream := TResourceStream.Create(HInstance, pNomeImagem, RT_RCDATA);
  lLogo := TPngImage.Create;

  try
    lLogo.LoadFromStream(lRStream);
    imgLogoGanso.Picture.Graphic := lLogo;
  finally
    lLogo.Free;
    lRStream.Free;
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  CarregarImagemLogo('LogoGansoCinza');
  tmrTempoAtual.Enabled := True;
end;

procedure TfrmPrincipal.imgLogoGansoMouseEnter(Sender: TObject);
begin
  CarregarImagemLogo('LogoGansoColor');
end;

procedure TfrmPrincipal.imgLogoGansoMouseLeave(Sender: TObject);
begin
  CarregarImagemLogo('LogoGansoCinza');
end;

procedure TfrmPrincipal.menuConsultarViaCepClick(Sender: TObject);
begin
  if not Assigned(frmViaCep) then
  begin
    frmViaCep := TfrmViaCep.Create(Self);
  end;

  frmViaCep.ShowModal;
end;

procedure TfrmPrincipal.mmnIBGERegioesClick(Sender: TObject);
begin
  if not Assigned(frmIbgeRegiao) then
  begin
    frmIbgeRegiao := TfrmIbgeRegiao.Create(Self);
  end;

  frmIbgeRegiao.ShowModal;
end;

procedure TfrmPrincipal.mmnMesorregioesClick(Sender: TObject);
begin
  if not Assigned(frmIbgeMesorregiao) then
  begin
    frmIbgeMesorregiao := TfrmIbgeMesorregiao.Create(Self);
  end;

  frmIbgeMesorregiao.ShowModal;
end;

procedure TfrmPrincipal.tmrTempoAtualTimer(Sender: TObject);
begin
  sttsbarBarraStatus.Panels[0].Text := FormatDateTime('dddddd', Now);
  sttsbarBarraStatus.Panels[1].Text := FormatDateTime('hh:mm:ss', Now);
end;

end.
