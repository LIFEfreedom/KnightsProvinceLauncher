unit UnitLauncher;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI;

type
  TKPLauncher = class
  private
  public
    procedure CheckUpdate;
    procedure LaunchGame;
  end;

implementation

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

procedure TKPLauncher.CheckUpdate;
begin
  { check update }
end;

end.
