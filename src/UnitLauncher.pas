unit UnitLauncher;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI;

type
  TKPLauncher = class
  const
    // Mutex is used to block duplicate app launch on the same PC
    // Random GUID generated in Delphi by Ctrl+Shift+G
    // @Life: Is this a KP mutex or Launcher mutex? Comment should be updated
    KP_MUTEX = 'DA046FE1-82E6-45EA-B25E-2C3F2350593C';
  private
    fMutex: THandle;
  public
    function CheckDuplicate;
    procedure CheckUpdate;
    procedure LaunchGame;
    procedure UnlockMutex;
    procedure LockMutex;
  end;

implementation

{ TKPLauncher }
procedure TKPLauncher.LaunchGame;
var
  si: TStartupInfo;
  pi: TProcessInformation;
  shi: TShellExecuteInfo;
begin
  shi := Default(TShellExecuteInfo);
  shi.cbSize := SizeOf(TShellExecuteInfo);
  shi.lpFile := PChar('KnightsProvince.exe');
  shi.nShow := SW_SHOWNORMAL;

  ShellExecuteEx(@shi);
end;


procedure TKPLauncher.LockMutex;
begin
  // if DBG_ALLOW_DOUBLE_APP then Exit;

  fMutex := CreateMutex(nil, True, PChar(KP_MUTEX));

  if fMutex = 0 then
    RaiseLastOSError;
end;


procedure TKPLauncher.CheckUpdate;
begin
  { check update }
end;


function TKPLauncher.CheckDuplicate: Boolean;
begin
  Result := True;
  // if DBG_ALLOW_DOUBLE_APP then Exit;

  LockMutex;

  Result := (GetLastError <> ERROR_ALREADY_EXISTS);

  if Result = True then
    UnlockMutex;
  // Close our own handle on the mutex because someone else already made the mutex
end;


procedure TKPLauncher.UnlockMutex;
begin
  // if DBG_ALLOW_DOUBLE_APP then Exit;
  if fMutex = 0 then
    Exit; // Didn't have a mutex lock

  CloseHandle(fMutex);
  fMutex := 0;
end;


end.
