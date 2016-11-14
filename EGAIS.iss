; -- CodeDlg.iss --
;
; This script shows how to insert custom wizard pages into Setup and how to handle
; these pages. Furthermore it shows how to 'communicate' between the [Code] section
; and the regular Inno Setup sections using {code:...} constants. Finally it shows
; how to customize the settings text on the 'Ready To Install' page.

[Setup]
AppName=Rutoken UTM fix 
AppVersion=1.5
DefaultDirName={pf}\Rutoken UTM fix
DisableProgramGroupPage=yes

[Files]
Source: "rutoken_new.bat"; DestDir: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Aktiv Co."; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Aktiv Co.\Rutoken UTM fix"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Aktiv Co.\Rutoken UTM fix\Settings"; ValueType: string; ValueName: "Name"; ValueData: "{code:GetUser|Name}"
; etc.

[Run]
Filename: "{app}\rutoken_new.bat"; Parameters: {code:GetParams}

[Code]
var
  UserPage: TInputQueryWizardPage;
  KeyPage: TInputQueryWizardPage;
  ProgressPage: TOutputProgressWizardPage;
  
procedure InitializeWizard;
begin
  { Create the pages }
  
  UserPage := CreateInputQueryPage(wpWelcome,
    'Персональная информация', 'Пожалуйста представьтесь',
    'Пожалуйста укажите ваше имя и имя компаниии, в которой вы работаете и нажмите Next для продолжения.');
  UserPage.Add('Имя:', False);
  UserPage.Add('Компания:', False);

  KeyPage := CreateInputQueryPage(UserPage.ID,
    'Персональная информация', 'PIN-код от токена',
    'Пожалуйста укажите PIN-код токена и нажмите Next чтобы продолжить.');
  KeyPage.Add('PIN-код токена:', False);

  ProgressPage := CreateOutputProgressPage('Персональная информация',
    'PIN-код от токена');

  { Set default values, using settings that were stored last time if possible }

  UserPage.Values[0] := GetPreviousData('Name', ExpandConstant('{sysuserinfoname}'));
  UserPage.Values[1] := GetPreviousData('Company', ExpandConstant('{sysuserinfoorg}'));
  KeyPage.Values[0] := GetPreviousData('PIN', '12345678');

end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
var
  UsageMode: String;
begin
  { Store the settings so we can restore them next time }
  SetPreviousData(PreviousDataKey, 'Name', UserPage.Values[0]);
  SetPreviousData(PreviousDataKey, 'Company', UserPage.Values[1]);
  SetPreviousData(PreviousDataKey, 'PIN', KeyPage.Values[0]);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
var
  I: Integer;
  ResultCode: Integer;
begin
  { Validate certain pages before allowing the user to proceed }
  if CurPageID = UserPage.ID then begin
    if UserPage.Values[0] = '' then begin
      MsgBox('Вы должны задать имя.', mbError, MB_OK);
      Result := False;
    end else begin
      Result := True;
    end;
  end else if CurPageID = KeyPage.ID then begin
    { Just to show how 'OutputProgress' pages work.
      Always use a try..finally between the Show and Hide calls as shown below. }
    ProgressPage.SetText('Выполняю fix...', '');
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

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo,
  MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  S: String;
begin
  { Fill the 'Ready Memo' with the normal settings and the custom settings }
  S := '';
  S := S + 'Персональная информация:' + NewLine;
  S := S + Space + UserPage.Values[0] + NewLine;
  if UserPage.Values[1] <> '' then
    S := S + Space + UserPage.Values[1] + NewLine;
  S := S + NewLine;
  
  S := S + MemoDirInfo + NewLine;

  Result := S;
end;

function GetUser(Param: String): String;
begin
  { Return a user value }
  { Could also be split into separate GetUserName and GetUserCompany functions }
  if Param = 'Имя' then
    Result := UserPage.Values[0]
  else if Param = 'Компания' then
    Result := UserPage.Values[1];
end;

function GetParams(Value: string): string;
begin
  Result := KeyPage.Values[0];
end;

