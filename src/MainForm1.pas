unit MainForm1;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI, UnitLauncher;

type
  TMainForm = class(TForm)
    LaunchButton: TButton;
    BackgroundImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure LaunchButtonClick(Sender: TObject);
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

procedure TMainForm.LaunchButtonClick(Sender: TObject);
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