unit GameLogic;

uses w3system, GameEntities, w3components, W3Graphics;

type
   TGameMode = (gmUninitialized, gmMenu, gmPlaying, gmInterlude);

const
   cBonusDivider = 5;

type
   TGameLogic = class
      FScale : Float;
      FOffsetX, FWidth, FHeight : Integer;
      FMissileBoomRadius : Float;
      FAsteroidBoomRadius : Float;
      FBaseRadius : Integer;
      FAsteroidRadius : Integer;

      FMode : TGameMode;
      FLevel : Integer;
      FFramesToInterludeEnd : Integer;
      FModeAfterInterlude : TGameMode;
      FInterludeText : String;

      FFrame : Integer;
      FMissiles : array of TMissile;
      FBooms : array of TBoom;
      FAsteroids : array of TAsteroid;
      FBases : array of TBase;
      FDestroyedBases : Integer;
      FMaxAsteroids : Integer;
      FScore : Integer;
      FScoreBonus : Integer;
      FAsteroidCount : Integer;
      FNextLevel : Integer;

      FImgAsteroid : THandle;
      FImgBoom : THandle;

      FOnGameOver : TNotifyEvent;

      constructor Create(imgAsteroid, imgBoom : THandle);
      begin
         FImgAsteroid:=imgAsteroid;
         FImgBoom:=imgBoom;
         FBases.SetLength(3);
      end;

      procedure Clear;
      begin
         FMissiles.SetLength(0);
         FBooms.SetLength(0);
         FAsteroids.SetLength(0);

         FBases[0]:=new TBase(FOffsetX+FWidth*0.2, FHeight*0.9);
         FBases[1]:=new TBase(FOffsetX+FWidth*0.5, FHeight*0.9);
         FBases[2]:=new TBase(FOffsetX+FWidth*0.8, FHeight*0.9);
         FDestroyedBases:=0;

         FMaxAsteroids:=6;
         FScore:=0;
         FAsteroidCount:=0;
         FNextLevel:=0;
         FMode:=gmMenu;
      end;

      procedure GameResize(w, h : Integer);
      begin
         FScale := h/960;
         FWidth := Round(Min(w, 640*FScale));
         FHeight := Round(h);
         FOffsetX := Round(w-FWidth) div 2;

         FMissileBoomRadius := 100*FScale;
         FBaseRadius := Round(10*FScale);
         FAsteroidRadius := Round(25*FScale*(64/52));  // 52/64 is sprite ratio
         FAsteroidBoomRadius := FAsteroidRadius*2;
      end;

      procedure Interlude(txt : String; next : TGameMode; delay : Integer = 60);
      begin
         FMode:=gmInterlude;
         FFramesToInterludeEnd:=delay;
         FInterludeText:=txt;
         FModeAfterInterlude:=next;
      end;

      procedure NextGameLevel;
      begin
         Inc(FLevel);
         Inc(FMaxAsteroids);
         FNextLevel += FMaxAsteroids*(5+FLevel);
         FAsteroidBoomRadius := FAsteroidRadius*2*Power(1.05, FLevel);
         Interlude('Level '+IntToStr(FLevel), gmPlaying);
      end;

      procedure GameStart;
      begin
         Clear;

         FLevel:=0;
         NextGameLevel;
      end;

      procedure Detonate(boom : TBoom);
      begin
         var i : Integer;
         var r2 := Sqr(boom.Radius);
         for i:=FMissiles.High downto 0 do begin
            var missile := FMissiles[i];
            if missile.Dist2(boom)<=r2 then begin
               FBooms.Add(new TBoom(missile, FMissileBoomRadius));
               missile.Base.ReadyToFire:=not missile.Base.Destroyed;
               FMissiles.Delete(i);
            end;
         end;
         r2 := Sqr(boom.Radius+FAsteroidRadius);
         for i:=FAsteroids.High downto 0 do begin
            var asteroid := FAsteroids[i];
            if asteroid.Dist2(boom)<=Sqr(boom.Radius+FAsteroidRadius*asteroid.Size) then begin
               var timeScale := Min(asteroid.FrameTime/30, 1);
               FBooms.Add(new TBoom(asteroid, asteroid.Size*(1+timeScale*(FAsteroidBoomRadius-1))));
               FAsteroids.Delete(i);
               Inc(FScore, 5+5*FLevel+(FScoreBonus div cBonusDivider));
               Inc(FScoreBonus);
            end;
         end;
         r2 := Sqr(boom.Radius+FBaseRadius);
         for i:=FBases.High downto 0 do begin
            var base := FBases[i];
            if base.Destroyed then continue;
            if base.Dist2(boom)<=r2 then begin
               if FMode<>gmMenu then
                  FBooms.Add(new TBoom(base, FMissileBoomRadius));
               base.Destroyed:=True;
               base.ReadyToFire:=False;
               Inc(FDestroyedBases);
            end;
         end;
      end;

      procedure PaintAsteroid(canvas : TW3Canvas; asteroid : TAsteroid);
      begin
         var idx := asteroid.Frame and 15;
         var r := Round(asteroid.Size*FAsteroidRadius);

         canvas.DrawImageF(FImgAsteroid,
                              (idx and 3)*64, (idx shr 2)*64, 64, 64,
                              Round(asteroid.X)-r,
                              Round(asteroid.Y)-r,
                              2*r, 2*r);
      end;

      procedure PaintBoom(canvas : TW3Canvas; boom : TBoom);
      begin
         var r := Round(boom.Radius);

         canvas.DrawImageF(FImgBoom,
                             Round(boom.X)-r, Round(boom.Y)-r, 2*r, 2*r);
      end;

      procedure Progress;
      begin
         var i : Integer;

         Inc(FFrame);

         // asteroids
         for i:=FAsteroids.High downto 0 do begin
            if FAsteroids[i].Progress then begin
               if FMode<>gmMenu then
                  FBooms.Add(new TBoom(FAsteroids[i], FAsteroids[i].Size*FAsteroidBoomRadius));
               FAsteroids.Delete(i);
               FScoreBonus:=0;
            end;
         end;
         if (FMode<>gmInterlude) and (FAsteroids.Length<FMaxAsteroids) then begin
            if Power(Random, 15)>FAsteroids.Length/FMaxAsteroids then begin
               var newAst : TAsteroid;
               if FMode = gmMenu then
                  newAst := new TAsteroid(FWidth, FHeight*1.1, 2*FScale)
               else newAst := new TAsteroid(FWidth, FHeight*0.9, (2+FLevel*0.2)*FScale);
               newAst.X += FOffsetX;
               FAsteroids.Add(newAst);
               Inc(FAsteroidCount);
            end;
         end;

         // missiles
         for i:=FMissiles.High downto 0 do begin
            var missile := FMissiles[i];
            if missile.Progress then begin
               FBooms.Add(new TBoom(missile, FMissileBoomRadius));
               missile.Base.ReadyToFire:=not missile.Base.Destroyed;
               FMissiles.Delete(i);
            end;
         end;

         // booms
         for i:=FBooms.High downto 0 do begin
            Detonate(FBooms[i]);
            if FBooms[i].Progress then
               FBooms.Delete(i);
         end;

         case FMode of

            gmPlaying : begin

               if FDestroyedBases=FBases.Length then begin
                  Interlude('Game Over', gmMenu, 90);
                  FMaxAsteroids:=6; // prevent them from overwcrowding menu
               end;
               if FAsteroidCount>FNextLevel then
                  NextGameLevel;

            end;

            gmInterlude : begin

               Dec(FFramesToInterludeEnd);
               if FFramesToInterludeEnd<=0 then begin
                  FMode:=FModeAfterInterlude;
                  if FMode=gmMenu then
                     FOnGameOver(Self);
               end;

            end;

         end;
      end;

      procedure PaintView(canvas : TW3Canvas);
      Begin
         // bases
         if FMode in [gmPlaying, gmInterlude] then begin
            canvas.strokestyle:='black';
            var base : TBase;
            for base in FBases do begin
               var bx := Round(base.X);
               var by := Round(base.Y);
               if base.Destroyed then
                  canvas.fillstyle:='#202020'
               else canvas.fillstyle:='#5050FF';
               canvas.beginPath;
               canvas.MoveToF(bx-FBaseRadius, by+FBaseRadius);
               canvas.LineToF(bx-FBaseRadius, by);
               canvas.LineToF(bx, by-FBaseRadius);
               canvas.LineToF(bx+FBaseRadius, by);
               canvas.LineToF(bx+FBaseRadius, by+FBaseRadius);
               canvas.closePath;
               canvas.fill;
               canvas.stroke;
               if base.ReadyToFire and not base.Destroyed then begin
                  canvas.fillstyle:='#E8E8FF';
                  canvas.beginPath;
                  canvas.arcF(bx, by+FScale, 5*FScale, 0, 2*PI, False);
                  canvas.closePath;
                  canvas.fill;
               end;
            end;
         end;

         // asteroids
         var asteroid : TAsteroid;
         for asteroid in FAsteroids do
            PaintAsteroid(canvas, asteroid);

         // missiles
         canvas.fillstyle:='#E8E8FF';
         var missile : TMissile;
         for missile in FMissiles do begin
            canvas.beginPath;
            canvas.arcF(missile.X, missile.y, 5*FScale, 0, 2*PI, False);
            canvas.closePath;
            canvas.fill;
         end;

         // booms
         var boom : TBoom;
         for boom in FBooms do
            PaintBoom(canvas, boom);

         canvas.font:='10pt verdana';
         canvas.FillStyle:='rgb(255,255,255)';
         if FMode<>gmMenu then begin
            canvas.FillTextF( 'Score:'+IntToStr(FScore)
                             +'   Bonus:'+IntToStr(FScoreBonus div cBonusDivider)
                             +'   Level:'+IntToStr(FLevel),
                             FOffsetX+100, 20, FWidth)
         end else if FScore>0 then begin
            canvas.FillTextF('Last Score:'+IntToStr(FScore),
                             FOffsetX+100, 20, FWidth);
         end;

         if FMode=gmInterlude then begin

            canvas.font:='24pt verdana';
            canvas.textAlign:='center';
            canvas.FillStyle:=Format('rgba(255,255,255,%.02f)', [Clamp(FFramesToInterludeEnd/30, 0, 1)]);
            canvas.FillTextF(FInterludeText, FOffsetX+FWidth*0.5, FHeight*0.5, FWidth);
            canvas.textAlign:='left';

         end;
      end;

      procedure FireMissile(x, y: Float);
      begin
         if FMode not in [gmPlaying, gmInterlude] then Exit;
         if FMissiles.Length>=FBases.Length then Exit;

         var bestIndex := 0;
         var bestDistance := 1e10;
         var base, bestBase : TBase;
         for base in FBases do begin
            if base.ReadyToFire then begin
               var dist := Sqr(base.X-x)+Sqr(base.Y-y);
               if dist<bestDistance then begin
                  bestBase:=base;
                  bestDistance:=dist;
               end;
            end;
         end;

         var missile := new TMissile(bestBase, x, y, 10*FScale);
         FMissiles.Add(missile);
      end;

   end;
