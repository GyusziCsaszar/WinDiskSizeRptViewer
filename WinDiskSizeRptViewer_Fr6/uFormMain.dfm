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
    Active = True
    Connection = conAdo
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT (SELECT COUNT(*) FROM (SELECT DISTINCT A.ReportSubTaskID,' +
        ' A.NameLong'
      
        'FROM FolderRAW as A INNER JOIN Task as T1 ON A.ReportSubTaskID =' +
        ' T1.ID WHERE A.TaskID = 1)'
      'WHERE NameLong = B.NameLong) as CpyCnt,'
      'B.ReportSubTaskID as TaskID,'
      'T2.Label,'
      'B.FileCountSelf,'
      'B.FileCountSUM,'
      'B.FileSizeSelf,'
      'B.FileSizeSUM,'
      'B.MinFileDate,'
      'B.MaxFileDate,'
      'B.NameShort83,'
      'B.PathShort83,'
      'B.NameLong,'
      'B.PathLong,'
      'switch('
      
        'Round(B.FileSizeSUM,0) < 1024, Str(Round(B.FileSizeSUM,0)) + '#39' B' +
        #39','
      
        'Round(B.FileSizeSUM,0) > 1073741823, Str(Round(B.FileSizeSUM / 1' +
        '073741824,2)) + '#39' GB'#39','
      
        'Round(B.FileSizeSUM,0) > 1048575, Str(Round(B.FileSizeSUM / 1048' +
        '576,2)) + '#39' MB'#39','
      
        'Round(B.FileSizeSUM,0) > 1023, Str(Round(B.FileSizeSUM / 1024,2)' +
        ') + '#39' KB'#39',) as FileSizeSUMStr'
      
        'FROM FolderRAW as B INNER JOIN Task as T2 ON B.ReportSubTaskID =' +
        ' T2.ID'
      'WHERE B.TaskID = 1'
      
        'GROUP BY B.ReportSubTaskID, T2.Label, B.FileCountSelf, B.FileCou' +
        'ntSUM, B.FileSizeSelf,'
      
        'B.FileSizeSUM, B.MinFileDate, B.MaxFileDate, B.NameShort83, B.Pa' +
        'thShort83, B.NameLong, B.PathLong'
      'ORDER BY B.NameLong, B.ReportSubTaskID')
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
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 44140.716742361100000000
    ReportOptions.LastChange = 44142.758383078700000000
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
      end
      item
        DataSet = frxDBDS_Folders
        DataSetName = 'frxDBDataset2'
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
      ColumnWidth = 95.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 71.811070000000000000
        Top = 196.535560000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDS_Tasks
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object frxDBDataset1Label: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 170.078850000000000000
          Height = 71.811070000000000000
          DataField = 'Label'
          DataSet = frxDBDS_Tasks
          DataSetName = 'frxDBDataset1'
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."Label"]')
        end
        object frxDBDataset1StorageSizeStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 170.078850000000000000
          Width = 94.488250000000000000
          Height = 71.811070000000000000
          DataField = 'StorageSizeStr'
          DataSet = frxDBDS_Tasks
          DataSetName = 'frxDBDataset1'
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."StorageSizeStr"]')
        end
        object frxDBDataset1Machine: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 264.567100000000000000
          Width = 83.149660000000000000
          Height = 71.811070000000000000
          DataField = 'Machine'
          DataSet = frxDBDS_Tasks
          DataSetName = 'frxDBDataset1'
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."Machine"]')
        end
        object frxDBDataset1StatusStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 347.716760000000000000
          Width = 94.488250000000000000
          Height = 71.811070000000000000
          DataField = 'StatusStr'
          DataSet = frxDBDS_Tasks
          DataSetName = 'frxDBDataset1'
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."StatusStr"]')
        end
        object frxDBDataset1StartDate: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 442.205010000000000000
          Width = 105.826840000000000000
          Height = 71.811070000000000000
          DataSet = frxDBDS_Tasks
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."StartDate"] and [frxDBDataset1."EndDate"]')
          ParentFont = False
        end
        object frxDBDataset1FolderStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 548.031850000000000000
          Width = 170.078850000000000000
          Height = 71.811070000000000000
          DataField = 'FolderStr'
          DataSet = frxDBDS_Tasks
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."FolderStr"]')
          ParentFont = False
        end
      end
      object Header1: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031540000000000000
        Top = 105.826840000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Top = 34.015770000000000000
          Width = 170.078850000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Label')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 170.078850000000000000
          Top = 34.015770000000000000
          Width = 94.488250000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Size')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 264.567100000000000000
          Top = 34.015770000000000000
          Width = 83.149660000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Machine')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 347.716760000000000000
          Top = 34.015770000000000000
          Width = 94.488250000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Status')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 442.205010000000000000
          Top = 34.015770000000000000
          Width = 105.826840000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Generated between')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 548.031850000000000000
          Top = 34.015770000000000000
          Width = 170.078850000000000000
          Height = 34.015770000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Type and Folder')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Top = 7.559060000000000000
          Width = 721.890230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'List of Disk Map Tasks Compared')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Win Disk Size Ex')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 275.905690000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page')
          ParentFont = False
        end
        object Page: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page#]')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 355.275820000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'of')
          ParentFont = False
        end
        object TotalPages: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 374.173470000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 18.897650000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 498.897960000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Printed on')
          ParentFont = False
        end
        object Date: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 574.488560000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Date]')
          ParentFont = False
        end
        object Time: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 661.417750000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[Time]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 445.984540000000000000
        Width = 718.110700000000000000
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 275.905690000000000000
          Top = 7.559060000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Page')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 328.819110000000000000
          Top = 7.559060000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[Page#]')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          AllowVectorExport = True
          Left = 355.275820000000000000
          Top = 7.559060000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'of')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 374.173470000000000000
          Top = 7.559060000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[TotalPages#]')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Width = 721.890230000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object Header2: TfrxHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 52.913420000000000000
        Top = 291.023810000000000000
        Width = 718.110700000000000000
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Top = 7.559060000000000000
          Width = 721.890230000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            
              'List of Level 1 only Folders with the Disk Map Task where copy e' +
              'xists')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Top = 34.015770000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Copy Count')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Top = 34.015770000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Disk Map Task Label')
          ParentFont = False
        end
        object Memo19: TfrxMemoView
          AllowVectorExport = True
          Left = 226.771800000000000000
          Top = 34.015770000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Folder Name')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 370.393940000000000000
          Top = 34.015770000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'Size')
          ParentFont = False
        end
        object Memo21: TfrxMemoView
          AllowVectorExport = True
          Left = 449.764070000000000000
          Top = 34.015770000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'File Count')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 517.795610000000000000
          Top = 34.015770000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'File Date (MIN)')
          ParentFont = False
        end
        object Memo23: TfrxMemoView
          AllowVectorExport = True
          Left = 616.063390000000000000
          Top = 34.015770000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            'File Date (MAX)')
          ParentFont = False
        end
      end
      object MasterData2: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 366.614410000000000000
        Width = 718.110700000000000000
        DataSet = frxDBDS_Folders
        DataSetName = 'frxDBDataset2'
        RowCount = 0
        Stretched = True
        object frxDBDataset2CpyCnt: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'CpyCnt'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxDBDataset2."CpyCnt"]')
          ParentFont = False
        end
        object frxDBDataset2Label: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 147.401670000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'Label'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset2."Label"]')
          ParentFont = False
        end
        object frxDBDataset2NameLong: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 226.771800000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'NameLong'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset2."NameLong"]')
          ParentFont = False
        end
        object frxDBDataset2FileSizeSUMStr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'FileSizeSUMStr'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset2."FileSizeSUMStr"]')
          ParentFont = False
        end
        object frxDBDataset2FileCountSUM: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 449.764070000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'FileCountSUM'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset2."FileCountSUM"]')
          ParentFont = False
        end
        object frxDBDataset2MinFileDate: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 517.795610000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'MinFileDate'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset2."MinFileDate"]')
          ParentFont = False
        end
        object frxDBDataset2MaxFileDate: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 616.063390000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          StretchMode = smMaxHeight
          DataField = 'MaxFileDate'
          DataSet = frxDBDS_Folders
          DataSetName = 'frxDBDataset2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset2."MaxFileDate"]')
          ParentFont = False
        end
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
  object frxDBDS_Folders: TfrxDBDataset
    UserName = 'frxDBDataset2'
    CloseDataSource = False
    DataSet = qryAdo_Folders
    BCDToCurrency = False
    Left = 576
    Top = 376
  end
end
