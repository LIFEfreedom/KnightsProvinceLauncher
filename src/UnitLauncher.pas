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
    KP_MUTEX = 'DA046FE1-82E6-45EA-B25E-2C3F2350593C';
    LAUNCHER_MUTEX = '44E15CC0-6DEB-4C1D-98C0-3F487F6DBEC6';
  private
    fMutex: THandle;
    fGameMutex: THandle;
  public
    // Functions:
    function CheckDuplicateLauncher: Boolean;
    function CheckDuplicateGame: Boolean;
    function CheckLauncherUpdate: Boolean;
    function CheckGameUpdate: Boolean;

    // Procedures:
    procedure UpdateLauncher;
    procedure UpdateGame;
    procedure LaunchGame;
    procedure UnlockLauncherMutex;
    procedure LockLauncherMutex;
    procedure UnlockGameMutex;
    procedure LockGameMutex;
  end;

implementation


function TKPLauncher.CheckDuplicateLauncher: Boolean;
begin
  LockLauncherMutex;

  Result := (GetLastError = ERROR_ALREADY_EXISTS);

  if not Result then
    UnlockLauncherMutex;

  // Close our own handle on the mutex because someone else already made the mutex
  CloseHandle(fMutex);
  fMutex := 0;
end;


function TKPLauncher.CheckDuplicateGame: Boolean;
begin
  LockGameMutex;

  Result := (GetLastError = ERROR_ALREADY_EXISTS);

  if not Result then
    UnlockGameMutex;

  // Close our own handle on the mutex because someone else already made the mutex
  CloseHandle(fMutex);
  fMutex := 0;
end;


function TKPLauncher.CheckLauncherUpdate : Boolean;
begin
  Result := True;
end;


function TKPLauncher.CheckGameUpdate : Boolean;
begin
  Result := True;
end;


procedure TKPLauncher.UpdateLauncher;
begin
  { check update }
end;


procedure TKPLauncher.UpdateGame;
begin
  { check update }
end;


{ TKPLauncher }
procedure TKPLauncher.LaunchGame;
var
//  si: TStartupInfo;
//  pi: TProcessInformation;
  shi: TShellExecuteInfo;
begin
  shi := Default(TShellExecuteInfo);
  shi.cbSize := SizeOf(TShellExecuteInfo);
  shi.lpFile := PChar('KnightsProvince.exe');
  shi.nShow := SW_SHOWNORMAL;

  ShellExecuteEx(@shi);
end;


procedure TKPLauncher.UnlockLauncherMutex;
begin
  if fMutex = 0 then
    Exit; // Didn't have a mutex lock

  CloseHandle(fMutex);
  fMutex := 0;
end;


procedure TKPLauncher.LockLauncherMutex;
begin
  fMutex := CreateMutex(nil, True, PChar(Launcher_MUTEX));

  if fMutex = 0 then
    RaiseLastOSError;
end;


procedure TKPLauncher.UnlockGameMutex;
begin
  if fGameMutex = 0 then
    Exit; // Didn't have a mutex lock

  CloseHandle(fGameMutex);
  fGameMutex := 0;
end;


procedure TKPLauncher.LockGameMutex;
begin
  fGameMutex := CreateMutex(nil, True, PChar(KP_MUTEX));

  if fGameMutex = 0 then
    RaiseLastOSError;
end;


end.
