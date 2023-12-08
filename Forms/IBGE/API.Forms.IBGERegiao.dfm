object frmIbgeRegiao: TfrmIbgeRegiao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'IBGE - Regi'#245'es'
  ClientHeight = 644
  ClientWidth = 1127
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
    Width = 1127
    Height = 81
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 0
    DesignSize = (
      1127
      81)
    object lblRegiao: TLabel
      Left = 16
      Top = 18
      Width = 41
      Height = 15
      Caption = 'Regi'#245'es'
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
    object btnLimpar: TButton
      Left = 1017
      Top = 21
      Width = 90
      Height = 41
      Anchors = [akTop, akRight]
      Caption = '&Limpar'
      ImageIndex = 10
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 2
      OnClick = btnLimparClick
    end
    object btnInformacoes: TButton
      Left = 878
      Top = 21
      Width = 123
      Height = 41
      Caption = '&Informa'#231#245'es'
      ImageIndex = 21
      ImageMargins.Left = 10
      ImageMargins.Right = -10
      Images = dmPrincipal.imglistIconesBotoes
      TabOrder = 1
      OnClick = btnInformacoesClick
    end
  end
  object edbNavegador: TEdgeBrowser
    Left = 0
    Top = 81
    Width = 1127
    Height = 563
    Align = alClient
    TabOrder = 2
    UserDataFolder = '%LOCALAPPDATA%\bds.exe.WebView2'
  end
  object pnlInformacoes: TPanel
    Left = 768
    Top = 81
    Width = 359
    Height = 144
    Align = alCustom
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object lbeId: TLabeledEdit
      Left = 24
      Top = 24
      Width = 41
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 14
      EditLabel.Height = 15
      EditLabel.Caption = 'ID:'
      ReadOnly = True
      TabOrder = 0
      Text = ''
    end
    object lbeCentroideLong: TLabeledEdit
      Left = 24
      Top = 68
      Width = 121
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 57
      EditLabel.Height = 15
      EditLabel.Caption = 'Longitude:'
      ReadOnly = True
      TabOrder = 3
      Text = ''
    end
    object lbeArea: TLabeledEdit
      Left = 24
      Top = 112
      Width = 177
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 27
      EditLabel.Height = 15
      EditLabel.Caption = #193'rea:'
      ReadOnly = True
      TabOrder = 5
      Text = ''
    end
    object lbeNivelGeografico: TLabeledEdit
      Left = 216
      Top = 112
      Width = 127
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 93
      EditLabel.Height = 15
      EditLabel.Caption = 'Nivel-Geografico:'
      ReadOnly = True
      TabOrder = 6
      Text = ''
    end
    object lbeCentroideLat: TLabeledEdit
      Left = 169
      Top = 68
      Width = 121
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 46
      EditLabel.Height = 15
      EditLabel.Caption = 'Latitude:'
      ReadOnly = True
      TabOrder = 4
      Text = ''
    end
    object lbeNome: TLabeledEdit
      Left = 77
      Top = 24
      Width = 213
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 36
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome:'
      ReadOnly = True
      TabOrder = 1
      Text = ''
    end
    object lbeSigla: TLabeledEdit
      Left = 302
      Top = 24
      Width = 41
      Height = 23
      TabStop = False
      Color = clInfoBk
      EditLabel.Width = 28
      EditLabel.Height = 15
      EditLabel.Caption = 'Sigla:'
      ReadOnly = True
      TabOrder = 2
      Text = ''
    end
  end
end
