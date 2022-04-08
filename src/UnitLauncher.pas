unit UnitLauncher;
interface
uses
  Winapi.Windows, System.SysUtils, System.Classes,
  ShellAPI, MutexHelper;

type
  TKPLauncher = class
  const
    // Mutex is used to block duplicate app launch on the same PC
    // Random GUID generated in Delphi by Ctrl+Shift+G
    KP_MUTEX = 'DA046FE1-82E6-45EA-B25E-2C3F2350593C';
    LAUNCHER_MUTEX = '44E15CC0-6DEB-4C1D-98C0-3F487F6DBEC6';
  private
    fMutexHelper: TMutexHelper;
  public
    constructor Create;
    destructor Destroy; override; //@Life: Destructor is inherited from base class (and unlike Create always needs to be overriden)

    function CheckDuplicateLauncher: Boolean;
    function CheckDuplicateGame: Boolean;

    procedure UnlockLauncherMutex;
    procedure LockLauncherMutex;
    procedure LaunchGame;
  end;

implementation


constructor TKPLauncher.Create;
begin
  inherited; //@Life: Always call inherited when inheriting from something. Good practice

  fMutexHelper := TMutexHelper.Create;
end;


destructor TKPLauncher.Destroy;
begin
  //@Life: Destroy manually what we have created. No GC :-)
  FreeAndNil(fMutexHelper);

  inherited;
end;


function TKPLauncher.CheckDuplicateLauncher: Boolean;
begin
  Result := fMutexHelper.Check(LAUNCHER_MUTEX);
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
  fMutexHelper.Unlock(LAUNCHER_MUTEX);
end;


procedure TKPLauncher.LockLauncherMutex;
begin
  fMutexHelper.Lock(LAUNCHER_MUTEX);
end;


end.
