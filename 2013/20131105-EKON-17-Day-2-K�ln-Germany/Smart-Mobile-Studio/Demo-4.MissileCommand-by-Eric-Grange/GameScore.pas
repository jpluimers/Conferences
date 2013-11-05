unit GameScore;

uses w3system, w3storage;

const
   cMaxHighScores = 10;

type
   THighScore = record
      Name : String;
      Score : Integer;
   end;

type
   THighScores = array of THighscore;

type
   TGameScore = class
      private

         FName : String;
         FStorage : TW3LocalStorage;
         FScores : THighScores;

      protected

         procedure ReadHighScores;
         begin
            FStorage.Open(FName);
            try
               FScores.SetLength(10);
               var i : Integer;
               for i:=0 to cMaxHighScores-1 do begin
                  FScores[i].Name:=FStorage.getKeyStr('Name'+IntToStr(i), '-');
                  FScores[i].Score:=FStorage.getKeyInt('Score'+IntToStr(i), 0);
               end;
            finally
               FStorage.Close;
            end;
         end;

         procedure WriteHighScores;
         begin
            FStorage.Open(FName);
            try
               var i : Integer;
               for i:=0 to cMaxHighScores-1 do begin
                  FStorage.setKeyStr('Name'+IntToStr(i), FScores[i].Name);
                  FStorage.setKeyInt('Score'+IntToStr(i), FScores[i].Score);
               end;
            finally
               FStorage.Close;
            end;
         end;

         function GetHighScores : THighScores;
         begin
            if FScores.Length=0 then
               ReadHighScores;
            Result:=FScores;
         end;

      public

         constructor Create(name : String);
         begin
            FStorage:=TW3LocalStorage.Create;
         end;

         function RecordHighscore(name : String; score : Integer) : Boolean;
         begin
            GetHighScores;
            var i, j : Integer;
            for i:=0 to cMaxHighScores-1 do begin
               if score>FScores[i].Score then begin
                  var hs : THighScore;
                  hs.Name:=name;
                  hs.Score:=score;
                  for j:=cMaxHighScores-1 downto i+1 do
                     FScores[j]:=FScores[j-1];
                  FScores[i]:=hs;
                  WriteHighScores;
                  Exit(True);
               end;
            end;
            Result:=False;
         end;

         property HighScores : THighScores read GetHighScores;
   end;



