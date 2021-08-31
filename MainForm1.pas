unit MainForm1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, ShellAPI;

type
  TMainForm = class(TForm)
    LaunchButton: TButton;
    BackgroundImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure LaunchButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.LaunchButtonClick(Sender: TObject);
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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  { check update }
end;

end.
