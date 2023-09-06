program CryptoDelphi;

uses
  Vcl.Forms,
  View.Main in '..\View\View.Main.pas' {Form1},
  Controller.Crypto in '..\Controller\Controller.Crypto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
