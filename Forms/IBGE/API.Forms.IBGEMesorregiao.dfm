object frmIbgeMesorregiao: TfrmIbgeMesorregiao
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'IBGE - Mesorregi'#227'o'
  ClientHeight = 477
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 631
    Height = 59
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lblRegiao: TLabel
      Left = 16
      Top = 18
      Width = 44
      Height = 15
      Caption = 'Regi'#245'es:'
    end
    object lblEstado: TLabel
      Left = 336
      Top = 18
      Width = 43
      Height = 15
      Caption = 'Estados:'
      Enabled = False
    end
    object cmbRegiao: TComboBox
      Left = 66
      Top = 15
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbRegiaoChange
    end
    object cmbEstado: TComboBox
      Left = 385
      Top = 15
      Width = 203
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 1
      OnChange = cmbEstadoChange
    end
  end
  object pnlBotton: TPanel
    Left = 0
    Top = 59
    Width = 631
    Height = 151
    Align = alTop
    BevelEdges = [beTop, beBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object lblNomeMesorregiao: TLabel
      Left = 16
      Top = 20
      Width = 74
      Height = 15
      Caption = 'Mesorregi'#245'es:'
      Enabled = False
    end
    object cmbNomeMesorregiao: TComboBox
      Left = 93
      Top = 17
      Width = 270
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 0
      OnChange = cmbNomeMesorregiaoChange
    end
    object btnLimpar: TButton
      Left = 527
      Top = 110
      Width = 90
      Height = 41
      Caption = '&Limpar'
      ImageIndex = 10
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 2
      OnClick = btnLimparClick
    end
    object btnMaps: TButton
      Left = 424
      Top = 110
      Width = 97
      Height = 41
      Caption = '&Maps'
      ImageIndex = 3
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 1
      OnClick = btnMapsClick
    end
    inline frmDadosMesorregiao: TfrmDadosMesorregiao
      Left = -1
      Top = 59
      Width = 632
      Height = 50
      TabOrder = 3
      ExplicitLeft = -1
      ExplicitTop = 59
      ExplicitWidth = 632
      ExplicitHeight = 50
      inherited lbeLatitude: TLabeledEdit
        EditLabel.ExplicitLeft = 255
        EditLabel.ExplicitTop = -1
        EditLabel.ExplicitWidth = 43
      end
      inherited lbeLongitude: TLabeledEdit
        EditLabel.ExplicitLeft = 114
        EditLabel.ExplicitTop = -1
        EditLabel.ExplicitWidth = 54
      end
    end
  end
  object btnAnterior: TButton
    Left = 46
    Top = 186
    Width = 33
    Height = 25
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 20
    Caption = #231
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnAnteriorClick
  end
  object btnPrimeiroRegistro: TButton
    Left = 15
    Top = 186
    Width = 33
    Height = 25
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Caption = #235
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnPrimeiroRegistroClick
  end
  object btnProximo: TButton
    Left = 77
    Top = 186
    Width = 33
    Height = 25
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 20
    Caption = #232
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnProximoClick
  end
  object btnUltimoRegistro: TButton
    Left = 108
    Top = 186
    Width = 33
    Height = 25
    Margins.Left = 20
    Margins.Top = 20
    Margins.Right = 20
    Margins.Bottom = 20
    Caption = #238
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Wingdings'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnUltimoRegistroClick
  end
  inline frmMesorregiaoMaisInfo: TfrmMesorregiaoMaisInfo
    Left = 0
    Top = 214
    Width = 631
    Height = 263
    Align = alBottom
    TabOrder = 6
    ExplicitTop = 214
    ExplicitWidth = 631
    ExplicitHeight = 263
    inherited memJson: TMemo
      Width = 631
      Height = 263
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 631
      ExplicitHeight = 263
    end
  end
end
