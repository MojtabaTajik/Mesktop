program Mesktop;

uses
  Forms,
  F_Main in 'F_Main.pas' {FRM_Main},
  F_RunIn in 'F_RunIn.pas' {FRM_RunIn};

{$R *.res}

var
  Mutex : THandle;

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Mesktop';
  Application.CreateForm(TFRM_Main, FRM_Main);
  Application.CreateForm(TFRM_RunIn, FRM_RunIn);
  Application.Run;
end.
