unit uItemBasePresenter;

interface

uses
  System.Classes, System.Types, System.Generics.Collections, uClasses, uITableView,
  uIItemPresenter, uIItemPresenterEvent, uMVPFrameWork, uIItemView, uSSBModels;

type
  TItemBasePresenter = class(TPresenter, IItemPresenter, IPresenterEvent)
  protected
    FView: IItemView;
    FTableView: ITableView;
    FOnMouseDown, FOnMouseUp, FOnMouseMove, FOnOptionsShow: TNotifyEvent;
    procedure SetOnMouseDown(AHandler: TNotifyEvent); virtual;
    function GetOnMouseDown: TNotifyEvent; virtual;
    procedure SetOnMouseUp(AHandler: TNotifyEvent); virtual;
    function GetOnMouseUp: TNotifyEvent; virtual;
    procedure SetOnMouseMove(AHandler: TNotifyEvent); virtual;
    function GetOnMouseMove: TNotifyEvent; virtual;
    function GetOnOptionsShow: TNotifyEvent; virtual;
    procedure SetOnOptionsShow(AHandler: TNotifyEvent); virtual;
    function GetRect: TRectF; virtual; abstract;
    procedure SetRect(const Value: TRectF); virtual; abstract;
    procedure OnOptionsSave(ASender: TObject; AE: TDictionary<string,string>); virtual;
    procedure SetParams(const AValue: TDictionary<string, string>); virtual; abstract;
    property TableView: ITableView  write FTableView;
  public
    property OnMouseDown: TNotifyEvent read GetOnMouseDown write SetOnMouseDown;
    property OnMouseUp: TNotifyEvent read GetOnMouseUp write SetOnMouseUp;
    property OnMouseMove: TNotifyEvent read GetOnMouseMove write SetOnMouseMove;
    property OnOptionsShow: TNotifyEvent read GetOnOptionsShow write SetOnOptionsShow;
    property Rect: TRectF read GetRect write SetRect;
    procedure MouseDown; virtual; abstract;
    procedure MouseUp; virtual; abstract;
    procedure MouseMove; virtual; abstract;
    procedure ShowOptions; virtual; abstract;
    procedure Disable;
    procedure Enable;
    constructor Create(const AItemView: IItemView); reintroduce; virtual;
  end;

implementation

{ TBaseItemPresenter }

constructor TItemBasePresenter.Create(const AItemView: IItemView);
begin
  FView := AItemView;
end;

procedure TItemBasePresenter.Disable;
begin
  FView.Enabled := False;
end;

procedure TItemBasePresenter.Enable;
begin
  FView.Enabled := True;
end;

function TItemBasePresenter.GetOnMouseDown: TNotifyEvent;
begin
  Result := FOnMouseDown;
end;

function TItemBasePresenter.GetOnMouseMove: TNotifyEvent;
begin
  Result := FOnMouseMove;
end;

function TItemBasePresenter.GetOnMouseUp: TNotifyEvent;
begin
  Result := FOnMouseUp;
end;

{function TItemBasePresenter.GetOnOptionsSave: TNotifyEvent;
begin
  Result := FOnOptionsSave;
end;   }

function TItemBasePresenter.GetOnOptionsShow: TNotifyEvent;
begin
  Result := FOnOptionsShow;
end;

procedure TItemBasePresenter.OnOptionsSave(ASender: TObject; AE: TDictionary<string, string>);
begin
  SetParams(AE);
end;

procedure TItemBasePresenter.SetOnMouseDown(AHandler: TNotifyEvent);
begin
  FOnMouseDown := AHandler;
end;

procedure TItemBasePresenter.SetOnMouseMove(AHandler: TNotifyEvent);
begin
  FOnMouseMove := AHandler;
end;

procedure TItemBasePresenter.SetOnMouseUp(AHandler: TNotifyEvent);
begin
  FOnMouseUp := AHandler;
end;

{procedure TItemBasePresenter.SetOnOptionsSave(AHandler: TNotifyEvent);
begin
  FOnOptionsSave := AHandler;
end;   }

procedure TItemBasePresenter.SetOnOptionsShow(AHandler: TNotifyEvent);
begin
  FOnOptionsShow := AHandler;
end;

end.
