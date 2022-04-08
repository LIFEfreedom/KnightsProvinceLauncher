unit MutexHelper;
interface
uses
  Winapi.Windows, System.SysUtils, System.Generics.Collections,
  ShellAPI;

type
  TMutexHelper = class
  private
    fMutexes: TDictionary<string, THandle>;
  public
    // @Life: Hint, we can pass aMutexName into constructor and store it.
    // It will be much simpler for a user to use 2 mutex helpers rather than remember to pass different variables
    // and you wont need a dictionary here too
    constructor Create;

    function Check(aMutexName: string): Boolean;

    procedure Unlock(aMutexName: string);
    procedure Lock(aMutexName: string);
  end;


implementation


constructor TMutexHelper.Create;
begin
  inherited; //@Life: Always call inherited when inheriting from something. Good practice

  fMutexes := TDictionary<String, THandle>.Create;
end;


procedure TMutexHelper.Lock(aMutexName: string);
var
  fMutex: THandle;
begin
  fMutex := CreateMutex(nil, True, PChar(aMutexName));

  if fMutex = 0 then
  begin
    RaiseLastOSError;
  end
  else
  begin
    fMutexes.Add(aMutexName, fMutex);
  end;
end;


procedure TMutexHelper.Unlock(aMutexName: string);
var
  mutex: THandle;
begin
  if fMutexes.ContainsKey(aMutexName) then
  begin
    fMutexes.TryGetValue(aMutexName, mutex);

    if mutex = 0 then
      Exit; // Didn't have a mutex lock

    CloseHandle(mutex);
    mutex := 0;
    fMutexes.Remove(aMutexName)
  end
end;


function TMutexHelper.Check(aMutexName: string): Boolean;
begin
  Lock(aMutexName);

  Result := (GetLastError = ERROR_ALREADY_EXISTS);

  if Result <> True then
    Unlock(aMutexName);
end;


end.
