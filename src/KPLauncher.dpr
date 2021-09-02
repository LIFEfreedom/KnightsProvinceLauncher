program KPLauncher;

uses
  Vcl.Forms,
  MainForm1 in 'MainForm1.pas' {MainForm},
  UnitLauncher in 'UnitLauncher.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  AApplication.CreateForm(TMainForm, MainForm);
  pplication.Run;
end.
