unit MainForm1;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI, UnitLauncher, Vcl.Imaging.pngimage;

type
  TMainForm = class(TForm)
    btnLaunch: TButton;
    imgLogo: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
  private
    { Private declarations }
    fLauncher: TKPLauncher;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnLaunchClick(Sender: TObject);
begin

  fLauncher.LaunchGame;

end;


procedure TMainForm.FormCreate(Sender: TObject);
begin
  fLauncher := TKPLauncher.Create;

  if fLauncher.CheckDuplicateLauncher then
    Application.Terminate;

//  if fLauncher.CheckDuplicateGame then
//    fLauncher.UpdateLauncher;

//  if fLauncher.CheckGameUpdate then
//    fLauncher.UpdateGame;
end;


end.