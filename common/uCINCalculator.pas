unit uCINCalculator;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils;

type
  ICINCalculator = interface(IInterface)
  ['{FD7B8CAD-63FB-47E4-ACCB-3ED057ACDA02}']
    function GetCINCalculated: string;
    procedure SetABICode(const AValue: string);
    procedure SetCABCode(const AValue: string);
    procedure SetContoCode(const AValue: string);

    procedure Execute;
    property ABICode: string write SetABICode;
    property CABCode: string write SetCABCode;
    property ContoCode: string write SetContoCode;
    property CINCalculated: string read GetCINCalculated;
  end;

var
  CINCalculator: ICINCalculator;

procedure SetCINCalculator;

implementation

const
  AlfabeticArray: array[0..25] of string = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');

  Valuesdis: array[0..28] of integer = (1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,12,14,16,10,22,25,24,23,27,28,26);
  Valuespar: array[0..28] of integer = (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28);

type
  TCINCalculator = class(TInterfacedObject, ICINCalculator)
  strict private
    FABICode: string;
    FCABCode: string;
    FContoCode: string;
    FCINCalculated: string;
    FBaseCalcValue: string;

    FNumberValue: Integer;
    FCharValue: string;

    function GetCINCalculated: string;
    procedure SetABICode(const AValue: string);
    procedure SetCABCode(const AValue: string);
    procedure SetContoCode(const AValue: string);
    procedure InternalCINCalc;
    function GetAlfaPosition(const AValue: string): Integer;
    function IsOdd(const AValue: Integer): Boolean;
    function IsNumber(const AValue: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
    property ABICode: string write SetABICode;
    property CABCode: string write SetCABCode;
    property ContoCode: string write SetContoCode;
    property CINCalculated: string read GetCINCalculated;
  end;

procedure SetCINCalculator;
begin
  if CINCalculator = nil then
    CINCalculator := TCINCalculator.Create;
end;

constructor TCINCalculator.Create;
begin
  inherited Create;
end;

destructor TCINCalculator.Destroy;
begin
  inherited Destroy;
end;

procedure TCINCalculator.Execute;
begin
  FCINCalculated := '';
  FBaseCalcValue := FABICode + FCABCode + FContoCode;
  InternalCINCalc;
end;

function TCINCalculator.GetAlfaPosition(const AValue: string): Integer;
begin
  var IsFound: Integer := -1;
  for var I := Low(AlfabeticArray) to High(AlfabeticArray) do
  begin
    if AlfabeticArray[I] = AValue then
    begin
      IsFound := I;
      Break;
    end;
  end;

  Exit(IsFound);
end;

function TCINCalculator.GetCINCalculated: string;
begin
  Result := FCINCalculated;
end;

procedure TCINCalculator.InternalCINCalc;
var
  lSum: Integer;
begin
  lSum := 0;
  for var I := Low(FBaseCalcValue) to High(FBaseCalcValue) do
  begin
    if IsNumber(FBaseCalcValue[I]) then
    begin
      if IsOdd(I-1) then
        lSum := lSum + Valuesdis[FNumberValue]
      else
        lSum := lSum + Valuespar[FNumberValue];
    end
    else
    begin
      var GetPos := GetAlfaPosition(FCharValue);
      if IsOdd(I) then
      begin
        if GetPos > -1 then
          lSum := lSum + Valuesdis[GetPos]
      end
      else
        if GetPos > -1 then
          lSum := lSum + Valuespar[GetPos];
    end;
  end;

  var lReDiv := lSum Mod 26;
  FCINCalculated := AlfabeticArray[lReDiv];
end;

function TCINCalculator.IsNumber(const AValue: string): Boolean;
begin
  if TryStrToInt(AValue, FNumberValue) then
    Exit(True)
  else
  begin
    FCharValue := AValue;
    Exit(False);
  end;
end;

function TCINCalculator.IsOdd(const AValue: Integer): Boolean;
begin
  Result := AValue mod 2 = 0;
end;

procedure TCINCalculator.SetABICode(const AValue: string);
begin
  FABICode := AValue;
end;

procedure TCINCalculator.SetCABCode(const AValue: string);
begin
  FCABCode := AValue;
end;

procedure TCINCalculator.SetContoCode(const AValue: string);
begin
  FContoCode := AValue;
end;

end.
