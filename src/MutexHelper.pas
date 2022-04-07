unit MutexHelper;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI;

type
  TMutexHelper = class
  private
    m_mutexes: TDictionary<String, THandle>;
  public
    Constructor Create; overload;   // This constructor uses defaults

    // Functions:
    function Check(mutexName:string): Boolean;

    // Procedures:
    procedure Unlock(mutexName:string);
    procedure Lock(mutexName:string);
  end;

implementation

constructor  TMutexHelper.Create;
begin
  m_mutexes := TDictionary<String, THandle>.Create;
end;

procedure TMutexHelper.Lock(mutexName:string);
var
  fMutex: THandle;
begin
  fMutex := CreateMutex(nil, True, PChar(mutexName));

  if fMutex = 0 then
  begin
    RaiseLastOSError;
  end
  else
  begin
    m_mutexes.Add(mutexName, fMutex);
  end;
end;

procedure TMutexHelper.Unlock(mutexName:string);
var
  fMutex: THandle;
begin
  if m_mutexes.ContainsKey(mutexName) then
  begin
    m_mutexes.TryGetValue(mutexName, fMutex);

    if fMutex = 0 then
      Exit; // Didn't have a mutex lock

    CloseHandle(fMutex);
    fMutex := 0;
    m_mutexes.Remove(mutexName)
  end
end;

function TMutexHelper.Check(mutexName:string): Boolean;
var
  fMutex: THandle;
begin
  Lock(mutexName);

  Result := (GetLastError = ERROR_ALREADY_EXISTS);

  if Result <> True then
    Unlock(mutexName);
end;

end.
