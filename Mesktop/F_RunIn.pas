unit F_RunIn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFRM_RunIn = class(TForm)
    LBL_Desktop: TLabel;
    LBL_Program: TLabel;
    CB_Desktops: TComboBox;
    ED_FilePath: TEdit;
    OD_File: TOpenDialog;
    BTN_Browse: TButton;
    BTN_Run: TButton;
    BTN_Cancel: TButton;
    procedure BTN_CancelClick(Sender: TObject);
    procedure BTN_BrowseClick(Sender: TObject);
    procedure BTN_RunClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_RunIn: TFRM_RunIn;

implementation

{$R *.dfm}

procedure TFRM_RunIn.BTN_BrowseClick(Sender: TObject);
begin
  // Show open dialog to select file
  if OD_File.Execute then
    ED_FilePath.Text:= OD_File.FileName;
end;

procedure TFRM_RunIn.BTN_CancelClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFRM_RunIn.BTN_RunClick(Sender: TObject);
var
  SI: TStartupInfo;
  PI: TProcessInformation;
begin
  // Run selected application on selected desktop
  FillChar(SI, SizeOf(SI), 0);
  SI.cb:= SizeOf(TStartupInfo);
  SI.dwFlags:= 0;
  SI.wShowWindow:= SW_SHOWNORMAL;
  case CB_Desktops.ItemIndex of
    0: SI.lpDesktop:= 'default';
    1: SI.lpDesktop:= 'Desktop1';
    2: SI.lpDesktop:= 'Desktop2';
  end;
  if CreateProcess(PChar(ED_FilePath.Text), '', nil, nil, False, 0, nil, nil, SI, PI)= True then
  begin
    MessageDlg('The application was runned on '+ SI.lpDesktop, mtInformation, [mbOK], 0);
    Self.Close;
  end
    else
      MessageDlg('Can not run application on ' + SI.lpDesktop, mtError, [mbOK], 0);
end;

procedure TFRM_RunIn.FormShow(Sender: TObject);
begin
  ED_FilePath.Clear;
end;

end.
