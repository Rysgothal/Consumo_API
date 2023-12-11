object frmTelaNavegador: TfrmTelaNavegador
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Navegador'
  ClientHeight = 699
  ClientWidth = 1314
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object edbNavegador: TEdgeBrowser
    Left = 0
    Top = 0
    Width = 1314
    Height = 699
    Align = alClient
    TabOrder = 0
  end
end
