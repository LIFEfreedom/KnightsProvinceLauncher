unit UnitLauncher;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI, MutexHelper;

type
  TKPLauncher = class
  const
    // Mutex is used to block duplicate app launch on the same PC
    // Random GUID generated in Delphi by Ctrl+Shift+G
    KP_MUTEX = 'DA046FE1-82E6-45EA-B25E-2C3F2350593C';
    Launcher_MUTEX = '44E15CC0-6DEB-4C1D-98C0-3F487F6DBEC6';
  private
    fMutexHelper: TMutexHelper;
  public
    Constructor Create; overload;

    // Functions:
    function CheckDuplicateLauncher: Boolean;
    function CheckDuplicateGame: Boolean;

    // Procedures:
    procedure UnlockLauncherMutex;
    procedure LockLauncherMutex;
    procedure LaunchGame;
  end;

implementation


constructor  TKPLauncher.Create;
begin
  fMutexHelper := TMutexHelper.Create;
end;


function TKPLauncher.CheckDuplicateLauncher: Boolean;
begin
  Result := fMutexHelper.Check(Launcher_MUTEX);
end;


function TKPLauncher.CheckDuplicateGame: Boolean;
begin
  Result := fMutexHelper.Check(KP_MUTEX);
end;


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
  fMutexHelper.Unlock(Launcher_MUTEX);
end;


procedure TKPLauncher.LockLauncherMutex;
begin
  fMutexHelper.Lock(Launcher_MUTEX);
end;

end.
