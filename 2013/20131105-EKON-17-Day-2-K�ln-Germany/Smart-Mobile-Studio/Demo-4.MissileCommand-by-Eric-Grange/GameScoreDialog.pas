unit GameScoreDialog;

uses w3system, w3components, w3ctrls, GameScore, GamePanel;

type

   TGameScoreDialog = class(TGamePanel)
      private
         FLblTitle : TW3Label;
         FLblScores : TW3Label;
         FBtnBack : TW3Button;

         FOnBack : TNotifyEvent;

      protected

         procedure DoClickBack(Sender : TObject);
         begin
            if Assigned(FOnBack) then
               FOnBack(Self);
         end;

         procedure InitializeObject; override;
         begin
            inherited;

            FLblTitle:=TW3Label.Create(Self);
            FLblTitle.Caption:='High Scores';
            FLblTitle.AlignText:=taCenter;
            FLblTitle.Font.Size:=18;
            FLblTitle.Font.Weight:='Bold';

            FLblScores:=TW3Label.Create(Self);
            FLblScores.AlignText:=taCenter;
            FLblScores.Font.Name:='Courier New';
            FLblScores.Font.Size:=16;
            FLblScores.Font.Weight:='Bold';

            FBtnBack:=TW3Button.Create(Self);
            FBtnBack.Caption:='Back';
            FBtnBack.OnClick:=DoClickBack;

         end;

         procedure Resize; override;
         begin
            inherited;

            FLblTitle.SetBounds(0, 10, Width, 25);

            FLblScores.SetBounds(0, 30, Width, 240);

            FBtnBack.Top:=270;
            FBtnBack.Width:=Round(Width*0.7);
            FBtnBack.Left:=(Width-FBtnBack.Width) div 2;
         end;

      public

         procedure Setup(pw, ph : Integer);
         begin
            Width:=200;
            Height:=315;

            Left:=(pw-Width) div 2;
            Top:=(ph-Height) div 2;

            Resize;
         end;

         procedure UpdateScore(score : TGameScore);
         begin
            var buf := '<u>Name       Score</u>'#13#10;
            var s := Length(buf)-3-4-2;
            var hs : THighScore;
            for hs in score.HighScores do begin
               var n:=Length(hs.Name)+Length(IntToStr(hs.Score));
               buf += hs.Name+StringOfChar(' ', s-n)+IntToStr(hs.Score)+#13#10;
            end;
            FLblScores.Caption:='<pre>'+buf+'</pre>';
         end;

         property onBack : TNotifyEvent read FOnBack write FOnBack;

   end;


