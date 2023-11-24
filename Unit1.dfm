object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  TextHeight = 15
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 628
    Height = 25
    ActionManager = ActionManager1
    Caption = 'ActionToolBar1'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 10461087
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clWhite
    ColorMap.SelectedFontColor = clWhite
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    Spacing = 0
    ExplicitWidth = 624
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = Action1
            Caption = '&Start'
          end
          item
            Action = Action2
            Caption = 'S&top'
          end
          item
            Caption = '-'
          end
          item
            Action = Action3
            Caption = '&Reset'
          end>
        ActionBar = ActionToolBar1
      end>
    Left = 184
    Top = 96
    StyleName = 'Platform Default'
    object Action1: TAction
      Category = 'Main'
      Caption = 'Start'
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Category = 'Main'
      Caption = 'Stop'
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Category = 'Main'
      Caption = 'Reset'
      OnExecute = Action3Execute
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 184
    Top = 152
  end
end
