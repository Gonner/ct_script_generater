unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, LazFileUtils;

type

  { TFormMain }

  TFormMain = class(TForm)
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
    rgOptimize: TRadioGroup;
    procedure FormCreate(Sender: TObject);
  private

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

end.

