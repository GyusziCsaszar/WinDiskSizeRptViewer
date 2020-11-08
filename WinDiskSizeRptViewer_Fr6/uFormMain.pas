unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, frxClass, frxDBSet;

type
  TFormMain = class(TForm)
    edPath: TEdit;
    btnPath: TButton;
    pnlTasks: TPanel;
    dbGrid_Tasks: TDBGrid;
    conAdo: TADOConnection;
    qryAdo_Tasks: TADOQuery;
    ds_Tasks: TDataSource;
    panFolders: TPanel;
    dbGrid_Folders: TDBGrid;
    qryAdo_Folders: TADOQuery;
    ds_Folders: TDataSource;
    tmrOpen: TTimer;
    OpenDialog1: TOpenDialog;
    pnlPath: TPanel;
    pnlCover: TPanel;
    btnReport: TButton;
    frxRpt: TfrxReport;
    frxDBDS_Tasks: TfrxDBDataset;
    frxDBDS_Folders: TfrxDBDataset;
    procedure FormShow(Sender: TObject);
    procedure tmrOpenTimer(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Open(sMdbPath: string);
    procedure FitGrid(Grid: TDBGrid);
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

constructor TFormMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Application.Title := 'Win Disk Size - Report Viewer (FastReport 6) v1.04';

  Self.Caption := Application.Title;

end;

procedure TFormMain.FormShow(Sender: TObject);
begin

  tmrOpen.Enabled := true;

end;

procedure TFormMain.tmrOpenTimer(Sender: TObject);
begin
  tmrOpen.Enabled := false;

  btnPath.Click();

end;

procedure TFormMain.btnPathClick(Sender: TObject);
begin

  OpenDialog1.Title := 'Win Disk Size Report';
  OpenDialog1.Filter := 'Microsoft Access Database (*.mdb)|*.mdb|';

  if OpenDialog1.Execute() then
  begin
    edPath.Text := OpenDialog1.FileName;
    Open(edPath.Text);
  end;

end;

procedure TFormMain.btnReportClick(Sender: TObject);
begin
  frxRpt.ShowReport();
end;

procedure TFormMain.Open(sMdbPath: string);
var
  sSQL: string;
begin

  try

    pnlCover.Visible := True;
    pnlCover.Update();

    //

    qryAdo_Tasks.Active := False;
    qryAdo_Tasks.SQL.Clear();

    qryAdo_Folders.Active := False;
    qryAdo_Folders.SQL.Clear();

    conAdo.Connected := False;

    //

    conAdo.LoginPrompt := False;

  //conAdo.CursorLocation := CursorLocationEnum.adUseClient;

    conAdo.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + sMdbPath + ';';
  //conAdo.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' + sMdbPath + ';';

    conAdo.Connected := True;

    //

    sSQL := 'SELECT DISTINCT Task.ID as TaskID, Task.Status'
          + ', switch('
          + '  Task.Status = 1, ''Planned'','
          + '  Task.Status = 2, ''Started'','
          + '  Task.Status = 3, ''Completed'','
          + '  Task.Status = 4, ''Report'','
          + ') as StatusStr'
          + ', Task.Machine, Task.StartDate, Task.EndDate'
          + ', Task.FolderType + '' - '' + Task.FolderPath as FolderStr' //', Task.FolderType, Task.FolderPath'
          + ', Task.Label' //', Task.StorageSize, Task.StorageFree'
          + ', Task.StorageFree + '' free of '' + Task.StorageSize as StorageSizeStr'
          + ' FROM Task'
          + ' INNER JOIN FolderRAW ON FolderRAW.ReportSubTaskID = Task.ID'
          + ' WHERE FolderRAW.TaskID = ' + '1' {iReportTaskID}
          + ' ORDER BY Task.ID';

    qryAdo_Tasks.SQL.Add(sSQL);
    qryAdo_Tasks.Active := True;

    //

    sSQL := 'SELECT ('
          +   'SELECT COUNT(*) FROM ('
          +     'SELECT DISTINCT A.ReportSubTaskID, A.NameLong'
          +     ' FROM FolderRAW as A'
          +     ' INNER JOIN Task as T1 ON A.ReportSubTaskID = T1.ID'
          +     ' WHERE A.TaskID = ' + '1' {iReportTaskID}
          +   ')'
          +   ' WHERE NameLong = B.NameLong'
          + ') as CpyCnt, B.ReportSubTaskID as TaskID, T2.Label, B.FileCountSelf, B.FileCountSUM, B.FileSizeSelf'
          + ', B.FileSizeSUM, B.MinFileDate, B.MaxFileDate, B.NameShort83, B.PathShort83'
          + ', B.NameLong, B.PathLong'
          + ', switch('
          + '  Round(B.FileSizeSUM,0) < 1024, Str(Round(B.FileSizeSUM,0)) + '' B'','
          + '  Round(B.FileSizeSUM,0) > 1073741823, Str(Round(B.FileSizeSUM / 1073741824,2)) + '' GB'','
          + '  Round(B.FileSizeSUM,0) > 1048575, Str(Round(B.FileSizeSUM / 1048576,2)) + '' MB'','
          + '  Round(B.FileSizeSUM,0) > 1023, Str(Round(B.FileSizeSUM / 1024,2)) + '' KB'','
        //+ '  true, Str(B.FileSizeSUM) + '' B'''
          + ') as FileSizeSUMStr'
          + ' FROM FolderRAW as B'
          + ' INNER JOIN Task as T2 ON B.ReportSubTaskID = T2.ID'
          + ' WHERE B.TaskID = ' + '1' {iReportTaskID}
          + ' GROUP BY B.ReportSubTaskID, T2.Label, B.FileCountSelf, B.FileCountSUM, B.FileSizeSelf'
          + ', B.FileSizeSUM, B.MinFileDate, B.MaxFileDate, B.NameShort83, B.PathShort83'
          + ', B.NameLong, B.PathLong'
          + ' ORDER BY B.NameLong, B.ReportSubTaskID';

    qryAdo_Folders.SQL.Add(sSQL);
    qryAdo_Folders.Active := True;

    //

    FitGrid(dbGrid_Tasks);
    FitGrid(dbGrid_Folders);

    //

    pnlCover.Visible := False;
    pnlCover.Update();

  except

    on exc: Exception do
    begin
      MessageDlg(Application.Title + CHR(10) + CHR(10) + 'Error: ' + exc.ClassName + ' - ' + exc.Message, mtError, [mbOk], 0);

      Self.Close();
    end;

  end;
end;

procedure TFormMain.FitGrid(Grid: TDBGrid);
// SRC: https://stackoverflow.com/questions/17509924/adjust-column-width-dbgrid
const
  C_Add=3;
var
  ds: TDataSet;
  bm: TBookmark;
  i: Integer;
  w: Integer;
  a: Array of Integer;
begin
  ds := Grid.DataSource.DataSet;
  if Assigned(ds) then
  begin
    ds.DisableControls;
    bm := ds.GetBookmark;
    try
      ds.First;
      SetLength(a, Grid.Columns.Count);
      while not ds.Eof do
      begin

        /////////////////
        // Added by Me!!!
        for i := 0 to Grid.Columns.Count - 1 do
        begin
            w :=  Grid.Canvas.TextWidth(Grid.Columns[i].Title.Caption);
            if a[i] < w  then
               a[i] := w ;
        end;
        // Added by Me!!!
        /////////////////

        for i := 0 to Grid.Columns.Count - 1 do
        begin
          if Assigned(Grid.Columns[i].Field) then
          begin
            w :=  Grid.Canvas.TextWidth(ds.FieldByName(Grid.Columns[i].Field.FieldName).DisplayText);
            if a[i] < w  then
               a[i] := w ;
          end;
        end;
        ds.Next;
      end;
      for I := 0 to Grid.Columns.Count - 1 do
        Grid.Columns[i].Width := a[i] + C_Add;
        ds.GotoBookmark(bm);
    finally
      ds.FreeBookmark(bm);
      ds.EnableControls;
    end;
  end;
end;

end.
