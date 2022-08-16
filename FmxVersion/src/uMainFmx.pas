unit uMainFmx;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.Controls.Presentation,
  uBaseValue, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, System.Actions, FMX.ActnList;

type
  TFormMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtABICode: TEdit;
    edtCABCode: TEdit;
    edtContoCode: TEdit;
    edtIBAN: TEdit;
    Label4: TLabel;
    edtCINResult: TEdit;
    Label5: TLabel;
    btnExit: TButton;
    edtNationCode: TEdit;
    Label6: TLabel;
    edtControlCode: TEdit;
    Label7: TLabel;
    edtCINCode: TEdit;
    Label8: TLabel;
    pnlTop: TPanel;
    btnExtract: TButton;
    pnlSource: TPanel;
    pnlCalc: TPanel;
    btnCalculator: TButton;
    LogMemo: TMemo;
    ActionList: TActionList;
    ActionExit: TAction;
    ActionExtract: TAction;
    ActionCalculator: TAction;
    procedure ActionCalculatorExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionExtractExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormMain: TFormMain;

implementation

{$R *.fmx}

procedure TFormMain.ActionCalculatorExecute(Sender: TObject);
begin
  if not Assigned(gDataStructure) then
    Exit;

  gDataStructure.AbiCode := edtABICode.Text.Trim;
  gDataStructure.CabCode := edtCABCode.Text.Trim;
  gDataStructure.ContoCode := edtContoCode.Text.Trim;

  if not gDataStructure.Validator then
  begin
    LogMemo.Lines.Add('Verificare i dati di (ABI, CAB, Conto Corrente) valori necessari per il calcolo');
    raise Exception.Create('Verificare i dati di (ABI, CAB, Conto Corrente) valori necessari per il calcolo');
  end;

  LogMemo.Lines.Add('Validazione completata');
  gDataStructure.CalculateCIN;

  edtCINResult.Text := gDataStructure.CinCodeCalculated;

  if SameText(edtCINCode.Text, edtCINResult.Text) then
    LogMemo.Lines.Add('L''IBAN  inserito non è corretto il CIN corrisponde')
  else
    LogMemo.Lines.Add('L''IBAN  inserito non è corretto');
end;

procedure TFormMain.ActionExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.ActionExtractExecute(Sender: TObject);
begin
  if not Assigned(gDataStructure) then
    Exit;

  gDataStructure.ResetValues;
  gDataStructure.SplittingIBAN(edtIBAN.Text);

  edtNationCode.Text := gDataStructure.NationCode;
  edtControlCode.Text := gDataStructure.ControlCode;
  edtCINCode.Text := gDataStructure.CinCode;
  edtABICode.Text := gDataStructure.AbiCode;
  edtCABCode.Text := gDataStructure.CabCode;
  edtContoCode.Text := gDataStructure.ContoCode;
end;

procedure TFormMain.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  var IBANLength := edtIBAN.Text.Length;
  ActionExtract.Enabled := (edtIBAN.Text.Trim <> '') and (IBANLength = 27);
  ActionCalculator.Enabled := (Trim(edtIBAN.Text) <> '') and (IBANLength = 27);
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(gDataStructure) then
    FreeAndNil(gDataStructure);
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  CreateDataStructure;
end;

end.
