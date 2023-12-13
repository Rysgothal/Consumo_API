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
  KeyPreview = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
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
    inline frmBuscarCep: TfrmBuscarCep
      Left = 1
      Top = 1
      Width = 579
      Height = 63
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 579
      ExplicitHeight = 63
      inherited lbeCepConsulta: TLabeledEdit
        Top = 21
        EditLabel.ExplicitTop = 3
        ExplicitTop = 21
      end
      inherited btnPesquisar: TButton
        Left = 455
        Top = 18
        ExplicitLeft = 455
        ExplicitTop = 18
      end
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
        OnClick = frmDadosViaCepbtnLimparClick
        ExplicitLeft = 470
      end
      inherited btnMaps: TButton
        Left = 15
        ExplicitLeft = 15
      end
    end
  end
end
