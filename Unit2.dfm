object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 442
  ClientWidth = 1111
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  TextHeight = 15
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 1111
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
    ExplicitWidth = 1107
  end
  object Panel1: TPanel
    Left = 896
    Top = 25
    Width = 215
    Height = 417
    Align = alRight
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitLeft = 892
    ExplicitHeight = 416
    object ListBox1: TListBox
      Left = 81
      Top = 1
      Width = 133
      Height = 415
      Align = alRight
      DoubleBuffered = False
      ItemHeight = 15
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = ListBox1Click
      ExplicitHeight = 414
    end
    object ListBox2: TListBox
      Left = 1
      Top = 1
      Width = 80
      Height = 415
      Align = alClient
      DoubleBuffered = False
      ItemHeight = 15
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = ListBox2Click
      ExplicitHeight = 414
    end
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
            Caption = '&Execute'
          end
          item
            Action = Action3
            Caption = '&Listbox'
          end>
        ActionBar = ActionToolBar1
      end>
    Left = 440
    Top = 120
    StyleName = 'Platform Default'
    object Action1: TAction
      Category = 'menu'
      Caption = 'Start'
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Category = 'menu'
      Caption = 'Execute'
      OnExecute = Action2Execute
    end
    object Action3: TAction
      Category = 'menu'
      AutoCheck = True
      Caption = 'Listbox'
      Checked = True
      OnExecute = Action3Execute
    end
  end
end
