object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'API'
  ClientHeight = 414
  ClientWidth = 504
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mmnMenuPrincipal
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object imgLogoGanso: TImage
    Left = 92
    Top = 134
    Width = 320
    Height = 114
    AutoSize = True
    Center = True
    OnMouseEnter = imgLogoGansoMouseEnter
    OnMouseLeave = imgLogoGansoMouseLeave
  end
  object sttsbarBarraStatus: TStatusBar
    Left = 0
    Top = 395
    Width = 504
    Height = 19
    Color = clAppWorkSpace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Panels = <
      item
        Bevel = pbNone
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 250
      end
      item
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = '00:00:00'
        Width = 50
      end>
    UseSystemFont = False
  end
  object tmrTempoAtual: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tmrTempoAtualTimer
    Left = 440
    Top = 344
  end
  object mmnMenuPrincipal: TMainMenu
    Images = dmPrincipal.imglistIcons
    Left = 48
    Top = 16
    object menuConsultar: TMenuItem
      Bitmap.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000C30E0000C30E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5ECE2DFC3D4CFA5CBC491C7C089C6BF
        88CBC491D3CEA4E3DFC3F6F5ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5EDD8D3ADC7C08AC6BF88C7C089
        C7C089C7C089C6BF88C7C089C6BF88C7C089C4BE88C4BF9FF1F0E9FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE8E5CFC8C18CC6BF88C6
        BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C1BA85A5A0739E996E
        A29E73D9D7C5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE3DFC3C7C0
        89C6BF88C7C089C7C089C6BF88C7C089C7C089C7C089C6BF88C7C089BDB682A2
        9C709F9A6E9E996E9F9A6E9F9A6FCFCDB6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        E8E5CFC7C089C7C089C6BF88C7C089C7C089C6BF88C7C089C7C089C7C089C6BF
        88B8B17EA09B6F9F9A6E9F9A6E9E996E9F9A6E9F9A6E9F9A6FD9D7C5FFFFFFFF
        FFFFFFFFFFF6F5EDC8C18CC6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88
        C6BF88C6BF88B2AC7B9F9A6F9E996E9D98716C6EB16668B99995759E996E9E99
        6EA29E73F1F0E9FFFFFFFFFFFFD8D3ADC6BF88C7C089C7C089C6BF88C7C089C7
        C089C6BF88C7C089C5BE87ACA6769E996E9F9A6E9E996F6467BB434AE7434AE6
        7B7B9C9F9A6E9E996E9F9A6EBDBA9AFFFFFFF6F5ECC7C08AC6BF88C7C089C7C0
        89C6BF88C7C089C7C089C6BF88C3BC86A7A1739F9A6E9E996E9E996E6C6DB243
        4AE7434AE7494FE0918E7F9F9A6E9E996E9F9A6EA09B6FF0EFE8E2DFC3C6BF88
        C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88BAB48A8483997474A77979A0918D
        807374A8444BE6434AE6474DE288868C9E996E9E996E9E996E9E996E9E996ECF
        CCB6D4CFA5C7C089C6BF88C7C089C7C089C6BF88C7C0899795AA4C52E0434AE7
        434AE7434AE7444BE6434AE6434AE6444BE48281939E996E9F9A6E9F9A6E9E99
        6E9F9A6E9F9A6EB6B391CBC491C7C089C6BF88C7C089C7C089C6BF889997A943
        4AE6454CE46668B87B7A9D7272A94E54D8434AE7434AE67C7B9B9F9A6E9E996E
        9F9A6E9F9A6E9E996E9F9A6EA19C6FBDB688C7C089C7C089C6BF88C7C089C7C0
        89C2BC8C4E54DE444BE585838F9F9A6E9F9A6E9F9A6E9894765358D0434AE680
        7F959F9A6E9E996E9F9A6E9F9A6E9E996EA6A173C0BA84C6BF88C6BF88C6BF88
        C6BF88C6BF88C6BF88A19EA3434AE66366BD9E996E9E996E9E996E9E996E9E99
        6E85848F434AE66265BE9E996E9E996E9E996E9F9A6FAFA979C5BE88C6BF88C6
        BF88CBC491C7C089C6BF88C7C089C7C089908FAF434AE77575A49E996E9F9A6E
        9F9A6E9F9A6E9E996E989476434AE6565ACD9F9A6E9E996EA19B6FB8B27FC6BF
        88C7C089C7C089CAC390D3CEA4C6BF88C6BF88C6BF88C6BF889A98A8434AE66B
        6DB39E996E9E996E9E996E9E996E9E996E8D8A85434AE65E61C49E996EA6A073
        C0BA84C6BF88C6BF88C6BF88C6BF88D3CEA4E3DFC3C7C089C6BF88C7C089C7C0
        89BCB690464DE4484EDF93907D9F9A6E9F9A6E9F9A6E9E996F6063BF434AE676
        77A2AEA978C5BE88C7C089C7C089C6BF88C7C089C7C089E2DFC3F6F5ECC7C08A
        C6BF88C7C089C7C089C6BF888282B9434AE74E54D97D7C9A928E7F88868B6063
        C1434AE75258D7B4AF84C6BF88C6BF88C7C089C7C089C6BF88C7C089C7C08AF6
        F5ECFFFFFFD7D2ACC6BF88C6BF88C6BF88C6BF88C5BE8A787AC1444BE6434AE6
        434AE6434AE6434AE6585CD8B3AE95C6BF88C6BF88C6BF88C6BF88C6BF88C6BF
        88C6BF88D7D2ACFFFFFFFFFFFFF6F5EDC8C18CC7C089C7C089C6BF88C7C089C7
        C089A8A49E797AC0686BCC6F71C79391ADC2BC8BC6BF88C7C089C7C089C6BF88
        C7C089C7C089C6BF88C9C28DF6F5EDFFFFFFFFFFFFFFFFFFE8E5CFC7C089C7C0
        89C6BF88C7C089C7C089C6BF88C7C089C7C089C7C089C6BF88C7C089C6BF88C7
        C089C7C089C6BF88C7C089C7C089C6BF88E9E6D0FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE2DFC3C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF
        88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88C6BF88E2DFC3FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E6D0C8C18CC7C089C7C089C6BF88C7C089
        C7C089C7C089C6BF88C7C089C6BF88C7C089C7C089C6BF88C9C28DE9E6D0FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6F5EDD8D3ADC7
        C08AC6BF88C7C089C7C089C7C089C6BF88C7C089C6BF88C7C089C7C08AD7D2AC
        F6F5EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFF6F5ECE2DFC3D3CEA4CAC390C6BF88C6BF88CAC390D3CEA4E2
        DFC3F6F5ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Caption = 'Consultar'
      ImageIndex = 1
      object menuConsultarViaCep: TMenuItem
        Caption = 'Cep'
        ImageIndex = 0
        OnClick = menuConsultarViaCepClick
      end
      object mmnIBGE: TMenuItem
        Caption = 'IBGE'
        object mmnIBGERegioes: TMenuItem
          Caption = 'Regi'#245'es'
          OnClick = mmnIBGERegioesClick
        end
        object mmnMesorregioes: TMenuItem
          Caption = 'Mesorregi'#245'es'
          OnClick = mmnMesorregioesClick
        end
      end
    end
  end
end