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
    Width = 617
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
    Width = 241
    Height = 155
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Caption = 'Loading data...'
    TabOrder = 7
    Visible = False
  end
  object btnReport: TButton
    Left = 631
    Top = 247
    Width = 145
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Preview Report'
    TabOrder = 8
    OnClick = btnReportClick
  end
  object conAdo: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\Z\RessiveWinDisk' +
      'Size DISK MAP REPORTs\WinDiskSizeRpt MAIN (2020.10.17.).mdb;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 112
    Top = 40
  end
  object qryAdo_Tasks: TADOQuery
    Active = True
    Connection = conAdo
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT DISTINCT Task.ID as TaskID, Task.Status,'
      'switch('
      '  Task.Status = 1, '#39'Planned'#39','
      '  Task.Status = 2, '#39'Started'#39','
      '  Task.Status = 3, '#39'Completed'#39','
      '  Task.Status = 4, '#39'Report'#39',) as StatusStr,'
      'Task.Machine, Task.StartDate, Task.EndDate,'
      'Task.FolderType + '#39' - '#39' + Task.FolderPath as FolderStr,'
      'Task.Label,'
      
        'Task.StorageFree + '#39' free of '#39' + Task.StorageSize as StorageSize' +
        'Str'
      'FROM Task'
      'INNER JOIN FolderRAW ON FolderRAW.ReportSubTaskID = Task.ID'
      'WHERE FolderRAW.TaskID = 1'
      'ORDER BY Task.ID')
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
  object frxRpt: TfrxReport
    Version = '6.8'
    DataSet = frxDBDS_Tasks
    DataSetName = 'frxDBDataset1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44140.716742361100000000
    ReportOptions.LastChange = 44140.725265000000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 656
    Top = 320
    Datasets = <
      item
        DataSet = frxDBDS_Tasks
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object frxDBDataset1Label: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 15.118120000000000000
        Top = 30.236240000000000000
        Width = 400.630180000000000000
        Height = 18.897650000000000000
        DataField = 'Label'
        DataSet = frxDBDS_Tasks
        DataSetName = 'frxDBDataset1'
        Frame.Typ = []
        Memo.UTF8W = (
          '[frxDBDataset1."Label"]')
      end
      object frxDBDataset1TaskID: TfrxMemoView
        IndexTag = 1
        AllowVectorExport = True
        Left = 15.118120000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'TaskID'
        DataSet = frxDBDS_Tasks
        DataSetName = 'frxDBDataset1'
        Frame.Typ = []
        Memo.UTF8W = (
          '[frxDBDataset1."TaskID"]')
      end
    end
  end
  object frxDBDS_Tasks: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = qryAdo_Tasks
    BCDToCurrency = False
    Left = 576
    Top = 320
  end
end
