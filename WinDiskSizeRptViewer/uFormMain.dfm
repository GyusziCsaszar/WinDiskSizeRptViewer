object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 461
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  DesignSize = (
    784
    461)
  PixelsPerInch = 96
  TextHeight = 13
  object edPath: TEdit
    Left = 8
    Top = 37
    Width = 729
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btnPath: TButton
    Left = 743
    Top = 35
    Width = 33
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 1
    OnClick = btnPathClick
  end
  object pnlTasks: TPanel
    Left = 8
    Top = 64
    Width = 768
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'List of Disk Map Tasks compated'
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 2
  end
  object dbGrid_Tasks: TDBGrid
    Left = 8
    Top = 95
    Width = 768
    Height = 146
    Anchors = [akLeft, akTop, akRight]
    DataSource = ds_Tasks
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object panFolders: TPanel
    Left = 8
    Top = 247
    Width = 768
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 
      'List of Level 1 only Folders with the Disk Map Task where copy e' +
      'xists'
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 4
  end
  object dbGrid_Folders: TDBGrid
    Left = 8
    Top = 280
    Width = 768
    Height = 173
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds_Folders
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlPath: TPanel
    Left = 8
    Top = 6
    Width = 768
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Win Disk Size Report path (*.mdb)'
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 6
  end
  object pnlCover: TPanel
    Left = 0
    Top = -2
    Width = 776
    Height = 455
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'Loading data...'
    TabOrder = 7
    Visible = False
  end
  object conAdo: TADOConnection
    Left = 112
    Top = 40
  end
  object qryAdo_Tasks: TADOQuery
    Connection = conAdo
    Parameters = <>
    Left = 48
    Top = 152
  end
  object ds_Tasks: TDataSource
    DataSet = qryAdo_Tasks
    Left = 120
    Top = 152
  end
  object qryAdo_Folders: TADOQuery
    Connection = conAdo
    Parameters = <>
    Left = 48
    Top = 312
  end
  object ds_Folders: TDataSource
    DataSet = qryAdo_Folders
    Left = 120
    Top = 312
  end
  object tmrOpen: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrOpenTimer
    Left = 680
    Top = 40
  end
  object OpenDialog1: TOpenDialog
    Left = 680
    Top = 112
  end
end
