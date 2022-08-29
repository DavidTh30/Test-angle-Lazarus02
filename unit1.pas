{%BuildCommand $(CompPath) $EdFile()}
{%RunFlags BUILD-}
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, BGRABitmap, BGRABitmapTypes, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Image1: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Image5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ScrollBar1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Mouse_down_x: Extended;
  Mouse_down_y: Extended;
  Mouse_down_r: Extended;
  Mouse_down_Active: integer;
  Mouse_down_oldx: Extended;
  Mouse_down_oldy: Extended;
  Mouse_down_newx: Extended;
  Mouse_down_newy: Extended;
const
  Po1: array[0..3, 0..1] of Extended =
    (
    (65, -8),
    (-11, -8),
    (-11, 7),
    (65, 7)
    );

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormPaint(Sender: TObject);
var
  bmp: TBGRABitmap;
  x_ : Extended;
  y_ : Extended;
  t : Extended;
  tem2 : Extended;
  tem3 : Extended;
  c: TBGRAPixel;
  Po2: array[0..3, 0..1] of Extended;
  Orgx: integer;
  Orgy: integer;

begin
  //Orgx := Round(Image1.Width/2);
  Orgy := Round(Image1.Height/2);
  Orgx := 122;
  //Orgy := 97;
  t := ((2*pi/10000)*ScrollBar1.Position);
  bmp := TBGRABitmap.Create(Image1.Width,Image1.Height, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.lineWidth:=2;
  bmp.Canvas2D.arc(115+36,100,85,(Pi/2)+(Pi/16),(-Pi/2)-(Pi/16),false);
  bmp.Canvas2D.strokeStyle ('rgb(55,255,55)');
  bmp.Canvas2D.stroke();

  bmp.Canvas2D.lineWidth:=1;

  Po2:=Po1;
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);

  x_ :=((55)*cos(t));
  y_ :=((55)*sin(t));
  x_ := x_+Orgx;
  //y := Image1.Height-(y+Orgy);
  y_:=(-y_)+Orgy;
  bmp.FillEllipseAntialias(x_,y_,23,23,BGRA(192,192,192,255));
  bmp.EllipseAntialias(x_,y_,23,23,BGRA(0,0,0,255),1.4);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,82,14,5);
  bmp.Canvas2D.fillRect(122,67,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,72,23,6);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,111,14,5);
  bmp.Canvas2D.fillRect(122,116,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,120,23,6);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.fillStyle('rgb(255,255,128)');
  bmp.Canvas2D.translate(Orgx,Orgy);
  bmp.Canvas2D.rotate((t+pi)*(-1));

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText

  bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);

  bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.Canvas2D.fillRect(-65,-8,76,15);

  bmp.FillEllipseAntialias(x_,y_,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,3,3,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy,3,3,BGRA(0,0,0,255),1);

  x_ :=((Po2[0,0])*cos(t)) - ((Po2[0,1])*sin(t));
  y_ :=((Po2[0,0])*sin(t)) + ((Po2[0,1])*cos(t));
  x_ := x_+Orgx;
  //y_ := Image1.Height-(y+Orgy);
  y_:=(-y_)+Orgy;
  Po2[0,0] := x_;
  Po2[0,1] := y_;
  x_ :=((Po2[1,0])*cos(t)) - ((Po2[1,1])*sin(t));
  y_ :=((Po2[1,0])*sin(t)) + ((Po2[1,1])*cos(t));
  x_ := x_+Orgx;
  //y_ := Image1.Height-(y+Orgy);
  y_:=(-y_)+Orgy;
  Po2[1,0] := x_;
  Po2[1,1] := y_;
  x_ :=((Po2[2,0])*cos(t)) - ((Po2[2,1])*sin(t));
  y_ :=((Po2[2,0])*sin(t)) + ((Po2[2,1])*cos(t));
  x_ := x_+Orgx;
  //y_ := Image1.Height-(y+Orgy);
  y_:=(-y_)+Orgy;
  Po2[2,0] := x_;
  Po2[2,1] := y_;
  x_ :=((Po2[3,0])*cos(t)) - ((Po2[3,1])*sin(t));
  y_ :=((Po2[3,0])*sin(t)) + ((Po2[3,1])*cos(t));
  x_ := x_+Orgx;
  //y := Image1.Height-(y+Orgy);
  y_:=(-y_)+Orgy;
  Po2[3,0] := x_;
  Po2[3,1] := y_;
  bmp.DrawPolygonAntialias([PointF(Po2[0,0],Po2[0,1]),PointF(Po2[1,0],Po2[1,1]),PointF(Po2[2,0],Po2[2,1]),PointF(Po2[3,0],Po2[3,1])],c,1);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.resetTransform;

  x_ :=((20)*cos(t));
  y_ :=((20)*sin(t));
  x_ := x_+Orgx;
  //y := Image1.Height-(y+Orgy);
  y_:=(-y_)+Orgy;

  bmp.FillEllipseAntialias(x_,y_,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,2,2,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy+62,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy+62,2,2,BGRA(0,0,0,255),1);

  x_ :=((((20)*cos(t))));
  y_ :=((((20)*sin(t))));
  Tem2:=Round(sqrt(sqr(x_)+sqr(y_)));
  Tem2:=(sqrt(sqr(x_)+sqr(y_+62)));
  if (x_=0) or (Tem2=0) then Tem3:=0 else Tem3:= arcsin(x_/Tem2);


  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.translate(Orgx,Orgy+62);
  bmp.Canvas2D.rotate(Tem3);
  bmp.Canvas2D.fillStyle(BGRA(158,158,158,255));
  bmp.Canvas2D.fillRect(-2,38-Tem2,4,-35);

  bmp.Canvas2D.fillStyle('rgb(168,168,168)');
  bmp.Canvas2D.fillRect(-7,-2,14,-5);
  bmp.Canvas2D.fillRect(-5,-6,10,-26);
  bmp.Canvas2D.fillRect(-7,-31,14,-5);

  bmp.Canvas2D.fillStyle('rgb(128,128,128)');
  bmp.Canvas2D.fillRect(-2,-7,4,-26);

  c := ColorToBGRA(ColorToRGB(TColor($37FF37)));
  bmp.DrawPolyLineAntialias([PointF(128,10), PointF(136,16), PointF(128,24)],c,2);
  bmp.DrawPolyLineAntialias([PointF(128,175), PointF(136,183), PointF(127,188)],c,2);

  bmp.Canvas2D.resetTransform;


  bmp.Draw(Image1.Canvas,0,0);
  bmp.Free;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  bmp: TBGRABitmap;
  x_ : Extended;
  y_ : Extended;
  t : Extended;
  tem : Integer;
  tem2 : Extended;
  tem3 : Extended;
  i : Integer;
  i2 : Integer;
  c: TBGRAPixel;
  Po2: array[0..3, 0..1] of Extended;
  X: integer;
  Y: integer;
  Orgx: integer;
  Orgy: integer;

