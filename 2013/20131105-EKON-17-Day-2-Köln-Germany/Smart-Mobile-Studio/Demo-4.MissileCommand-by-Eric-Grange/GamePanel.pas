unit GamePanel;

uses w3system, w3components, w3ctrls;

type
   TGamePanel = class(TW3Panel)

      protected

         procedure Resize; override;
         begin
            inherited;

            AlphaBlend:=True;
            Opacity:=75;

            w3_setStyle(handle, 'background-image',
                        '-webkit-gradient(linear, left top, left bottom, from(#ffffff), to(#b0b0ff))');
            w3_setStyle(handle, '-webkit-border-radius', '5px');
            w3_setStyle(handle, '-webkit-box-shadow', 'inset 0 2px rgba(0,0,0,0.1),0 2px rgba(255,255,255,0.3)');
         end;
   end;


