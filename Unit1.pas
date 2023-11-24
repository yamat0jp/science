unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls,
  System.Actions, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ExtCtrls;

type
  TBall = class
  private
    FX, FY: integer;
    FVec: TPoint;
  public
    procedure Execute;
    property X: integer read FX write FX;
    property Y: integer read FY write FY;
    property Vec: TPoint read FVec write FVec;
  end;

  TForm1 = class(TForm)
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    ActionToolBar1: TActionToolBar;
    Timer1: TTimer;
    procedure Action1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private éŒ¾ }
    count: integer;
    procedure resetPos(ls: TList);
    procedure resetVecs(ls: TList);
    function mainSort(a, b: integer): integer;
    function isHit(ls: TList; id: integer): Boolean; overload;
    function isHit(a, b: Pointer): Boolean; overload;
  public
    { Public éŒ¾ }
    list: TList;
  end;

const
  MAX = 100;
  size = 5;
  Vec = 10;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses System.Types, System.UITypes;

procedure TForm1.Action1Execute(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TForm1.Action2Execute(Sender: TObject);
begin
  Timer1.Enabled := false;
end;

procedure TForm1.Action3Execute(Sender: TObject);
var
  ball: TBall;
begin
  Timer1.Enabled := false;
  Randomize;
  for ball in list do
  begin
    ball.X := Random(ClientWidth);
    ball.Y := Random(ClientHeight);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  list := TList.Create;
  for var i := 1 to MAX do
    list.Add(TBall.Create);
  resetPos(list);
  resetVecs(list);
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  ball: TBall;
begin
  for ball in list do
    ball.Free;
  list.Free;
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  ball: TBall;
  rec: TRect;
  color: TColor;
begin
  Canvas.FillRect(ClientRect);
  for ball in list do
  begin
    rec := rect(ball.X, ball.Y, ball.X + size, ball.Y + size);
    Canvas.Ellipse(rec);
    if ball = list[0] then
    begin
      color := Canvas.Brush.color;
      Canvas.Brush.color := clGreen;
      Canvas.FillRect(rec);
      Canvas.Brush.color := color;
    end;
  end;
end;

function TForm1.isHit(a, b: Pointer): Boolean;
var
  m, n: integer;
begin
  m := TBall(a).X;
  n := TBall(b).X;
  if (m + size >= n) and (m <= n + size) then
  begin
    m := TBall(a).Y;
    n := TBall(b).Y;
    result := (m + size >= n) and (m <= n + size);
  end
  else
    result := false;
end;

function TForm1.isHit(ls: TList; id: integer): Boolean;
var
  ball: TBall;
  Vec: TPoint;
begin
  ball := ls[id];
  Vec := ball.Vec;
  result := false;
  if ball.X < 0 then
  begin
    ball.X := -ball.X;
    Vec.X := -Vec.X;
    result := true;
  end;
  if ball.X + size > ClientWidth then
  begin
    ball.X := 2 * ClientWidth - size - ball.X;
    Vec.X := -Vec.X;
    result := true;
  end;
  if ball.Y < 0 then
  begin
    ball.Y := -ball.Y;
    Vec.Y := -Vec.Y;
    result := true;
  end;
  if ball.Y + size > ClientHeight then
  begin
    ball.Y := 2 * ClientHeight - size - ball.Y;
    Vec.Y := -Vec.Y;
    result := true;
  end;
  if result then
    ball.Vec := Vec;
  if (id < ls.count - 1) and isHit(ls[id], ls[id + 1]) then
  begin
    ball := ls[id];
    Vec := ball.Vec;
    ball.Vec := TBall(ls[id + 1]).Vec;
    TBall(ls[id + 1]).Vec := Vec;
    result := true;
  end;
end;

function TForm1.mainSort(a, b: integer): integer;
begin
  if a > b then
    result := 1
  else if a < b then
    result := -1
  else
    result := 0;
end;

procedure TForm1.resetPos(ls: TList);
var
  ball: TBall;
  a, b: integer;
begin
  Randomize;
  for ball in ls do
  begin
    a := Random(ClientWidth - size);
    b := Random(ClientHeight - size);
    ball.X := a;
    ball.Y := b;
  end;
end;

procedure TForm1.resetVecs(ls: TList);
var
  ball: TBall;
  a: integer;
begin
  Randomize;
  for ball in ls do
  begin
    a := Random(Vec);
    ball.Vec := Point(a - a div 2, Vec div 2 - a);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  ball: TBall;
begin
  for ball in list do
    ball.Execute;
  list.SortList(
    function(Item1, Item2: Pointer): integer
    begin
      result := mainSort(TBall(Item1).X, TBall(Item2).X);
    end);
  list.SortList(
    function(Item1, Item2: Pointer): integer
    begin
      result := mainSort(TBall(Item1).Y, TBall(Item2).Y);
    end);
  for var i := 0 to list.count - 1 do
    isHit(list, i);
  if count = 0 then
  begin
    count := 0;
    Invalidate;
  end
  else
    dec(count);
end;

{ TBall }

procedure TBall.Execute;
begin
  inc(FX, FVec.X);
  inc(FY, FVec.Y);
end;

end.
