object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Calcolo del CIN'
  ClientHeight = 480
  ClientWidth = 534
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 534
    Height = 49
    Align = alTop
    TabOrder = 0
    DesignSize = (
      534
      49)
    object btnExit: TButton
      Left = 447
      Top = 13
      Width = 75
      Height = 25
      Action = ActionExit
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  object pnlSource: TPanel
    Left = 0
    Top = 49
    Width = 534
    Height = 117
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 15
      Top = 15
      Width = 24
      Height = 13
      Caption = 'IBAN'
    end
    object Label2: TLabel
      Left = 15
      Top = 57
      Width = 38
      Height = 13
      Caption = 'Nazione'
    end
    object Label3: TLabel
      Left = 63
      Top = 57
      Width = 78
      Height = 13
      Caption = 'Codice Controllo'
    end
    object Label4: TLabel
      Left = 147
      Top = 57
      Width = 18
      Height = 13
      Caption = 'CIN'
    end
    object Label5: TLabel
      Left = 191
      Top = 57
      Width = 17
      Height = 13
      Caption = 'ABI'
    end
    object Label6: TLabel
      Left = 268
      Top = 57
      Width = 20
      Height = 13
      Caption = 'CAB'
    end
    object Label7: TLabel
      Left = 344
      Top = 56
      Width = 75
      Height = 13
      Caption = 'Conto Corrente'
    end
    object edtIBAN: TEdit
      Left = 15
      Top = 30
      Width = 214
      Height = 21
      Hint = 'Inserire l'#39'IBAN da verificare'
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnExtrac: TButton
      Left = 235
      Top = 28
      Width = 75
      Height = 25
      Action = ActionExtractor
      TabOrder = 1
    end
    object edtNationCode: TEdit
      Left = 15
      Top = 75
      Width = 38
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object edtControlCode: TEdit
      Left = 63
      Top = 75
      Width = 38
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object edtCINCode: TEdit
      Left = 147
      Top = 75
      Width = 38
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object edtABICode: TEdit
      Left = 191
      Top = 75
      Width = 70
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
    object edtCABCode: TEdit
      Left = 268
      Top = 75
      Width = 70
      Height = 21
      ReadOnly = True
      TabOrder = 6
    end
    object edtContoCode: TEdit
      Left = 343
      Top = 75
      Width = 174
      Height = 21
      ReadOnly = True
      TabOrder = 7
    end
  end
  object pnlCalc: TPanel
    Left = 0
    Top = 166
    Width = 534
    Height = 66
    Align = alTop
    TabOrder = 2
    object Label8: TLabel
      Left = 15
      Top = 12
      Width = 65
      Height = 13
      Caption = 'CIN Calcolato'
    end
    object edtCINResult: TEdit
      Left = 15
      Top = 31
      Width = 31
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnCalc: TButton
      Left = 52
      Top = 29
      Width = 75
      Height = 25
      Action = ActionCalculator
      TabOrder = 1
    end
  end
  object MemoLog: TMemo
    Left = 0
    Top = 232
    Width = 534
    Height = 248
    Align = alClient
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 285
    Top = 12
    object ActionExit: TAction
      Caption = 'Uscita'
      OnExecute = ActionExitExecute
    end
    object ActionCalculator: TAction
      Caption = 'Calcola'
      OnExecute = ActionCalculatorExecute
    end
    object ActionExtractor: TAction
      Caption = 'Estrai'
      OnExecute = ActionExtractorExecute
    end
  end
end
