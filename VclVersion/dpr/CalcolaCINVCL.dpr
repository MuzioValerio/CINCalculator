program CalcolaCINVCL;

uses
  Vcl.Forms,
  uMain in '..\src\uMain.pas' {FormMain},
  uBaseValue in '..\..\common\uBaseValue.pas',
  uCINCalculator in '..\..\common\uCINCalculator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