begin

  Orgx := Round(Image5.Width/2);
  Orgy := Round(Image5.Height/2);
  bmp := TBGRABitmap.Create(Image5.Width,Image5.Height, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.strokeStyle ('rgb(155,155,155)');
  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;

  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.fillStyle('rgb(0,0,0)');
  for i := 0 to Image5.Width do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(i,y_,1,1);
  end;
  for i := 0 to Round(Image5.Width/4) do
  begin
    for i2 := Orgy-3 to Orgy+3 do bmp.Canvas2D.fillRect(i*4,i2,1,1);
  end;
  for i := 0 to Image5.Height do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(x_,i,1,1);
  end;
  for i := 0 to Round(Image5.Height/4) do
  begin
    for i2 := Orgx-3 to Orgx+3 do bmp.Canvas2D.fillRect(i2,i*4,1,1);
  end;


  bmp.Draw(Image5.Canvas,0,0);
  bmp.Free;

  X:=90;
  Y:=80;
  Orgx := X;
  Orgy := Y;
  t := ((2*pi/10000)*ScrollBar1.Position);
  bmp := TBGRABitmap.Create(Image6.Width,Image6.Height, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.lineWidth:=2;
  bmp.Canvas2D.arc(115+36,100,85,(Pi/2)+(Pi/16),(-Pi/2)-(Pi/16),false);
  bmp.Canvas2D.strokeStyle ('rgb(55,255,55)');
  bmp.Canvas2D.stroke();

  //bmp.Canvas2D.strokeStyle ('rgb(155,155,155)');
  //bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;

  Po2:=Po1;
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);  //(2*pi/10000)*ScrollBar1.Position;
  //t := ((2*pi/10000)*ScrollBar1.Position);
  //label1.Caption:='b= ' + FloatToStr(t) + ' = ' + FloatToStr(t*180/Pi) + 'degree';
  x_ :=((55)*cos(t));
  y_ :=((55)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText
  bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);
  bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.FillEllipseAntialias(x_,y_,23,23,BGRA(192,192,192,255));
  bmp.EllipseAntialias(x_,y_,23,23,BGRA(0,0,0,255),1.4);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,y-17,14,5);
  bmp.Canvas2D.fillRect(122,y-32,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,y-27,23,6);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,y+12,14,5);
  bmp.Canvas2D.fillRect(122,y+17,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,y+21,23,6);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);  //(2*pi/10000)*ScrollBar1.Position;
  bmp.Canvas2D.fillStyle('rgb(255,255,128)');
  bmp.Canvas2D.translate(Orgx,Orgy);
  bmp.Canvas2D.rotate((t+pi)*(-1));

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText
  //bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);
  //bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.Canvas2D.fillRect(-65,-8,76,15);

  bmp.FillEllipseAntialias(x_,y_,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,3,3,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy,3,3,BGRA(0,0,0,255),1);

  x_ :=((Po2[0,0])*cos(t)) - ((Po2[0,1])*sin(t));
  y_ :=((Po2[0,0])*sin(t)) + ((Po2[0,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[0,0] := x_;
  Po2[0,1] := y_;
  x_ :=((Po2[1,0])*cos(t)) - ((Po2[1,1])*sin(t));
  y_ :=((Po2[1,0])*sin(t)) + ((Po2[1,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[1,0] := x_;
  Po2[1,1] := y_;
  x_ :=((Po2[2,0])*cos(t)) - ((Po2[2,1])*sin(t));
  y_ :=((Po2[2,0])*sin(t)) + ((Po2[2,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[2,0] := x_;
  Po2[2,1] := y_;
  x_ :=((Po2[3,0])*cos(t)) - ((Po2[3,1])*sin(t));
  y_ :=((Po2[3,0])*sin(t)) + ((Po2[3,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[3,0] := x_;
  Po2[3,1] := y_;
  bmp.DrawPolygonAntialias([PointF(Po2[0,0],Po2[0,1]),PointF(Po2[1,0],Po2[1,1]),PointF(Po2[2,0],Po2[2,1]),PointF(Po2[3,0],Po2[3,1])],c,1);


  t := ((2*pi/10000)*ScrollBar1.Position);
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  for i := 0 to Image6.Width do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(i,y_,1,1);
  end;
  for i := 0 to Round(Image6.Width/4) do
  begin
    for i2 := Orgy-3 to Orgy+3 do bmp.Canvas2D.fillRect(i*4,i2,1,1);
  end;
  for i := 0 to Image6.Height do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(x_,i,1,1);
  end;
  for i := 0 to Round(Image6.Height/4) do
  begin
    for i2 := Orgx-3 to Orgx+3 do bmp.Canvas2D.fillRect(i2,i*4,1,1);
  end;

  x_ :=((20)*cos(t));
  y_ :=((20)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  bmp.FillEllipseAntialias(x_,y_,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,2,2,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy+62,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy+62,2,2,BGRA(0,0,0,255),1);

  x_ :=((20)*cos(t));
  if x_ >=0 then begin Tem2:=0; Tem3:=x_; end;
  if x_ <0 then begin Tem2:=x_; Tem3:=0; end;
  bmp.Canvas2D.fillStyle('rgb(0,0,255)');
  for i := Round(Tem2) to Round(Tem3) do
  begin
    Tem := i+Orgx;
    y_ :=((20)*sin(t));
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(Tem,round(y_),1,1);
  end;

  y_ :=((20)*sin(t));
  if y_ >=0 then begin Tem2:=0; Tem3:=y_; end;
  if y_ <0 then begin Tem2:=y_; Tem3:=0; end;
  bmp.Canvas2D.fillStyle('rgb(0,0,255)');
  for i := Round(Tem2) to Round(Tem3) do
  begin
    x_ :=0;
    x_ := x_+Orgx;
    Tem:=(-i)+Orgy;
    bmp.Canvas2D.fillRect(x_,Tem,1,1);
  end;

  ////label1.Caption:='b= ' + FloatToStr(t) + ' = ' + FloatToStr(t*180/Pi) + 'degree';
  x_ :=((((20)*cos(t))));
  y_ :=((((20)*sin(t))));
  //label1.Caption:=label1.Caption + chr(13) + 'x= ' + FloatToStr(Round(x_)) + ' ' + 'y= ' + FloatToStr(Round(y_));
  Tem2:=Round(sqrt(sqr(x_)+sqr(y_)));
  //label1.Caption:= label1.Caption + chr(13) + 'C=Sqrt((A^2)+(B^2))= '+ FloatToStr(Tem2);
  Tem2:=(sqrt(sqr(x_)+sqr(y_+62)));
  //label1.Caption:= label1.Caption + chr(13) + 'C2=Sqrt((A^2)+(B^2))= '+ FloatToStr(Tem2);
  if (x_=0) or (Tem2=0) then Tem3:=0 else Tem3:= arcsin(x_/Tem2);
  //label1.Caption:= label1.Caption + chr(13) + 'c = arcsin(a/b)= '+ FloatToStr(Tem3*180/Pi);


  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.translate(Orgx,Orgy+62);
  bmp.Canvas2D.rotate(Tem3);
  bmp.Canvas2D.fillStyle(BGRA(158,158,158,255));
  bmp.Canvas2D.fillRect(-2,38-Tem2,4,-35);

  bmp.Canvas2D.fillStyle('rgb(168,168,168)');
  bmp.Canvas2D.fillRect(-7,-2,14,-5);
  bmp.Canvas2D.fillRect(-5,-6,10,-26);
  bmp.Canvas2D.fillRect(-7,-31,14,-5);

  bmp.Canvas2D.fillStyle('rgb(128,128,128)');
  bmp.Canvas2D.fillRect(-2,-7,4,-26);

  c := ColorToBGRA(ColorToRGB(TColor($37FF37)));
  bmp.DrawPolyLineAntialias([PointF(128,10), PointF(136,16), PointF(128,24)],c,2);
  bmp.DrawPolyLineAntialias([PointF(128,175), PointF(136,183), PointF(127,188)],c,2);

  bmp.Canvas2D.resetTransform;

  for i := 0 to 20 do begin
    bmp.Canvas2D.fillStyle('rgb(255,0,0)');
    x_ :=((i)*cos(t));
    y_ :=((i)*sin(t));
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  for i := -62 to 0 do begin
    bmp.Canvas2D.fillStyle('rgb(255,0,0)');
    x_ :=0;
    y_ :=i;
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  bmp.Canvas2D.fillStyle('rgb(255,0,0)');
  for i := 0 to Round(Tem2) do
  begin
    x_ :=((i)*cos((Pi/2)-Tem3));
    y_ :=((i)*sin((Pi/2)-Tem3));
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy+62;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;
  bmp.Draw(Image6.Canvas,0,0);
  bmp.Free;

  form1.Refresh;
  ScrollBar1Change(ScrollBar1.GetAccessibleObject);
end;

procedure TForm1.Image5MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  bmp: TBGRABitmap;
  x_ : Extended;
  y_ : Extended;
  i : Integer;
  i2 : Integer;
  Orgx: integer;
  Orgy: integer;

begin

  //Orgx := Round(Image5.Width/2);
  Orgx := 122;
  Orgy := Round(Image5.Height/2);
  //Orgy := 97;
  Orgx := X;
  Orgy := Y;
  bmp := TBGRABitmap.Create(Image5.Width,Image5.Height, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.strokeStyle ('rgb(155,155,155)');
  bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;


  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.fillStyle('rgb(0,0,0)');
  for i := 0 to Image5.Width do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(i,y_,1,1);
  end;
  for i := 0 to Round(Image5.Width/4) do
  begin
    for i2 := Orgy-3 to Orgy+3 do bmp.Canvas2D.fillRect(i*4,i2,1,1);
  end;
  for i := 0 to Image5.Height do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(x_,i,1,1);
  end;
  for i := 0 to Round(Image5.Height/4) do
  begin
    for i2 := Orgx-3 to Orgx+3 do bmp.Canvas2D.fillRect(i2,i*4,1,1);
  end;


  bmp.Draw(Image5.Canvas,0,0);
  bmp.Free;

  form1.Refresh;

end;

procedure TForm1.Image6MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  bmp: TBGRABitmap;
  x_ : Extended;
  y_ : Extended;
  t : Extended;
  tem : Integer;
  tem2 : Extended;
  tem3 : Extended;
  i : Integer;
  i2 : Integer;
  c: TBGRAPixel;
  Po2: array[0..3, 0..1] of Extended;
  Orgx: integer;
  Orgy: integer;

begin

  //Orgx := Round(Image6.Width/2);
  //Orgx := 122;
  //Orgy := Round(Image6.Height/2);
  //Orgy := 97;

  Orgx := X;
  Orgy := Y;
  t := ((2*pi/10000)*ScrollBar1.Position);
  bmp := TBGRABitmap.Create(Image6.Width,Image6.Height, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.lineWidth:=2;
  bmp.Canvas2D.arc(115+36,100,85,(Pi/2)+(Pi/16),(-Pi/2)-(Pi/16),false);
  bmp.Canvas2D.strokeStyle ('rgb(55,255,55)');
  bmp.Canvas2D.stroke();

  //bmp.Canvas2D.strokeStyle ('rgb(155,155,155)');
  //bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;

  Po2:=Po1;
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);  //(2*pi/10000)*ScrollBar1.Position;
  //t := ((2*pi/10000)*ScrollBar1.Position);
  //label1.Caption:='b= ' + FloatToStr(t) + ' = ' + FloatToStr(t*180/Pi) + 'degree';
  x_ :=((55)*cos(t));
  y_ :=((55)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText
  bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);
  bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.FillEllipseAntialias(x_,y_,23,23,BGRA(192,192,192,255));
  bmp.EllipseAntialias(x_,y_,23,23,BGRA(0,0,0,255),1.4);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,y-17,14,5);
  bmp.Canvas2D.fillRect(122,y-32,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,y-27,23,6);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,y+12,14,5);
  bmp.Canvas2D.fillRect(122,y+17,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,y+21,23,6);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);  //(2*pi/10000)*ScrollBar1.Position;
  bmp.Canvas2D.fillStyle('rgb(255,255,128)');
  bmp.Canvas2D.translate(Orgx,Orgy);
  bmp.Canvas2D.rotate((t+pi)*(-1));

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText
  //bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);
  //bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.Canvas2D.fillRect(-65,-8,76,15);

  bmp.FillEllipseAntialias(x_,y_,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,3,3,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy,3,3,BGRA(0,0,0,255),1);

  x_ :=((Po2[0,0])*cos(t)) - ((Po2[0,1])*sin(t));
  y_ :=((Po2[0,0])*sin(t)) + ((Po2[0,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[0,0] := x_;
  Po2[0,1] := y_;
  x_ :=((Po2[1,0])*cos(t)) - ((Po2[1,1])*sin(t));
  y_ :=((Po2[1,0])*sin(t)) + ((Po2[1,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[1,0] := x_;
  Po2[1,1] := y_;
  x_ :=((Po2[2,0])*cos(t)) - ((Po2[2,1])*sin(t));
  y_ :=((Po2[2,0])*sin(t)) + ((Po2[2,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[2,0] := x_;
  Po2[2,1] := y_;
  x_ :=((Po2[3,0])*cos(t)) - ((Po2[3,1])*sin(t));
  y_ :=((Po2[3,0])*sin(t)) + ((Po2[3,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[3,0] := x_;
  Po2[3,1] := y_;
  bmp.DrawPolygonAntialias([PointF(Po2[0,0],Po2[0,1]),PointF(Po2[1,0],Po2[1,1]),PointF(Po2[2,0],Po2[2,1]),PointF(Po2[3,0],Po2[3,1])],c,1);


  t := ((2*pi/10000)*ScrollBar1.Position);
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  for i := 0 to Image6.Width do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(i,y_,1,1);
  end;
  for i := 0 to Round(Image6.Width/4) do
  begin
    for i2 := Orgy-3 to Orgy+3 do bmp.Canvas2D.fillRect(i*4,i2,1,1);
  end;
  for i := 0 to Image6.Height do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(x_,i,1,1);
  end;
  for i := 0 to Round(Image6.Height/4) do
  begin
    for i2 := Orgx-3 to Orgx+3 do bmp.Canvas2D.fillRect(i2,i*4,1,1);
  end;

  x_ :=((20)*cos(t));
  y_ :=((20)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  bmp.FillEllipseAntialias(x_,y_,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,2,2,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy+62,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy+62,2,2,BGRA(0,0,0,255),1);

  x_ :=((20)*cos(t));
  if x_ >=0 then begin Tem2:=0; Tem3:=x_; end;
  if x_ <0 then begin Tem2:=x_; Tem3:=0; end;
  bmp.Canvas2D.fillStyle('rgb(0,0,255)');
  for i := Round(Tem2) to Round(Tem3) do
  begin
    Tem := i+Orgx;
    y_ :=((20)*sin(t));
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(Tem,round(y_),1,1);
  end;

  y_ :=((20)*sin(t));
  if y_ >=0 then begin Tem2:=0; Tem3:=y_; end;
  if y_ <0 then begin Tem2:=y_; Tem3:=0; end;
  bmp.Canvas2D.fillStyle('rgb(0,0,255)');
  for i := Round(Tem2) to Round(Tem3) do
  begin
    x_ :=0;
    x_ := x_+Orgx;
    Tem:=(-i)+Orgy;
    bmp.Canvas2D.fillRect(x_,Tem,1,1);
  end;

  ////label1.Caption:='b= ' + FloatToStr(t) + ' = ' + FloatToStr(t*180/Pi) + 'degree';
  x_ :=((((20)*cos(t))));
  y_ :=((((20)*sin(t))));
  //label1.Caption:=label1.Caption + chr(13) + 'x= ' + FloatToStr(Round(x_)) + ' ' + 'y= ' + FloatToStr(Round(y_));
  Tem2:=Round(sqrt(sqr(x_)+sqr(y_)));
  //label1.Caption:= label1.Caption + chr(13) + 'C=Sqrt((A^2)+(B^2))= '+ FloatToStr(Tem2);
  Tem2:=(sqrt(sqr(x_)+sqr(y_+62)));
  //label1.Caption:= label1.Caption + chr(13) + 'C2=Sqrt((A^2)+(B^2))= '+ FloatToStr(Tem2);
  if (x_=0) or (Tem2=0) then Tem3:=0 else Tem3:= arcsin(x_/Tem2);
  //label1.Caption:= label1.Caption + chr(13) + 'c = arcsin(a/b)= '+ FloatToStr(Tem3*180/Pi);


  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.translate(Orgx,Orgy+62);
  bmp.Canvas2D.rotate(Tem3);
  bmp.Canvas2D.fillStyle(BGRA(158,158,158,255));
  bmp.Canvas2D.fillRect(-2,38-Tem2,4,-35);

  bmp.Canvas2D.fillStyle('rgb(168,168,168)');
  bmp.Canvas2D.fillRect(-7,-2,14,-5);
  bmp.Canvas2D.fillRect(-5,-6,10,-26);
  bmp.Canvas2D.fillRect(-7,-31,14,-5);

  bmp.Canvas2D.fillStyle('rgb(128,128,128)');
  bmp.Canvas2D.fillRect(-2,-7,4,-26);

  c := ColorToBGRA(ColorToRGB(TColor($37FF37)));
  bmp.DrawPolyLineAntialias([PointF(128,10), PointF(136,16), PointF(128,24)],c,2);
  bmp.DrawPolyLineAntialias([PointF(128,175), PointF(136,183), PointF(127,188)],c,2);

  bmp.Canvas2D.resetTransform;

  for i := 0 to 20 do begin
    bmp.Canvas2D.fillStyle('rgb(255,0,0)');
    x_ :=((i)*cos(t));
    y_ :=((i)*sin(t));
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  for i := -62 to 0 do begin
    bmp.Canvas2D.fillStyle('rgb(255,0,0)');
    x_ :=0;
    y_ :=i;
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  bmp.Canvas2D.fillStyle('rgb(255,0,0)');
  for i := 0 to Round(Tem2) do
  begin
    x_ :=((i)*cos((Pi/2)-Tem3));
    y_ :=((i)*sin((Pi/2)-Tem3));
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy+62;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;
  bmp.Draw(Image6.Canvas,0,0);
  bmp.Free;

  form1.Refresh;
end;

procedure TForm1.ScrollBar1Change(Sender: TObject);
var
  bmp: TBGRABitmap;
  x_ : Extended;
  y_ : Extended;
  t : Extended;
  tem : Integer;
  tem2 : Extended;
  tem3 : Extended;
  i : Integer;
  i2 : Integer;
  c: TBGRAPixel;
  Po2: array[0..3, 0..1] of Extended;
  Orgx: integer;
  Orgy: integer;

begin

  //Orgx := Round(Image7.Width/2);
  Orgy := Round(Image7.Height/2);
  Orgx := 122;
  //Orgy := 97;
  t := ((2*pi/10000)*ScrollBar1.Position);
  bmp := TBGRABitmap.Create(Image7.Width,Image7.Height, ColorToBGRA(ColorToRGB(clBtnFace)));

  bmp.Canvas2D.lineWidth:=2;
  bmp.Canvas2D.arc(115+36,100,85,(Pi/2)+(Pi/16),(-Pi/2)-(Pi/16),false);
  bmp.Canvas2D.strokeStyle ('rgb(55,255,55)');
  bmp.Canvas2D.stroke();

  //bmp.Canvas2D.strokeStyle ('rgb(155,155,155)');
  //bmp.Canvas2D.stroke();
  bmp.Canvas2D.lineWidth:=1;

  Po2:=Po1;
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);  //(2*pi/10000)*ScrollBar1.Position;
  //t := ((2*pi/10000)*ScrollBar1.Position);
  label1.Caption:='b= ' + FloatToStr(t) + ' = ' + FloatToStr(t*180/Pi) + 'degree';
  x_ :=((55)*cos(t));
  y_ :=((55)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  bmp.FillEllipseAntialias(x_,y_,23,23,BGRA(192,192,192,255));
  bmp.EllipseAntialias(x_,y_,23,23,BGRA(0,0,0,255),1.4);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,82,14,5);
  bmp.Canvas2D.fillRect(122,67,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,72,23,6);

  bmp.Canvas2D.fillStyle('rgb(120,120,120)');
  bmp.Canvas2D.fillRect(118,111,14,5);
  bmp.Canvas2D.fillRect(122,116,6,15);
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  bmp.Canvas2D.fillRect(118,120,23,6);

  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);  //(2*pi/10000)*ScrollBar1.Position;
  bmp.Canvas2D.fillStyle('rgb(255,255,128)');
  bmp.Canvas2D.translate(Orgx,Orgy);
  bmp.Canvas2D.rotate((t+pi)*(-1));

  c := ColorToBGRA(ColorToRGB(TColor($000000)));   //clBlack      //clWindowText

  bmp.DrawPolyLineAntialias([PointF(0,80), PointF(x_-13,y_+19)],c,1.3);

  bmp.DrawPolyLineAntialias([PointF(x_+23,y_+1), PointF(120,0)],c,1.3);

  bmp.Canvas2D.fillRect(-65,-8,76,15);

  bmp.FillEllipseAntialias(x_,y_,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,3,3,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy,3,3,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy,3,3,BGRA(0,0,0,255),1);

  x_ :=((Po2[0,0])*cos(t)) - ((Po2[0,1])*sin(t));
  y_ :=((Po2[0,0])*sin(t)) + ((Po2[0,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[0,0] := x_;
  Po2[0,1] := y_;
  x_ :=((Po2[1,0])*cos(t)) - ((Po2[1,1])*sin(t));
  y_ :=((Po2[1,0])*sin(t)) + ((Po2[1,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[1,0] := x_;
  Po2[1,1] := y_;
  x_ :=((Po2[2,0])*cos(t)) - ((Po2[2,1])*sin(t));
  y_ :=((Po2[2,0])*sin(t)) + ((Po2[2,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[2,0] := x_;
  Po2[2,1] := y_;
  x_ :=((Po2[3,0])*cos(t)) - ((Po2[3,1])*sin(t));
  y_ :=((Po2[3,0])*sin(t)) + ((Po2[3,1])*cos(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;
  Po2[3,0] := x_;
  Po2[3,1] := y_;
  bmp.DrawPolygonAntialias([PointF(Po2[0,0],Po2[0,1]),PointF(Po2[1,0],Po2[1,1]),PointF(Po2[2,0],Po2[2,1]),PointF(Po2[3,0],Po2[3,1])],c,1);


  t := ((2*pi/10000)*ScrollBar1.Position);
  t := (((pi)/4/10000)*ScrollBar1.Position)+((pi/8)*7);
  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.fillStyle('rgb(200,200,200)');
  for i := 0 to Image7.Width do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(i,y_,1,1);
  end;
  for i := 0 to Round(Image7.Width/4) do
  begin
    for i2 := Orgy-3 to Orgy+3 do bmp.Canvas2D.fillRect(i*4,i2,1,1);
  end;
  for i := 0 to Image7.Height do
  begin
    x_:= Orgx;
    y_:= Orgy;
    bmp.Canvas2D.fillRect(x_,i,1,1);
  end;
  for i := 0 to Round(Image7.Height/4) do
  begin
    for i2 := Orgx-3 to Orgx+3 do bmp.Canvas2D.fillRect(i2,i*4,1,1);
  end;

  x_ :=((20)*cos(t));
  y_ :=((20)*sin(t));
  x_ := x_+Orgx;
  y_:=(-y_)+Orgy;

  bmp.FillEllipseAntialias(x_,y_,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(x_,y_,2,2,BGRA(0,0,0,255),1);

  bmp.FillEllipseAntialias(Orgx,Orgy+62,2,2,BGRA(128,128,128,255));
  bmp.EllipseAntialias(Orgx,Orgy+62,2,2,BGRA(0,0,0,255),1);

  x_ :=((20)*cos(t));
  if x_ >=0 then begin Tem2:=0; Tem3:=x_; end;
  if x_ <0 then begin Tem2:=x_; Tem3:=0; end;
  bmp.Canvas2D.fillStyle('rgb(0,0,255)');
  for i := Round(Tem2) to Round(Tem3) do
  begin
    Tem := i+Orgx;
    y_ :=((20)*sin(t));
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(Tem,round(y_),1,1);
  end;

  y_ :=((20)*sin(t));
  if y_ >=0 then begin Tem2:=0; Tem3:=y_; end;
  if y_ <0 then begin Tem2:=y_; Tem3:=0; end;
  bmp.Canvas2D.fillStyle('rgb(0,0,255)');
  for i := Round(Tem2) to Round(Tem3) do
  begin
    x_ :=0;
    x_ := x_+Orgx;
    Tem:=(-i)+Orgy;
    bmp.Canvas2D.fillRect(x_,Tem,1,1);
  end;

  //label1.Caption:='b= ' + FloatToStr(t) + ' = ' + FloatToStr(t*180/Pi) + 'degree';
  x_ :=((((20)*cos(t))));
  y_ :=((((20)*sin(t))));
  label1.Caption:=label1.Caption + chr(13) + 'x= ' + FloatToStr(Round(x_)) + ' ' + 'y= ' + FloatToStr(Round(y_));
  Tem2:=Round(sqrt(sqr(x_)+sqr(y_)));
  label1.Caption:= label1.Caption + chr(13) + 'C=Sqrt((A^2)+(B^2))= '+ FloatToStr(Tem2);
  Tem2:=(sqrt(sqr(x_)+sqr(y_+62)));
  label1.Caption:= label1.Caption + chr(13) + 'C2=Sqrt((A^2)+(B^2))= '+ FloatToStr(Tem2);
  if (x_=0) or (Tem2=0) then Tem3:=0 else Tem3:= arcsin(x_/Tem2);
  label1.Caption:= label1.Caption + chr(13) + 'c = arcsin(a/b)= '+ FloatToStr(Tem3*180/Pi);


  bmp.Canvas2D.resetTransform;
  bmp.Canvas2D.translate(Orgx,Orgy+62);
  bmp.Canvas2D.rotate(Tem3);
  bmp.Canvas2D.fillStyle(BGRA(158,158,158,255));
  bmp.Canvas2D.fillRect(-2,38-Tem2,4,-35);

  bmp.Canvas2D.fillStyle('rgb(168,168,168)');
  bmp.Canvas2D.fillRect(-7,-2,14,-5);
  bmp.Canvas2D.fillRect(-5,-6,10,-26);
  bmp.Canvas2D.fillRect(-7,-31,14,-5);

  bmp.Canvas2D.fillStyle('rgb(128,128,128)');
  bmp.Canvas2D.fillRect(-2,-7,4,-26);

  c := ColorToBGRA(ColorToRGB(TColor($37FF37)));
  bmp.DrawPolyLineAntialias([PointF(128,10), PointF(136,16), PointF(128,24)],c,2);
  bmp.DrawPolyLineAntialias([PointF(128,175), PointF(136,183), PointF(127,188)],c,2);

  bmp.Canvas2D.resetTransform;

  for i := 0 to 20 do begin
    bmp.Canvas2D.fillStyle('rgb(255,0,0)');
    x_ :=((i)*cos(t));
    y_ :=((i)*sin(t));
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  for i := -62 to 0 do begin
    bmp.Canvas2D.fillStyle('rgb(255,0,0)');
    x_ :=0;
    y_ :=i;
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  bmp.Canvas2D.fillStyle('rgb(255,0,0)');
  for i := 0 to Round(Tem2) do
  begin
    x_ :=((i)*cos((Pi/2)-Tem3));
    y_ :=((i)*sin((Pi/2)-Tem3));
    x_ := x_+Orgx;
    y_:=(-y_)+Orgy+62;
    bmp.Canvas2D.fillRect(x_,y_,1,1);
  end;

  bmp.Draw(Image7.Canvas,0,0);
  bmp.Free;

  form1.Refresh;
end;

end.

