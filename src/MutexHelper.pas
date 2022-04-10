unit MutexHelper;
interface
uses
  Winapi.Windows, System.SysUtils,
  ShellAPI;

type
  TMutexHelper = class
  private
    fMutexName: string;
    fHandle: THandle;
    procedure Unlock;
    procedure Lock;
  public
    // @Life: Hint, we can pass aMutexName into constructor and store it.
    // It will be much simpler for a user to use 2 mutex helpers rather than remember to pass different variables
    // and you wont need a dictionary here too
    constructor Create(const aMutexName: string);

    function TryLock: Boolean;
    function CheckLockExists: Boolean;
  end;


implementation


constructor TMutexHelper.Create(const aMutexName: string);
begin
  inherited Create; //@Life: Always call inherited when inheriting from something. Good practice

  fMutexName := aMutexName;
end;


procedure TMutexHelper.Lock;
begin
  fHandle := CreateMutex(nil, True, PChar(fMutexName));

  if fHandle = 0 then
    RaiseLastOSError;
end;


procedure TMutexHelper.Unlock;
begin
  if fHandle <> 0 then
  begin
    CloseHandle(fHandle);
    fHandle := 0;
  end
end;


function TMutexHelper.TryLock: Boolean;
begin
  Lock;

  Result := (GetLastError <> ERROR_ALREADY_EXISTS);

  if not Result then
    // Close our own handle on the mutex because someone else already made the mutex
    Unlock;
end;


function TMutexHelper.CheckLockExists: Boolean;
begin
  Lock;

  Result := (GetLastError = ERROR_ALREADY_EXISTS);

  // Always unlock our "test" mutex
  Unlock;
end;


end.
