unit untProjInfo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

type

  { TProjectInfo }

  TProjectInfo = class
  private
    FCompileHost: Integer;
    FFPCPackages: TStringList;
    FIni: TIniFile;
    FPath: string;
    FClean: Boolean;
    FDebug: Boolean;
    FDesktop: Boolean;
    FIncludeList: TStringList;
    FLibraryList: TStringList;
    FLpr: string;
    FOptLevel: Integer;
    FTyphonPackages: TStringList;
    FUnitList: TStringList;
  public
    constructor Create(APath: string);
    procedure Save();
    destructor Destroy; override;
  published
    property Lpr: string read FLpr write FLpr;
    property IncludeList: TStringList read FIncludeList write FIncludeList;
    property UnitList: TStringList read FUnitList write FUnitList;
    property LibraryList: TStringList read FLibraryList write FLibraryList;
    property Debug: Boolean read FDebug write FDebug;
    property OptLevel: Integer read FOptLevel write FOptLevel;
    property Desktop: Boolean read FDesktop write FDesktop;
    property Clean: Boolean read FClean write FClean;
    property CompileHost: Integer read FCompileHost write FCompileHost;
    property TyphonPackages: TStringList read FTyphonPackages write FTyphonPackages;
    property FPCPackages: TStringList read FFPCPackages write FFPCPackages;
  end;

implementation

const
  SEC_PROJ = 'Project';
  SEC_INCLUDE = 'Include';
  SEC_UNIT = 'Unit';
  SEC_LIBRARY = 'Library';
  SEC_TYPHON_PKG = 'TyphonPkg';
  SEC_FPC_PKG = 'FPCPkg';

  KEY_LPR = 'lpr';
  KEY_DEBUG = 'debug';
  KEY_OPTLEVEL = 'optlvl';
  KEY_DESKTOP = 'desktop';
  KEY_CLEAN = 'clean';
  KEY_HOST = 'host';

{ TProjectInfo }

constructor TProjectInfo.Create(APath: string);
var
  sl: TStringList;
  i: Integer;
begin
  FIncludeList := TStringList.Create;
  FUnitList := TStringList.Create;
  FLibraryList := TStringList.Create;
  FTyphonPackages := TStringList.Create;
  FFPCPackages := TStringList.Create;

  FPath:= APath;
  if (not FileExists(FPath)) then Exit;
  FIni := TIniFile.Create(FPath);
  FLpr:= FIni.ReadString(SEC_PROJ, KEY_LPR, '');

  sl := TStringList.Create;
  FIni.ReadSection(SEC_INCLUDE, sl);
  for i := 0 to sl.Count - 1 do FIncludeList.Add(sl[i]);
  FIni.ReadSection(SEC_UNIT, sl);
  for i := 0 to sl.Count - 1 do FUnitList.Add(sl[i]);
  FIni.ReadSection(SEC_LIBRARY, sl);
  for i := 0 to sl.Count - 1 do FLibraryList.Add(sl[i]);
  FIni.ReadSection(SEC_TYPHON_PKG, sl);
  for i := 0 to sl.Count - 1 do FTyphonPackages.Add(sl[i]);
  FIni.ReadSection(SEC_FPC_PKG, sl);
  for i := 0 to sl.Count - 1 do FFPCPackages.Add(sl[i]);
  sl.Free;

  FDebug:= FIni.ReadBool(SEC_PROJ, KEY_DEBUG, False);
  FOptLevel:= FIni.ReadInteger(SEC_PROJ, KEY_OPTLEVEL, 0);
  FDesktop:= FIni.ReadBool(SEC_PROJ, KEY_DESKTOP, False);
  FClean:= FIni.ReadBool(SEC_PROJ, KEY_CLEAN, True);
  FCompileHost:= FIni.ReadInteger(SEC_PROJ, KEY_HOST, 0);

  FIni.Free;
end;

procedure TProjectInfo.Save;
var
  i: Integer;
begin
  FIni := TIniFile.Create(FPath);
  FIni.WriteString(SEC_PROJ, KEY_LPR, FLpr);

  for i := 0 to FIncludeList.Count - 1 do FIni.WriteString(SEC_INCLUDE, FIncludeList[i], '');
  for i := 0 to FUnitList.Count - 1 do FIni.WriteString(SEC_INCLUDE, FUnitList[i], '');
  for i := 0 to FLibraryList.Count - 1 do FIni.WriteString(SEC_LIBRARY, FLibraryList[i], '');
  for i := 0 to FTyphonPackages.Count - 1 do FIni.WriteString(SEC_TYPHON_PKG, FTyphonPackages[i], '');
  for i := 0 to FFPCPackages.Count - 1 do FIni.WriteString(SEC_FPC_PKG, FFPCPackages[i], '');

  FIni.WriteBool(SEC_PROJ, KEY_DEBUG, FDebug);
  FIni.WriteInteger(SEC_PROJ, KEY_OPTLEVEL, FOptLevel);
  FIni.WriteBool(SEC_PROJ, KEY_DESKTOP, FDesktop);
  FIni.WriteBool(SEC_PROJ, KEY_CLEAN, FClean);
  FIni.WriteInteger(SEC_PROJ, KEY_HOST, FCompileHost);

  FIni.Free;
  FIncludeList.Free;
  FUnitList.Free;
  FLibraryList.Free;
  FTyphonPackages.Free;
  FFPCPackages.Free;
end;

destructor TProjectInfo.Destroy;
begin
  inherited Destroy;
end;

end.

