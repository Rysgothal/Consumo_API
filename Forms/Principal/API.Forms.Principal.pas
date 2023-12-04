unit API.Forms.Principal;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls,
  Vcl.StdCtrls, Vcl.Menus, Winapi.WebView2, Winapi.ActiveX, Vcl.Edge, SHDocVw, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.Imaging.pngimage,
  System.UITypes, Winapi.Windows, Vcl.Graphics;

type
  TfrmPrincipal = class(TForm)
    imgLogoGanso: TImage;
    procedure ViaCep1Click(Sender: TObject);
    procedure Localidade1Click(Sender: TObject);
    procedure Mesorregio1Click(Sender: TObject);
    procedure Nomes1Click(Sender: TObject);
    procedure imgLogoGansoMouseLeave(Sender: TObject);
    procedure imgLogoGansoMouseEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CarregarImagemLogo(pNomeImagem: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

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
end;

procedure TfrmPrincipal.imgLogoGansoMouseEnter(Sender: TObject);
begin
  CarregarImagemLogo('LogoGansoColor');
end;

procedure TfrmPrincipal.imgLogoGansoMouseLeave(Sender: TObject);
begin
  CarregarImagemLogo('LogoGansoCinza');
end;

end.
