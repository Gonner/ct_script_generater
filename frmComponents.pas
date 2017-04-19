unit frmComponents;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls;

type

  { TFormComponents }

  TFormComponents = class(TForm)
    cgFPC: TCheckGroup;
    cgTyphon: TCheckGroup;
    pgComp: TPageControl;
    sbTyphon: TScrollBox;
    sbFPC: TScrollBox;
    tsTyphon: TTabSheet;
    tsFPC: TTabSheet;
    procedure FormCreate(Sender: TObject);
  private
    procedure LoadFPCPkgs();
    procedure LoadTyphonPkgs();
  public

  end;

var
  FormComponents: TFormComponents;

implementation

{$R *.lfm}

{ TFormComponents }

procedure TFormComponents.FormCreate(Sender: TObject);
begin
  LoadFPCPkgs();
  LoadTyphonPkgs();
end;

procedure TFormComponents.LoadFPCPkgs;
var
  src: TSearchRec;
  path: string;
begin
  {$IFDEF WINDOWS}
  path := 'C:\codetyphon\fpcsrc\packages\*';
  {$ELSE}
  path := '/usr/local/codetyphon/fpcsrc/packages/*';
  {$ENDIF}
  cgFPC.Items.BeginUpdate;
  cgFPC.Items.Clear;
  if (FindFirst(path, faDirectory, src) = 0) then begin
    repeat
      if (src.Name = '.') or (src.Name = '..') then Continue;
      cgFPC.Items.Add(src.Name);
    until FindNext(src) <> 0;
    FindClose(src);
  end;
  cgFPC.Items.EndUpdate;
end;

procedure TFormComponents.LoadTyphonPkgs;
var
  src: TSearchRec;
  path: string;
begin
  {$IFDEF WINDOWS}
  path := 'C:\codetyphon\typhon\components\*';
  {$ELSE}
  path := '/usr/local/codetyphon/typhon/components/*';
  {$ENDIF}
  cgTyphon.Items.BeginUpdate;
  cgTyphon.Items.Clear;
  if (FindFirst(path, faDirectory, src) = 0) then begin
    repeat
      if (src.Name = '.') or (src.Name = '..') then Continue;
      cgTyphon.Items.Add(src.Name);
    until FindNext(src) <> 0;
    FindClose(src);
  end;
  cgTyphon.Items.EndUpdate;
end;

end.

