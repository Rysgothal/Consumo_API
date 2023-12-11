object frmBuscarCep: TfrmBuscarCep
  Left = 0
  Top = 0
  Width = 567
  Height = 51
  TabOrder = 0
  PixelsPerInch = 96
  object lbeCepConsulta: TLabeledEdit
    Left = 16
    Top = 19
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
    Top = 13
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
