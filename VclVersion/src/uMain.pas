unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  uBaseValue;

type
  TFormMain = class(TForm)
    pnlTop: TPanel;
    btnExit: TButton;
    pnlSource: TPanel;
    pnlCalc: TPanel;
    Label1: TLabel;
    edtIBAN: TEdit;
    btnExtrac: TButton;
    edtNationCode: TEdit;
    Label2: TLabel;
    edtControlCode: TEdit;
    Label3: TLabel;
    edtCINCode: TEdit;
    Label4: TLabel;
    edtABICode: TEdit;
    Label5: TLabel;
    edtCABCode: TEdit;
    Label6: TLabel;
    edtContoCode: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtCINResult: TEdit;
    btnCalc: TButton;
    MemoLog: TMemo;
    ActionList: TActionList;
    ActionExit: TAction;
    ActionCalculator: TAction;
    ActionExtractor: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ActionCalculatorExecute(Sender: TObject);
    procedure ActionExitExecute(Sender: TObject);
    procedure ActionExtractorExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  CreateDataStructure;
end;

procedure TFormMain.ActionCalculatorExecute(Sender: TObject);
begin
  if not Assigned(gDataStructure) then
    Exit;

  gDataStructure.AbiCode := Trim(edtABICode.Text);
  gDataStructure.CabCode := Trim(edtCABCode.Text);
  gDataStructure.ContoCode := Trim(edtContoCode.Text);

  if not gDataStructure.Validator then
  begin
    MemoLog.Lines.Add('Verificare i dati di (ABI, CAB, Conto Corrente) valori necessari per il calcolo');
    raise Exception.Create('Verificare i dati di (ABI, CAB, Conto Corrente) valori necessari per il calcolo');
  end;

  MemoLog.Lines.Add('Validazione completata');

  gDataStructure.CalculateCIN;

  edtCINResult.Text := gDataStructure.CinCodeCalculated;

  if SameText(edtCINCode.Text, edtCINResult.Text) then
    MemoLog.Lines.Add('L''IBAN  inserito non è corretto il CIN corrisponde')
  else
    MemoLog.Lines.Add('L''IBAN  inserito non è corretto');
end;

procedure TFormMain.ActionExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.ActionExtractorExecute(Sender: TObject);
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
 var IBANLength := Length(edtIBAN.Text);
 ActionExtractor.Enabled := (Trim(edtIBAN.Text) <> '') and (IBANLength = 27);
 ActionCalculator.Enabled := (Trim(edtIBAN.Text) <> '') and (IBANLength = 27);
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(gDataStructure) then
    FreeAndNil(gDataStructure);
end;

end.
