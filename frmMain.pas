unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, LazFileUtils, untProjInfo;

type

  { TFormMain }

  TFormMain = class(TForm)
    btnIncludeDel: TButton;
    btnLibraryDel: TButton;
    btnUnitDel: TButton;
    bv1: TBevel;
    bv2: TBevel;
    btnLibrary: TButton;
    btnUnit: TButton;
    btnLprFile: TButton;
    btnInclude: TButton;
    btnLoad: TButton;
    btnSave: TButton;
    btnAndroid: TButton;
    btnIos: TButton;
    btnLinux: TButton;
    btnMac: TButton;
    btnWindows: TButton;
    btnSettings: TButton;
    btnAbout: TButton;
    chkClean: TCheckBox;
    chkDesktop: TCheckBox;
    chkDebug: TCheckBox;
    edtLprFile: TEdit;
    gbLibrary: TGroupBox;
    gbUnit: TGroupBox;
    gbLpr: TGroupBox;
    gbInclude: TGroupBox;
    gbExtra: TGroupBox;
    lvInclude: TListBox;
    lvLibrary: TListBox;
    lvUnit: TListBox;
    pnlButtons: TPanel;
    pnlExtra: TPanel;
    pnlInclude: TPanel;
    pnlLibrary: TPanel;
    pnlUnit: TPanel;
    pnlIncludeBtn: TPanel;
    pnlLibraryBtn: TPanel;
    pnlUnitBtn: TPanel;
    pnlLprFile: TPanel;
    rgHost: TRadioGroup;
    rgOptimize: TRadioGroup;
    procedure btnIncludeClick(Sender: TObject);
    procedure btnIncludeDelClick(Sender: TObject);
    procedure btnLibraryClick(Sender: TObject);
    procedure btnLibraryDelClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnLprFileClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnUnitClick(Sender: TObject);
    procedure btnUnitDelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rgHostClick(Sender: TObject);
  private
    procedure DoSelectDirectory(ADest: TListBox);
    procedure DoUnselectDirectory(ADest: TListBox);
  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin
  //
end;

procedure TFormMain.rgHostClick(Sender: TObject);
begin
  case rgHost.ItemIndex of
  0, 3:
    begin
      btnAndroid.Enabled:= True;
      btnLinux.Enabled:= True;
      btnIos.Enabled:= False;
      btnMac.Enabled:= False;
      btnWindows.Enabled:= False;
    end;
  1, 4:
    begin
      btnAndroid.Enabled:= False;
      btnLinux.Enabled:= False;
      btnIos.Enabled:= True;
      btnMac.Enabled:= True;
      btnWindows.Enabled:= False;
    end;
  2, 5:
    begin
      btnAndroid.Enabled:= False;
      btnLinux.Enabled:= False;
      btnIos.Enabled:= False;
      btnMac.Enabled:= False;
      btnWindows.Enabled:= True;
    end;
  end;
end;

procedure TFormMain.DoSelectDirectory(ADest: TListBox);
var
  base: string;
  p: string;
begin
  if (string(edtLprFile.Text).Trim = '') or (not FileExists(edtLprFile.Text)) then Exit;
  base := ExtractFilePath(edtLprFile.Text);
  with TSelectDirectoryDialog.Create(nil) do begin
    if (Execute) then begin
      p := CreateRelativePath(FileName, base, True);
      ADest.Items.Add(p);
    end;
    Free;
  end;
end;

procedure TFormMain.DoUnselectDirectory(ADest: TListBox);
var
  idx: Integer;
begin
  idx := ADest.ItemIndex;
  if (idx = -1) then Exit;
  ADest.Items.Delete(idx);
end;

procedure TFormMain.btnLprFileClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do begin
    Filter:= 'lpr file|*.lpr';
    if (Execute) then begin
      edtLprFile.Text:= FileName;
    end;
    Free;
  end;
end;

procedure TFormMain.btnSaveClick(Sender: TObject);
begin
  with TSaveDialog.Create(nil) do begin
    Filter:= 'projdesc|*.projdesc';
    DefaultExt:= 'projdesc';
    if (Execute) then begin
      with TProjectInfo.Create(FileName) do begin
        Lpr:= edtLprFile.Text;
        IncludeList.Text:= lvInclude.Items.Text;
        UnitList.Text:= lvUnit.Items.Text;
        LibraryList.Text:= lvLibrary.Items.Text;
        Debug:= chkDebug.Checked;
        OptLevel:= rgOptimize.ItemIndex;
        Desktop:= chkDesktop.Checked;
        Clean:= chkClean.Checked;
        CompileHost:= rgHost.ItemIndex;
        Save();
        Free;
      end;
    end;
    Free;
  end;
end;

procedure TFormMain.btnUnitClick(Sender: TObject);
begin
  DoSelectDirectory(lvUnit);
end;

procedure TFormMain.btnUnitDelClick(Sender: TObject);
begin
  DoUnselectDirectory(lvUnit);
end;

procedure TFormMain.btnIncludeClick(Sender: TObject);
begin
  DoSelectDirectory(lvInclude);
end;

procedure TFormMain.btnIncludeDelClick(Sender: TObject);
begin
  DoUnselectDirectory(lvInclude);
end;

procedure TFormMain.btnLibraryClick(Sender: TObject);
begin
  DoSelectDirectory(lvLibrary);
end;

procedure TFormMain.btnLibraryDelClick(Sender: TObject);
begin
  DoUnselectDirectory(lvLibrary);
end;

procedure TFormMain.btnLoadClick(Sender: TObject);
begin
  with TOpenDialog.Create(nil) do begin
    Filter:= 'projdesc|*.projdesc';
    if (Execute) then begin
      with TProjectInfo.Create(FileName) do begin
        edtLprFile.Text:= Lpr;
        lvInclude.Items.Text:= IncludeList.Text;
        lvUnit.Items.Text:= UnitList.Text;
        lvLibrary.Items.Text:= LibraryList.Text;
        chkDebug.Checked:= Debug;
        rgOptimize.ItemIndex:= OptLevel;
        chkDesktop.Checked:= Desktop;
        chkClean.Checked:= Clean;
        rgHost.ItemIndex:= CompileHost;
        Free;
      end;
    end;
    Free;
  end;
end;

end.

