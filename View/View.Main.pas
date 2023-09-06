unit View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Controller.Crypto;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  FilePath, Key: string;
  Crypto: TCryptoController;
  FileExtensions: TArray<string>;
begin
  Crypto := TCryptoController.Create;
  FilePath := 'C:\Temp\Crypto\';
  Key := 'D4Rfz@!Xan4XxPoopCrypt04AFSIS';

  SetLength(FileExtensions, 3);
  FileExtensions[0] := '.txt';
  FileExtensions[1] := '.pdf';
  FileExtensions[2] := '.sql';

  if Crypto.EncryptFilesInDirectory(FilePath, Key, FileExtensions) then
    ShowMessage('Arquivos criptografados com sucesso')
  else
    ShowMessage('Erro ao criptografar os arquivos');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  FilePath, Key: string;
  Crypto: TCryptoController;
  FileExtensions: TArray<string>;
begin
  Crypto := TCryptoController.Create;
  FilePath := 'C:\Temp\Crypto\';
  Key := 'D4Rfz@!Xan4XxPoopCrypt04AFSIS';

  SetLength(FileExtensions, 3);
  FileExtensions[0] := '.txt';
  FileExtensions[1] := '.pdf';
  FileExtensions[2] := '.sql';

  if Crypto.DecryptFilesInDirectory(FilePath, Key, FileExtensions) then
    ShowMessage('Arquivos descriptografados com sucesso')
  else
    ShowMessage('Erro ao descriptografar os arquivos');
end;


end.
