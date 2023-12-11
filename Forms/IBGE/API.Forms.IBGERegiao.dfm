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
    inline frmSelecionarRegiao: TfrmSelecionarRegiao
      Left = 8
      Top = 8
      Width = 1114
      Height = 66
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 8
      inherited lblRegiao: TLabel
        Left = 12
        Top = 12
        ExplicitLeft = 12
        ExplicitTop = 12
      end
      inherited cmbRegiao: TComboBox
        Left = 12
        Top = 30
        OnChange = frmSelecionarRegiaocmbRegiaoChange
        ExplicitLeft = 12
        ExplicitTop = 30
      end
      inherited btnInformacoes: TButton
        Left = 874
        Top = 13
        OnClick = frmSelecionarRegiaobtnInformacoesClick
        ExplicitLeft = 874
        ExplicitTop = 13
      end
      inherited btnLimpar: TButton
        Left = 1013
        Top = 13
        ExplicitLeft = 1013
        ExplicitTop = 13
      end
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
    inline frmMetadadosRegiao: TfrmDadosRegiao
      Left = 0
      Top = 0
      Width = 359
      Height = 144
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 359
      ExplicitHeight = 144
    end
  end
end
