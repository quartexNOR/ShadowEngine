unit uE2DSprite;

interface

uses
  FMX.Objects, System.Types,
  uE2DRendition, uE2DResourceList, uSoContainer, uEngine2DClasses;

type

  TEngine2DSprite = class(TEngine2DRendition)
  private
    FCurRes: Integer;
    FResourceList: TEngine2DResourceList;
    procedure SetCurRes(const Value: Integer);
  protected
    function GetHeight: Single; override;
    function GetWidth: Single; override;
  public
    property CurRes: Integer read FCurRes write SetCurRes;
    procedure Repaint; override;
    constructor Create(const ASubject: TSoContainer; const AImage: TImage; const AResourceList: TEngine2DResourceList);
    destructor Destroy; override;
  end;

implementation

{ TEngine2DSPrite }

constructor TEngine2DSprite.Create(const ASubject: TSoContainer; const AImage: TImage;
  const AResourceList: TEngine2DResourceList);
begin
  inherited Create(ASubject, AImage);
  FResourceList := AResourceList;
end;

destructor TEngine2DSprite.Destroy;
begin
  FResourceList := nil;
  inherited;
end;

function TEngine2DSprite.GetHeight: Single;
begin
  Result := FResourceList[FCurRes].Height;
end;

function TEngine2DSprite.GetWidth: Single;
begin
  Result := FResourceList[FCurRes].Width;
end;

procedure TEngine2DSprite.Repaint;
begin
  FImage.Bitmap.Canvas.DrawBitmap(
    FResourceList[FCurRes].Picture,
    FResourceList[FCurRes].Rect,
    RectF(
      FSubject.X + FResourceList[FCurRes].WHalf * FSubject.ScaleX * CJustifyPoints[Justify].Left,
      FSubject.Y + FResourceList[FCurRes].HHalf * FSubject.ScaleY * CJustifyPoints[Justify].Top,
      FSubject.X + FResourceList[FCurRes].WHalf * FSubject.ScaleX * CJustifyPoints[Justify].Right,
      FSubject.Y + FResourceList[FCurRes].HHalf * FSubject.ScaleY * CJustifyPoints[Justify].Bottom),
    1,
    True);
end;

procedure TEngine2DSprite.SetCurRes(const Value: Integer);
begin
  FCurRes := Value;
end;

end.
