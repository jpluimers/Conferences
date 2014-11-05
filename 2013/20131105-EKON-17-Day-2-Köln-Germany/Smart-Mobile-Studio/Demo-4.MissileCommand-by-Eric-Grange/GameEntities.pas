unit GameEntities;

type
   TEntity = class
      X, Y : Float;

      constructor Create(aX, aY : Float);
      begin
         X:=aX;
         Y:=aY;
      end;

      {$HINTS OFF}
      function Progress : Boolean; virtual;
      begin
      end;
      {$HINTS ON}

      function Dist2(entity : TEntity) : Float;
      begin
         Result := Sqr(X-entity.X)+Sqr(Y-entity.Y);
      end;
   end;

type
   TBase = class (TEntity)
      Destroyed : Boolean;
      ReadyToFire : Boolean;

      constructor Create(aX, aY : Float);
      begin
         inherited Create(aX, aY);
         Destroyed:=False;
         ReadyToFire:=True;
      end;
   end;

type
   TAsteroid = class (TEntity)
      VX, VY : Float;
      MaxAltitude : Float;
      FrameF, FrameStepF : Float;
      FrameTime : Integer;
      Size : Float;

      constructor Create(spreadX, altitude, maxSpeed : Float);
      begin
         var targetX := (Random*0.9+0.1)*spreadX;
         var speed := (Random*0.5+0.5)*maxSpeed;
         repeat
            VX := (Random-0.5)*speed;
            VY := Sqrt(speed*speed-VX*VX);
            X := targetX-(altitude/VY)*VX;
         until (X in [0..spreadX]);
         MaxAltitude := altitude;
         FrameF := Random*16;
         FrameStepF := 2*Random-1;
         Size := 1.5-Random;
      end;

      function Progress : Boolean; override;
      begin
         X += VX;
         Y += VY;
         VY *= 1.005;
         FrameF += FrameStepF;
         if FrameF<0 then FrameF:=1e5;
         Result:=(Y>MaxAltitude);
         Inc(FrameTime);
      end;

      function Frame : Integer;
      begin
         Result:=Round(FrameF);
      end;
   end;

type
   TMissile = class (TEntity)
      TX, TY : Float;
      Speed : Float;
      Base : TBase;

      constructor Create(fromBase : TBase; aTX, aTY, aSpeed : Float);
      begin
         Base:=fromBase;
         Base.ReadyToFire:=False;
         X:=fromBase.X;
         Y:=fromBase.Y;
         TX:=aTX;
         TY:=aTY;
         Speed:=aSpeed;
      end;

      function Progress : Boolean; override;
      begin
         var dx := TX-X;
         var dy := TY-Y;
         var d := Hypot(dx, dy);
         if d<Speed then exit(True);
         X += dx*Speed/d;
         Y += dy*Speed/d;
      end;
   end;

type
   TBoom = class (TEntity)
      Radius, MaxRadius : Float;

      constructor Create(at : TEntity; aMax : Float);
      begin
         X:=at.X;
         Y:=at.Y;
         MaxRadius:=aMax;
      end;

      function Progress : Boolean; override;
      begin
         Result:=(Radius>=MaxRadius);
         if not Result then
            Radius += Clamp(MaxRadius*0.2, 0, MaxRadius*1.01);
      end;
   end;


