unit GameMenu;

uses w3system, w3components, w3ctrls, GamePanel;

type
   TGameMenu = class(TGamePanel)
      private

         FLblTitle : TW3Label;
         FLblVersion : TW3Label;
         FBtnStart : TW3Button;
         FBtnScores : TW3Button;
         FBtnOptions : TW3Button;

         FOnClickStart : TMouseClickEvent;
         FOnClickScores : TMouseClickEvent;

      protected

         procedure DoClickStart(Sender : TObject);
         begin
            if Assigned(FOnClickStart) then FOnClickStart(Self);
         end;

         procedure DoClickScores(Sender : TObject);
         begin
            if Assigned(FOnClickScores) then FOnClickScores(Self);
         end;

         procedure InitializeObject; override;
         begin
            inherited;

            FLblTitle:=TW3Label.Create(Self);
            FLblTitle.Caption:='Missile<br/>Command';
            FLblTitle.AlignText:=taCenter;
            FLblTitle.Font.Size:=20;
            FLblTitle.Font.Weight:='Bold';

            FLblVersion:=TW3Label.Create(Self);
            FLblVersion.Caption:='v0.2';
            FLblVersion.AlignText:=taCenter;
            FLblVersion.Font.Size:=14;

            FBtnStart:=TW3Button.Create(Self);
            FBtnStart.Caption:='Start';
            FBtnStart.OnClick:=DoClickStart;

            FBtnScores:=TW3Button.Create(Self);
            FBtnScores.Caption:='High Scores';
            FBtnScores.OnClick:=DoClickScores;

            FBtnOptions:=TW3Button.Create(Self);
            FBtnOptions.Caption:='Options';
            FBtnOptions.Enabled:=False;
         end;

         procedure Resize; override;
         begin
            inherited;

            FLblTitle.SetBounds(0, 20, Width, 50);

            FLblVersion.SetBounds(0, 75, Width, 40);

            FBtnStart.Top:=120;
            FBtnStart.Width:=Round(Width*0.7);
            FBtnStart.Left:=(Width-FBtnStart.Width) div 2;

            FBtnScores.Top:=170;
            FBtnScores.Width:=FBtnStart.Width;
            FBtnScores.Left:=FBtnStart.Left;

            FBtnOptions.Top:=220;
            FBtnOptions.Width:=FBtnStart.Width;
            FBtnOptions.Left:=FBtnStart.Left;
         end;

      public

         procedure Setup(pw, ph : Integer);
         begin
            Width:=200;
            Height:=275;

            Left:=(pw-Width) div 2;
            Top:=(ph-Height) div 2;
         end;

         property OnClickStart : TMouseClickEvent read FOnClickStart write FOnClickStart;
         property OnClickScores : TMouseClickEvent read FOnClickScores write FOnClickScores;

   end;


