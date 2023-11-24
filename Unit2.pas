unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TItem = class
  private
    FMoney, FData: Single;
  public
    property Money : Single read FMoney write FMoney;
    property Data: Single read FData write FData;
  end;

  TForm2 = class(TForm)
    ActionManager1: TActionManager;
    Action1: TAction;
    ActionToolBar1: TActionToolBar;
    Action2: TAction;
    ListBox1: TListBox;
    Action3: TAction;
    ListBox2: TListBox;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
    list: TList<TItem>;
    procedure happiness(var item: TItem);
    procedure sadness(var item: TItem);
    procedure event(cnt: integer);
    procedure getlist;
    procedure getarray(ls: TList<TItem>; out data: TArray<Single>);
    procedure hensaData(ls: TList<TItem>);
    procedure aboutSort(ls: TList<TItem>);
    procedure drawScreen;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses System.Generics.Defaults, Math;

const
  param = 2.0;

procedure TForm2.aboutSort(ls: TList<TItem>);
begin
  list.Sort(TComparer<TItem>.Construct(
    function(const a, b: TItem): integer
    begin
      if b.Money > a.Money then
        result := 1
      else if b.Money < a.Money then
        result := -1
      else
        result := 0;
    end));
  Invalidate;
end;

procedure TForm2.Action1Execute(Sender: TObject);
begin
  Randomize;
  for var item in list do
    item.Money := RandG(50.0, 10.0);
  hensaData(list);
  aboutsort(list);
  for var item in list do
    item.Money := 50.0;
  getlist;
end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
  repeat
    event(3);
    aboutSort(list);
  until list[0].Money = 1000;
  getlist;
end;

procedure TForm2.Action3Execute(Sender: TObject);
begin
  Panel1.Visible := Action3.Checked;
end;

procedure TForm2.drawScreen;
var
  i, j: integer;
  item: TItem;
begin
  Canvas.Pen.Color := clRed;
  Canvas.MoveTo(50, 350);
  Canvas.LineTo(50, 350 + 5);
  Canvas.MoveTo(500 + 50, 350);
  Canvas.LineTo(500 + 50, 350 + 5);
  Canvas.MoveTo(1000 + 50, 350);
  Canvas.LineTo(1000 + 50, 350 + 5);
  Canvas.Pen.Color := clBlack;
  i := ListBox1.ItemIndex;
  if i = -1 then
    Exit;
  item := list[i];
  j := Trunc(item.Money);
  Canvas.TextOut(j + 50, 355, (i + 1).ToString + 'à ');
  Canvas.Pen.Color := clAqua;
  Canvas.MoveTo(j + 50, 350);
  Canvas.LineTo(j + 50, 350 + 5)
end;

procedure TForm2.event(cnt: integer);
var
  item: TItem;
  num: integer;
begin
  Randomize;
  for var i := 1 to cnt do
    for var j := 0 to list.Count - 1 do
    begin
      item := list[j];
      num := Random(100);
      if num > 70 then
        happiness(item)
      else if num > 40 then
        sadness(item);
      list[j] := item;
    end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  list := TList<TItem>.Create;
  for var i := 1 to 10000 do
    list.Add(TItem.Create);
  Canvas.Pen.Width := 1;
  Action1Execute(Sender);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  for var item in list do
    item.Free;
  list.Free;
end;

procedure TForm2.FormPaint(Sender: TObject);
var
  old: integer;
  cnt: integer;
begin
  Canvas.FillRect(ClientRect);
  Canvas.Pen.Color := clBlack;
  old := 0;
  cnt := 0;
  for var i in list do
    if old = Trunc(i.Money) then
      inc(cnt)
    else
    begin
      Canvas.MoveTo(old + 50, 350);
      Canvas.LineTo(old + 50, 350 - cnt);
      cnt := 0;
      old := Trunc(i.Money);
    end;
  drawScreen;
end;

procedure TForm2.happiness(var item: TItem);
var
  x: Single;
begin
  x := item.data / 50;
  item.Money := item.Money * param * x;
  if item.Money > 1000 then
    item.Money := 1000;
end;

procedure TForm2.hensaData(ls: TList<TItem>);
var
  data: TArray<Single>;
  mean, std: Single;
begin
  getarray(ls, data);
  Math.MeanAndStdDev(data, mean, std);
  Finalize(data);
  for var item in ls do
    item.data := 10 * (item.Money - mean) / std + 50;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
  drawScreen;
  Invalidate;
  ListBox2.ItemIndex := ListBox1.ItemIndex;
end;

procedure TForm2.ListBox2Click(Sender: TObject);
begin
  drawScreen;
  Invalidate;
  ListBox1.ItemIndex:=ListBox2.ItemIndex;
end;

procedure TForm2.getarray(ls: TList<TItem>; out data: TArray<Single>);
begin
  SetLength(data, ls.Count);
  for var i := 0 to ls.Count - 1 do
    data[i] := ls[i].Money;
end;

procedure TForm2.getlist;
begin
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  for var i in list do
  begin
    ListBox1.Items.Add(i.Money.ToString);
    ListBox2.Items.Add(i.data.ToString);
  end;
end;

procedure TForm2.sadness(var item: TItem);
begin
  item.Money := item.Money / param;
end;

end.
