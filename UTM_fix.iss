; -- UTM_fix.iss --
;
; This script create installer to auto launch rutoken_new.bat
; Created in InnoSetup 5.5.9 (unicode)

[Setup]
AppName=Rutoken UTM fix 
AppVersion=0.6
DefaultDirName={pf}\Rutoken UTM fix
DisableProgramGroupPage=yes
OutputBaseFilename=UTM_fix

[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"


[Files]
Source: "rutoken_new.bat"; DestDir: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Aktiv Co."; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Aktiv Co.\Rutoken UTM fix"; Flags: uninsdeletekey

[Run]
Filename: "{app}\rutoken_new.bat"; Parameters: {code:GetUserPIN}

[Code]
var
  KeyPage: TInputQueryWizardPage;
  ProgressPage: TOutputProgressWizardPage;
  
procedure InitializeWizard;
begin
  
  KeyPage := CreateInputQueryPage(wpWelcome, 'Персональная информация', 'PIN-код от токена', 'Пожалуйста укажите PIN-код токена и нажмите Next чтобы продолжить.');
  KeyPage.Add('PIN-код токена:', False);

  ProgressPage := CreateOutputProgressPage('Персональная информация', 'PIN-код от токена');

  KeyPage.Values[0] := GetPreviousData('PIN', '12345678');

end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
var
  UsageMode: String;
begin
  SetPreviousData(PreviousDataKey, 'PIN', KeyPage.Values[0]);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  I: Integer;
  ResultCode: Integer;
begin
  if CurPageID = KeyPage.ID then begin
    ProgressPage.SetText('Выполняю проверку компьютера...', '');
    ProgressPage.SetProgress(0, 0);
    ProgressPage.Show;
    try
      for I := 0 to 10 do begin
        ProgressPage.SetProgress(I, 10);
        Sleep(100);
      end;
    finally
      ProgressPage.Hide;
    end;
    Result := True;
  end else
    Result := True;
end;

function GetUserPIN(Value: string): string;
begin
  Result := KeyPage.Values[0];
end;

