; -- EGAIS.iss --
;
; This script create installer to auto launch rutoken_new.bat

[Setup]
AppName=Rutoken UTM fix 
AppVersion=0.2
DefaultDirName={pf}\Rutoken UTM fix
DisableProgramGroupPage=yes

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl, RutokenEn.isl"
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl, RutokenRu.isl"

[Files]
Source: "rutoken_new.bat"; DestDir: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Aktiv Co."; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Aktiv Co.\Rutoken UTM fix"; Flags: uninsdeletekey

[Run]
Filename: {code:GetRunAppPath};  Parameters: {code:GetUserPIN}

[Code]
var
  KeyPage: TInputQueryWizardPage;
  TypePage: TInputOptionWizardPage;
  ProgressPage: TOutputProgressWizardPage;
  
procedure InitializeWizard;
begin
  KeyPage := CreateInputQueryPage(wpWelcome, CustomMessage('PersonalInfoKey'), 'PIN-код от токена', 'Пожалуйста, укажите PIN-код токена и нажмите Next чтобы продолжить.');
  KeyPage.Add('PIN-код токена:', False);

  TypePage := CreateInputOptionPage(KeyPage.ID, 'Настройки установки', 'Режим настройки', 'Пожалуйста, выберите режим, который будет использоваться для настройки:', True, False);
  TypePage.Add(CustomMessage('GuiConfigKey'));
  TypePage.Add(CustomMessage('AutoConfigKey'));
  TypePage.Values[0] := True;

  ProgressPage := CreateOutputProgressPage(CustomMessage('PersonalInfoKey'), 'PIN-код от токена');

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
    if KeyPage.Values[0] = '' then begin
      MsgBox('Значение PIN-кода не может быть пустым. Задайте корректное значение', mbInformation, MB_OK);
      Result := False;
      exit
    end;
  end;
  
  if CurPageID = TypePage.ID then begin
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
    exit
  end;
  
  Result := True;
end;

function GetUserPIN(Value: String): String;
begin
  Result := KeyPage.Values[0];
end;

function GetRunAppPath(Value: String): String;
begin
  if TypePage.Values[0] = True then begin
    Result := 'C:\UTM\installer\bin\transport-installer-gui.bat';
  end else
    Result := ExpandConstant('{app}\rutoken_new.bat');
end;

function GUIconfig(): Boolean;
begin
  Result := TypePage.Values[0];
end;

function InitializeSetup(): Boolean;
begin
  if not FileExists('C:\UTM\installer\bin\transport-installer-gui.bat') then begin
    MsgBox('Корректная установка УТМ не обнаружена. Установка будет прервана.', mbCriticalError, MB_OK);
    Result := False;
    exit
  end;
  if FileExists(ExpandConstant('{win}\System32\rtPKCS11ECP.dll')) or
     FileExists(ExpandConstant('{win}\SysWOW64\rtPKCS11ECP.dll')) then begin
    Result := True;
    exit
  end else begin
    MsgBox('Корректная установка Драйверов Рутокен не обнаружена. Установите Драйвера Рутокен перед запуском этой установки. Установка будет прервана.', mbCriticalError, MB_OK);
    Result := False;
    exit
  end;

  Result := True;
end;

