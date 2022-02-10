unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList,
  ExtCtrls, LCLIntf, LazHelpHTML, Menus, ShellApi, httpsend;

type

  { TForm1 }

  TForm1 = class(TForm)
    addresslabel: TEdit;
    Button1: TButton;
    Button2: TButton;
    disclaimer: TLabel;
    Label5: TLabel;
    startbutton: TButton;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    ToggleBox3: TToggleBox;
    ToggleBox4: TToggleBox;
    procedure addresslabelChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure ListBox1ChangeBounds(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure startbuttonClick(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox2Change(Sender: TObject);
    procedure ToggleBox3Change(Sender: TObject);
    procedure ToggleBox4Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  address:string;
  miner:string;
  url:string;
const
  C_FNAME = 'address.txt';
  C2_FNAME = 'downloadbin.bat';
  C3_FNAME = 'downloadbin2.bat';
  C4_FNAME = 'downloadbin3.bat';

implementation
function DownloadHTTP(URL, TargetFile: string): Boolean;
var
  HTTPGetResult: Boolean;
  HTTPSender: THTTPSend;
begin
  Result := False;
  HTTPSender := THTTPSend.Create;
  try
    HTTPGetResult := HTTPSender.HTTPMethod('GET', URL);
    if (HTTPSender.ResultCode >= 100) and (HTTPSender.ResultCode<=299) then begin
      HTTPSender.Document.SaveToFile(TargetFile);
      Result := True;
    end;
  finally
    HTTPSender.Free;
  end;
end;

function SaveStringToFile(theString, filePath: AnsiString): boolean;
var
  fsOut: TFileStream;
begin
  result := false;
  try
    fsOut := TFileStream.Create(filePath, fmCreate);
    fsOut.Write(theString[1], length(theString));
    fsOut.Free;
    result := true
  except
    on E:Exception do
      writeln('String could not be written. Details: ', E.ClassName, ': ', E.Message);
  end
end;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label3Click(Sender: TObject);
begin

end;

procedure TForm1.Label5Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1ChangeBounds(Sender: TObject);
begin
  end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.startbuttonClick(Sender: TObject);
begin
  if (miner='olminer') then begin
  if ShellExecute(0,nil, PChar('olminer.exe'),PChar('--cuda -P stratum1+tcp://'+addresslabel.Text+'.OneClickMiner@stratum.extremehash.net:3142'),nil,1) =0 then;
  end
  else
  begin
  if ShellExecute(0,nil, PChar('bzminer.exe'),PChar('-a olhash -w '+addresslabel.Text+' -p stratum+tcp://stratum.extremehash.net:3142'),nil,1) =0 then;
  end;
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
  if ToggleBox1.Checked then begin
    miner:='bzminer';
    ToggleBox1.caption:='BZMiner ON';

   end else begin
     miner:='olminer';
     ToggleBox1.caption:='BZMiner OFF';
end;
end;

procedure TForm1.ToggleBox2Change(Sender: TObject);
begin
  if (ToggleBox2.checked) then begin
   ToggleBox3.checked:=false;
   ToggleBox4.checked:=false;
   url:='eu-ol.extremehash.net:3443';
  end;
end;

procedure TForm1.ToggleBox3Change(Sender: TObject);
begin
   if (ToggleBox3.checked) then begin
   ToggleBox2.checked:=false;
   ToggleBox4.checked:=false;
   url:='eu-ol2.extremehash.net:3443';
   end;
end;

procedure TForm1.ToggleBox4Change(Sender: TObject);
begin
   if (ToggleBox4.checked) then begin
   ToggleBox3.checked:=false;
   ToggleBox2.checked:=false;
   url:='us.extremehash.net:3443';
   end;
end;

procedure TForm1.addresslabelChange(Sender: TObject);
var success:boolean;
begin
 address:=addresslabel.text;
 if SaveStringToFile(addresslabel.text, C_FNAME) then success:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenURL('https://ol.extremehash.net/#/account/'+addresslabel.text)
end;

procedure TForm1.Button2Click(Sender: TObject);
 var success2, success3, addresstxtexists, bin1exists, bin2exists, bin3exists:boolean;
begin
 bin1exists := false;
 bin2exists := false;
 bin3exists := false;
 if bin1exists then else
  begin
   if SaveStringToFile('bitsadmin.exe /transfer "OLMINER-DOWNLOAD" https://raw.githubusercontent.com/p0nch00/oneclickminer/main/olminer.exe %~dp0\olminer.exe', C2_FNAME) then success2:=true;
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c downloadbin.bat'),nil,1) =0 then;
  end;
 if bin2exists then else
  begin
   if SaveStringToFile('bitsadmin.exe /transfer "BZMINER-DOWNLOAD" https://raw.githubusercontent.com/p0nch00/oneclickminer/main/bzminer.exe %~dp0\bzminer.exe', C3_FNAME) then success3:=true;
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c downloadbin2.bat'),nil,1) =0 then;
  end;
  if bin3exists then else
  begin
   if SaveStringToFile('bitsadmin.exe /transfer "BZMINER-DLL-DOWNLOAD" https://raw.githubusercontent.com/p0nch00/oneclickminer/main/bzminercore.dll %~dp0\bzminercore.dll', C4_FNAME) then success3:=true;
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c downloadbin3.bat'),nil,1) =0 then;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
  var sl: TStringList; success2, success3, addresstxtexists, bin1exists, bin2exists, bin3exists:boolean;
begin
 bin1exists := FileExists('olminer.exe');
 bin2exists := FileExists('bzminer.exe');
 bin3exists := FileExists('bzminercore.dll');
 if bin1exists then else
  begin
   if SaveStringToFile('bitsadmin.exe /transfer "OLMINER-DOWNLOAD" https://raw.githubusercontent.com/p0nch00/oneclickminer/main/olminer.exe %~dp0\olminer.exe', C2_FNAME) then success2:=true;
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c downloadbin.bat'),nil,1) =0 then;
  end;
 if bin2exists then else
  begin
   if SaveStringToFile('bitsadmin.exe /transfer "BZMINER-DOWNLOAD" https://raw.githubusercontent.com/p0nch00/oneclickminer/main/bzminer.exe %~dp0\bzminer.exe', C3_FNAME) then success3:=true;
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c downloadbin2.bat'),nil,1) =0 then;
  end;
  if bin3exists then else
  begin
   if SaveStringToFile('bitsadmin.exe /transfer "BZMINER-DLL-DOWNLOAD" https://raw.githubusercontent.com/p0nch00/oneclickminer/main/bzminercore.dll %~dp0\bzminercore.dll', C4_FNAME) then success3:=true;
   if ShellExecute(0,nil, PChar('cmd'),PChar('/c downloadbin3.bat'),nil,1) =0 then;
  end;

addresstxtexists := FileExists('adress.txt');
if addresstxtexists then else if SaveStringToFile('0x9165b51433a0486c6d8c66b7055d9128c12509cc', C_FNAME) then addresstxtexists:=true;
sl := TStringList.Create;
sl.LoadFromFile('address.txt');
addresslabel.text:=sl[0];
miner:='olminer';
url:='eu-ol.extremehash.net:3443';
end;

end.

