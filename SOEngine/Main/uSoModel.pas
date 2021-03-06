unit uSoModel;

interface

uses
  System.SyncObjs, System.Classes, System.UITypes,
  uClasses, uSoContainerKeeper, uSoRenderer, uSoCollider, uSoFormattor,
  uSoAnimator, uSoKeyProcessor, uSoMouseProcessor, uSoLogicKeeper;

type
  TSoModel = class
  private
    FCritical: TCriticalSection;

    FContainerKeeper: TSoContainerKeeper;
    FLogicKeper: TSoLogicKeeper;
    FRenderer: TSoRenderer;
    FCollider: TSoCollider;
    FFormattor: TSoFormattor;
    FAnimator: TSoAnimator;
    FKeyProcessor: TSoKeyProcessor;
    FMouseProcessor: TSoMouseProcessor;
  public
    procedure ExecuteOnTick;
    procedure ExecuteKeyUp(Key: Word; KeyChar: Char; Shift: TShiftState); // Process key on tick
    procedure ExecuteKeyDown(Key: Word; KeyChar: Char; Shift: TShiftState); // Process key on tick
    procedure ExecuteMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ExecuteMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure ExecuteMouseMove(X, Y: Single);
    constructor Create(const ACritical: TCriticalSection; const AIsHor: TBooleanFunction);
    destructor Destroy; override;
  end;

implementation

{ TSoModel }

constructor TSoModel.Create(const ACritical: TCriticalSection;
  const AIsHor: TBooleanFunction);
begin
  FCritical := ACritical;
  FContainerKeeper := TSoContainerKeeper.Create(FCritical);
  FLogicKeper := TSoLogicKeeper.Create(FCritical);
  FRenderer := TSoRenderer.Create(FCritical);
  FCollider := TSoCollider.Create(FCritical);
  FFormattor := TSoFormattor.Create(FCritical);
  FAnimator := TSoAnimator.Create(FCritical);
  FKeyProcessor := TSoKeyProcessor.Create(FCritical);
  FMouseProcessor := TSoMouseProcessor.Create(FCritical, FCollider);
end;

destructor TSoModel.Destroy;
begin
    FContainerKeeper.Free;
    FLogicKeper.Free;
    FRenderer.Free;
    FCollider.Free;
    FFormattor.Free;
    FAnimator.Free;
    FKeyProcessor.Free;
    FMouseProcessor.Free;
  inherited;
end;

procedure TSoModel.ExecuteKeyDown(Key: Word; KeyChar: Char; Shift: TShiftState);
begin
  FKeyProcessor.ExecuteKeyDown(Key, KeyChar, Shift);
end;

procedure TSoModel.ExecuteKeyUp(Key: Word; KeyChar: Char; Shift: TShiftState);
begin
  FKeyProcessor.ExecuteKeyUp(Key, KeyChar, Shift);
end;

procedure TSoModel.ExecuteMouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  FMouseProcessor.ExecuteMouseDown(Button, Shift, X, Y);
end;

procedure TSoModel.ExecuteMouseMove(X, Y: Single);
begin
  FMouseProcessor.ExecuteMouseMove(X, Y);
end;

procedure TSoModel.ExecuteMouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Single);
begin
  FMouseProcessor.ExecuteMouseUp(Button, Shift, X, Y);
end;

procedure TSoModel.ExecuteOnTick;
begin
  FAnimator.Execute;
  FLogicKeper.Execute;
  FCollider.Execute;
  FRenderer.Execute;
end;

end.
