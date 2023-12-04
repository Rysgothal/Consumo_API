object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Treinamento API'
  ClientHeight = 414
  ClientWidth = 504
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object imgLogoGanso: TImage
    Left = 88
    Top = 112
    Width = 320
    Height = 114
    AutoSize = True
    Center = True
    OnMouseEnter = imgLogoGansoMouseEnter
    OnMouseLeave = imgLogoGansoMouseLeave
  end
end
