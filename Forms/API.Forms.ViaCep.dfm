object frmViaCep: TfrmViaCep
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'API - ViaCep'
  ClientHeight = 303
  ClientWidth = 581
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
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 581
    Height = 65
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lbeCepConsulta: TLabeledEdit
      Left = 16
      Top = 22
      Width = 145
      Height = 23
      EditLabel.Width = 21
      EditLabel.Height = 15
      EditLabel.Caption = 'CEP'
      TabOrder = 0
      Text = ''
      OnChange = lbeCepConsultaChange
    end
    object btnPesquisar: TButton
      Left = 456
      Top = 19
      Width = 105
      Height = 29
      Caption = '&Pesquisar'
      ImageIndex = 4
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 67
    Width = 581
    Height = 236
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 1
    inline frmDadosViaCep: TfrmDadosViaCep
      Left = 1
      Top = 1
      Width = 579
      Height = 234
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 579
      ExplicitHeight = 234
      inherited btnLimpar: TButton
        Left = 470
        ExplicitLeft = 470
      end
      inherited btnMaps: TButton
        Left = 15
        ExplicitLeft = 15
      end
    end
  end
end
