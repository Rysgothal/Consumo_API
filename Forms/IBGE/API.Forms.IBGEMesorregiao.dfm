object frmIbgeMesorregiao: TfrmIbgeMesorregiao
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'IBGE - Mesorregi'#227'o'
  ClientHeight = 411
  ClientWidth = 659
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
    Width = 659
    Height = 81
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    object lblRegiao: TLabel
      Left = 16
      Top = 18
      Width = 41
      Height = 15
      Caption = 'Regi'#245'es'
    end
    object lblEstado: TLabel
      Left = 304
      Top = 18
      Width = 40
      Height = 15
      Caption = 'Estados'
      Enabled = False
    end
    object cmbRegiao: TComboBox
      Left = 16
      Top = 39
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbRegiaoChange
    end
    object cmbEstado: TComboBox
      Left = 304
      Top = 39
      Width = 203
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 1
      OnChange = cmbEstadoChange
    end
  end
  object memJson: TMemo
    Left = 0
    Top = 238
    Width = 659
    Height = 173
    TabStop = False
    Align = alBottom
    ReadOnly = True
    TabOrder = 1
  end
  object pnlBotton: TPanel
    Left = 0
    Top = 81
    Width = 659
    Height = 157
    Align = alTop
    BevelEdges = [beTop, beBottom]
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      659
      157)
    object lblNomeMesorregiao: TLabel
      Left = 16
      Top = 12
      Width = 71
      Height = 15
      Caption = 'Mesorregi'#245'es'
      Enabled = False
    end
    object lblVezes: TLabel
      Left = 146
      Top = 82
      Width = 7
      Height = 15
      Alignment = taCenter
      Caption = 'X'
    end
    object lblMedidaDimensao: TLabel
      Left = 519
      Top = 82
      Width = 3
      Height = 15
    end
    object cmbNomeMesorregiao: TComboBox
      Left = 16
      Top = 33
      Width = 270
      Height = 23
      Style = csDropDownList
      Enabled = False
      TabOrder = 0
      OnChange = cmbNomeMesorregiaoChange
    end
    object lbeLatitude: TLabeledEdit
      Left = 165
      Top = 79
      Width = 121
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 43
      EditLabel.Height = 15
      EditLabel.Caption = 'Latitude'
      ReadOnly = True
      TabOrder = 4
      Text = ''
    end
    object lbeLongitude: TLabeledEdit
      Left = 16
      Top = 79
      Width = 121
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 54
      EditLabel.Height = 15
      EditLabel.Caption = 'Longitude'
      ReadOnly = True
      TabOrder = 3
      Text = ''
    end
    object lbeId: TLabeledEdit
      Left = 304
      Top = 33
      Width = 81
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 11
      EditLabel.Height = 15
      EditLabel.Caption = 'ID'
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object lbeNome: TLabeledEdit
      Left = 403
      Top = 33
      Width = 241
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 33
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome'
      ReadOnly = True
      TabOrder = 2
      Text = ''
    end
    object lbeDimensao: TLabeledEdit
      Left = 314
      Top = 79
      Width = 249
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 53
      EditLabel.Height = 15
      EditLabel.Caption = 'Dimens'#227'o'
      ReadOnly = True
      TabOrder = 5
      Text = ''
    end
    object btnLimpar: TButton
      Left = 550
      Top = 110
      Width = 90
      Height = 41
      Anchors = [akTop, akRight]
      Caption = '&Limpar'
      ImageIndex = 10
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 7
      OnClick = btnLimparClick
    end
    object btnMaps: TButton
      Left = 451
      Top = 110
      Width = 97
      Height = 41
      Caption = '&Maps'
      ImageIndex = 3
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 6
      OnClick = btnMapsClick
    end
  end
  object btnAnterior: TButton
    Left = 47
    Top = 213
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
    TabOrder = 4
    OnClick = btnAnteriorClick
  end
  object btnPrimeiroRegistro: TButton
    Left = 16
    Top = 213
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
    TabOrder = 3
    OnClick = btnPrimeiroRegistroClick
  end
  object btnProximo: TButton
    Left = 78
    Top = 213
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
    TabOrder = 5
    OnClick = btnProximoClick
  end
  object btnUltimoRegistro: TButton
    Left = 109
    Top = 213
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
    TabOrder = 6
    OnClick = btnUltimoRegistroClick
  end
end
