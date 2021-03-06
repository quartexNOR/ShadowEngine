unit uSoMouseProcessor;

interface

uses
  System.SyncObjs, System.Classes, System.UITypes, System.SysUtils, System.Generics.Collections,
  uSoBaseOperator, uSoMouseHandler, uSoCollider, uSoContainer;

type
  TSoMouseHandlerFriend = class(TSoMouseHandler);

  TSoMouseProcessor = class(TSoOperator<TSoMouseHandlerFriend>)
  private
    FCollider: TSoCollider;
    FContainers: TDictionary<TSoContainer, TSoMouseHandlerFriend>;
    FMouseOver, FOldMouseOver, FMouseDowned, FMouseUpped: TArray<TSoContainer>;
    procedure OnItemDestroy(ASender: TObject);
  public
    procedure ExecuteMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); // Process mouse on tick
    procedure ExecuteMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); // Process mouse on tick
    procedure ExecuteMouseMove(X, Y: Single); // Process mouse position on tick
    procedure Add(const AItem: TSoMouseHandlerFriend; const AName: string = ''); override;
    constructor Create(const ACritical: TCriticalSection; const ACollider: TSoCollider);
    destructor Destroy; override;
  end;

implementation

{ TSoMouseProcessor }

procedure TSoMouseProcessor.Add(const AItem: TSoMouseHandlerFriend;
  const AName: string);
var
  vName: string;
begin
  {$I .\Template\uItemAdd.inc}
  FContainers.Add(AItem.Subject, AItem);
end;

constructor TSoMouseProcessor.Create(const ACritical: TCriticalSection; const ACollider: TSoCollider);
begin
  inherited Create(ACritical);
  FContainers := TDictionary<TSoContainer, TSoMouseHandlerFriend>.Create;
  FCollider := ACollider;
end;

destructor TSoMouseProcessor.Destroy;
begin
  FContainers.Clear;
  FContainers.Free;
  inherited;
end;

procedure TSoMouseProcessor.ExecuteMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  i: Integer;
begin
  for i := 0 to Length(FMouseOver) - 1 do
    FContainers[FMouseOver[i]].MouseDown(Button, Shift, X, Y);
  FMouseDowned := FMouseOver;
end;

procedure TSoMouseProcessor.ExecuteMouseMove(X, Y: Single);
var
  i, j: Integer;
  vWas: Boolean;
begin
  FMouseOver := FCollider.Contains(X, Y);

  for i := 0 to Length(FMouseOver) - 1 do
  begin
    vWas := False;
    for j := i + 1 to Length(FOldMouseOver) - 1 do
    begin
      if FMouseOver[i] = FOldMouseOver[j] then
      begin
        vWas := True;
        FOldMouseOver[j] := nil;
        Break;
      end;
    end;
    if vWas then
      FContainers[FMouseOver[i]].MouseLeave;
  end;

  for j := 0 to Length(FOldMouseOver) - 1 do
    if FOldMouseOver[j] <> nil then
      FContainers[FOldMouseOver[i]].MouseEnter;

  FOldMouseOver := FMouseOver;
end;

procedure TSoMouseProcessor.ExecuteMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);

var
  i: Integer;
begin
  for i := 0 to Length(FMouseOver) - 1 do
    FContainers[FMouseOver[i]].MouseDown(Button, Shift, X, Y);
  FMouseUpped := FMouseOver;
end;

procedure TSoMouseProcessor.OnItemDestroy(ASender: TObject);
begin
  FList.Delete(TSoMouseHandlerFriend(ASender));
  FContainers.Remove(TSoMouseHandlerFriend(ASender).Subject);
end;

end.
