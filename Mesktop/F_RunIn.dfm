object FRM_RunIn: TFRM_RunIn
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Run in ...'
  ClientHeight = 121
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LBL_Desktop: TLabel
    Left = 8
    Top = 16
    Width = 46
    Height = 13
    Caption = 'Desktop :'
  end
  object LBL_Program: TLabel
    Left = 8
    Top = 51
    Width = 47
    Height = 13
    Caption = 'Program :'
  end
  object CB_Desktops: TComboBox
    Left = 61
    Top = 13
    Width = 108
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'Default Desktop'
    Items.Strings = (
      'Default Desktop'
      'Desktop 1'
      'Desktop 2')
  end
  object ED_FilePath: TEdit
    Left = 61
    Top = 48
    Width = 276
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 4
  end
  object BTN_Browse: TButton
    Left = 343
    Top = 46
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = BTN_BrowseClick
  end
  object BTN_Run: TButton
    Left = 293
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Run'
    Default = True
    TabOrder = 2
    OnClick = BTN_RunClick
  end
  object BTN_Cancel: TButton
    Left = 8
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = BTN_CancelClick
  end
  object OD_File: TOpenDialog
    Filter = 'All files|*.*'
    Left = 272
    Top = 8
  end
end
