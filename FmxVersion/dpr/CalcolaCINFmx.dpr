program CalcolaCINFmx;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainFmx in '..\src\uMainFmx.pas' {FormMain},
  uBaseValue in '..\..\common\uBaseValue.pas',
  uCINCalculator in '..\..\common\uCINCalculator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
