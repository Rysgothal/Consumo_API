object frmDadosRegiao: TfrmDadosRegiao
  Left = 0
  Top = 0
  Width = 351
  Height = 141
  TabOrder = 0
  PixelsPerInch = 96
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
    TabOrder = 3
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
    TabOrder = 4
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
end