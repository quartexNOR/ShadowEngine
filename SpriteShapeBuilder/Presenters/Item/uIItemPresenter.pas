unit uIItemPresenter;

interface

uses
  uSSBTypes;

type
  IItemPresenter = interface
    ['{DBA1F2DC-D339-4239-BF4E-CC522C6B86EF}']
    procedure MouseDown;
    procedure ShowOptions;
    procedure MouseUp;
    procedure MouseMove;
  end;

implementation

end.
