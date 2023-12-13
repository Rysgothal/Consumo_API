object frmSelecionarRegiao: TfrmSelecionarRegiao
  Left = 0
  Top = 0
  Width = 1114
  Height = 66
  TabOrder = 0
  PixelsPerInch = 96
  DesignSize = (
    1114
    66)
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
end
