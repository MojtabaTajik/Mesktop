unit F_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, ImgList, Menus;

type
  TFRM_Main = class(TForm)
    Tray: TTrayIcon;
    Images: TImageList;
    BTN_DefaultDesktop: TButton;
    BTN_Desktop1: TButton;
    BTN_Desktop2: TButton;
    BTN_RunIn: TButton;
    BTN_About: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayDblClick(Sender: TObject);
    procedure BTN_DefaultDesktopClick(Sender: TObject);
    procedure BTN_Desktop1Click(Sender: TObject);
    procedure BTN_Desktop2Click(Sender: TObject);
    procedure BTN_RunInClick(Sender: TObject);
    procedure BTN_AboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  DESKTOP_ALL_ACCESS = DESKTOP_CREATEMENU or DESKTOP_CREATEWINDOW or
    DESKTOP_ENUMERATE or DESKTOP_HOOKCONTROL or DESKTOP_JOURNALPLAYBACK or
    DESKTOP_JOURNALRECORD or DESKTOP_READOBJECTS or DESKTOP_SWITCHDESKTOP or
    DESKTOP_WRITEOBJECTS or DF_ALLOWOTHERACCOUNTHOOk;

var
  FRM_Main: TFRM_Main;
  Desktop1, Desktop2: THandle;

implementation

uses F_RunIn;

{$R *.dfm}

// Get desktop handle & switch to it
Procedure SwitchToDesktop(const DesktopName: String);
var
  InputDesktop: THandle;
begin
  InputDesktop := OpenDesktop(PChar(DesktopName), 0, FALSE,
    DESKTOP_CREATEMENU or DESKTOP_CREATEWINDOW or DESKTOP_ENUMERATE or
    DESKTOP_HOOKCONTROL or DESKTOP_WRITEOBJECTS or DESKTOP_READOBJECTS or
    DESKTOP_SWITCHDESKTOP or GENERIC_WRITE);
  SwitchDesktop(InputDesktop);
  SetThreadDesktop(InputDesktop);
end;

procedure TFRM_Main.BTN_AboutClick(Sender: TObject);
var
  Str: String;
begin
  Str := 'Mesktop' + #13 + #13 + 'Written by Felony';
  MessageBox(Self.Handle, PChar(Str), 'About', +MB_OK + MB_ICONINFORMATION);
end;

procedure TFRM_Main.BTN_RunInClick(Sender: TObject);
begin
  FRM_RunIn.ShowModal;
end;

procedure TFRM_Main.BTN_DefaultDesktopClick(Sender: TObject);
begin
  // Switch to "default" desktop
  SwitchToDesktop('default');
end;

procedure TFRM_Main.BTN_Desktop1Click(Sender: TObject);
begin
  // Switch to "Desktop1" desktop
  SwitchToDesktop('Desktop1');
end;

procedure TFRM_Main.BTN_Desktop2Click(Sender: TObject);
begin
  // Switch to "Desktop2" desktop
  SwitchToDesktop('Desktop2');
end;

procedure TFRM_Main.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // Hide to system tray
  CanClose := FALSE;
  Self.Hide;
end;

procedure TFRM_Main.FormCreate(Sender: TObject);
var
  WorkArea: TRect;
  SI: TStartupInfo;
  PI: TProcessInformation;
  WindDir: Array [0 .. 256] of Char;
begin
  // Get the current work area & set form position
  SystemParametersInfo(SPI_GETWORKAREA, 0, &WorkArea, 0);
  Self.Top := WorkArea.Bottom - Self.Height;
  Self.Left := WorkArea.Right - Self.Width;

  // Check is Desktop1 , if yes set caption to "Desktop 1" & disable BTN_Desktop1
  if GetCommandLine = 'Desktop 1' then
  begin
    Self.Caption := 'Mesktop - Desktop 1';
    BTN_Desktop1.Enabled := FALSE;
    Exit;
  end;

  // Check is Desktop2 , if yes set caption to "Desktop 2" & disable BTN_Desktop2
  if GetCommandLine = 'Desktop 2' then
  begin
    Self.Caption := 'Mesktop - Desktop 2';
    BTN_Desktop2.Enabled := FALSE;
    Exit;
  end;

  // Check is Desktop2 , disable BTN_Desktop2
  BTN_DefaultDesktop.Enabled := FALSE;

  // Get Windows directory
  GetWindowsDirectory(WindDir, SizeOf(WindDir));

  // Create 2 desktops
  Desktop1 := CreateDesktop('Desktop1', nil, nil, 0, DESKTOP_ALL_ACCESS, nil);
  Desktop2 := CreateDesktop('Desktop2', nil, nil, 0, DESKTOP_ALL_ACCESS, nil);

  // Set TStartupInfo data
  FillChar(SI, SizeOf(SI), 0);
  SI.cb := SizeOf(TStartupInfo);
  SI.dwFlags := 0;
  SI.wShowWindow := SW_SHOWNORMAL;

  // Run "explorer.exe" on "Dektop1" & "Mesktop" on "Dektop1"
  SI.lpDesktop := 'Desktop1';
  if GetCommandLine <> 'Desktop 1' then
  begin
    CreateProcess(PChar(WindDir + '\explorer.exe'), nil, nil, nil, FALSE, 0,
      nil, nil, SI, PI);
    CreateProcess(PChar(Application.ExeName), 'Desktop 1', nil, nil, FALSE, 0,
      nil, nil, SI, PI);
  end;

  // Run "explorer.exe" on "Dektop1" & "Mesktop" on "Dektop1"
  SI.lpDesktop := 'Desktop2';
  if GetCommandLine <> 'Desktop 2' then
  begin
    CreateProcess(PChar(WindDir + '\explorer.exe'), nil, nil, nil, FALSE, 0,
      nil, nil, SI, PI);
    CreateProcess(PChar(Application.ExeName), 'Desktop 2', nil, nil, FALSE, 0,
      nil, nil, SI, PI);
  end;
end;

procedure TFRM_Main.TrayDblClick(Sender: TObject);
begin
  // Restore from system try
  Self.Show;
end;

end.
