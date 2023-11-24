unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TItem = record
    first, last, data: Single;
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
  param = 0.8;

procedure TForm2.aboutSort(ls: TList<TItem>);
begin
  list.Sort(TComparer<TItem>.Construct(
    function(const a, b: TItem): integer
    begin
      if b.last > a.last then
        result := 1
      else if b.last < a.last then
        result := -1
      else
        result := 0;
    end));
  Invalidate;
  getlist;
end;

procedure TForm2.Action1Execute(Sender: TObject);
var
  item: TItem;
begin
  Randomize;
  for var i := 0 to list.Count - 1 do
  begin
    item.first := RandG(50.0, 10.0);
    item.last := item.first;
    list[i] := item;
  end;
  hensaData(list);
  aboutSort(list);
end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
  event(3);
  aboutSort(list);
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
  j := Trunc(item.last);
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
var
  item: TItem;
begin
  list := TList<TItem>.Create;
  for var i := 1 to 1000 do
    list.Add(item);
  Canvas.Pen.Width := 1;
  Action1Execute(Sender);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
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
    if old = Trunc(i.last) then
      inc(cnt)
    else
    begin
      Canvas.MoveTo(old + 50, 350);
      Canvas.LineTo(old + 50, 350 - cnt);
      cnt := 0;
      old := Trunc(i.last);
    end;
  drawScreen;
end;

procedure TForm2.happiness(var item: TItem);
var
  x: Single;
begin
  x := item.data / 50;
  item.last := item.last * param * x;
  if item.last > 1000 then
    item.last := 1000;
end;

procedure TForm2.hensaData(ls: TList<TItem>);
var
  data: TArray<Single>;
  mean, std: Single;
  item: TItem;
begin
  getarray(ls, data);
  Math.MeanAndStdDev(data, mean, std);
  Finalize(data);
  for var i := 0 to ls.Count - 1 do
  begin
    item := ls[i];
    item.data := 10 * (item.first - mean) / std + 50;
    ls[i] := item;
  end;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
  drawScreen;
  Invalidate;
  ListBox2.ItemIndex := ListBox1.ItemIndex;
end;

procedure TForm2.getarray(ls: TList<TItem>; out data: TArray<Single>);
begin
  SetLength(data, ls.Count);
  for var i := 0 to ls.Count - 1 do
    data[i] := ls[i].last;
end;

procedure TForm2.getlist;
begin
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  for var i in list do
  begin
    ListBox1.Items.Add(i.last.ToString);
    ListBox2.Items.Add(i.data.ToString);
  end;
end;

procedure TForm2.sadness(var item: TItem);
begin
  item.last := item.last / 2;
end;

end.
