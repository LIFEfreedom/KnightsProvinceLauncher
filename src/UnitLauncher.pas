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
    fMutexLauncher: TMutexHelper;
    fMutexGame: TMutexHelper;
  public
    constructor Create;
    destructor Destroy; override; //@Life: Destructor is inherited from base class (and unlike Create always needs to be overriden)

    function TryLockForLauncher: Boolean;
    function CheckDuplicateGame: Boolean;

    procedure LaunchGame;
  end;

implementation


constructor TKPLauncher.Create;
begin
  inherited; //@Life: Always call inherited when inheriting from something. Good practice

  fMutexLauncher := TMutexHelper.Create(LAUNCHER_MUTEX);
  fMutexGame := TMutexHelper.Create(KP_MUTEX);
end;


destructor TKPLauncher.Destroy;
begin
  //@Life: Destroy manually what we have created. No GC :-)
  FreeAndNil(fMutexLauncher);
  FreeAndNil(fMutexGame);

  inherited;
end;


function TKPLauncher.TryLockForLauncher: Boolean;
begin
  Result := fMutexLauncher.TryLock;
end;


function TKPLauncher.CheckDuplicateGame: Boolean;
begin
  Result := fMutexGame.TryLock;
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


end.
