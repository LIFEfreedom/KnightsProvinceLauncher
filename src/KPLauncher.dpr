program KPLauncher;
uses
  Vcl.Forms,
  MainForm1 in 'MainForm1.pas' {MainForm},
  UnitLauncher in 'UnitLauncher.pas',
  MutexHelper in 'MutexHelper.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.