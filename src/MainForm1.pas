unit MainForm1;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI, UnitLauncher, Vcl.Imaging.pngimage, Vcl.Buttons, System.ImageList, Vcl.ImgList;

type
  TMainForm = class(TForm)
    btnLaunch: TButton;
    imgLogo: TImage;
    btnDiscord: TButton;
    ilLinkButtons50: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure btnLaunchClick(Sender: TObject);
    procedure btnDiscordClick(Sender: TObject);
  private
    fLauncher: TKPLauncher;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  fLauncher := TKPLauncher.Create;

  if not fLauncher.TryLockForLauncher then
  begin
    MessageDlg('Can not start second launcher', mtWarning, [mbOK], 0);
    Application.Terminate;
  end;

//  if fLauncher.CheckGameUpdate then
//    fLauncher.UpdateGame;
end;


procedure TMainForm.btnDiscordClick(Sender: TObject);
begin
  //todo: Go to https://discord.gg/ZGrgC6G
end;

procedure TMainForm.btnLaunchClick(Sender: TObject);
begin
  if fLauncher.CheckDuplicateGame then
  begin
    MessageDlg('Can not start second game', mtWarning, [mbOK], 0);
    Exit;
  end;

  fLauncher.LaunchGame;
  Application.Terminate;
end;


end.
