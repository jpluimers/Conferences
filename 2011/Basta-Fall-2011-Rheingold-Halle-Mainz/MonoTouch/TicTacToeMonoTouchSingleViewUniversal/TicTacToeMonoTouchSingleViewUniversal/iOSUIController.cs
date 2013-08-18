using MonoTouch.UIKit;
using System.Drawing;
using System;
using MonoTouch.Foundation;

using TicTacToeLogic;

namespace TicTacToeMonoTouchSingleViewUniversal
{

    public class IOSUIController: GenericAbstractUIController<UIButton, UIButton, UISwitch, UILabel>       
    {
        public IOSUIController (
            // Context context,
            UIButton boardButton1, UIButton boardButton2, UIButton boardButton3, 
            UIButton boardButton4, UIButton boardButton5, UIButton boardButton6, 
            UIButton boardButton7, UIButton boardButton8, UIButton boardButton9, 
            UIButton startGameWithPlayerOButton, UIButton startGameWithPlayerXButton,
            UISwitch computerPlayerOCheckBox, UISwitch computerPlayerXCheckBox, 
            UILabel statusTextView
            )
            :
                base(
                    boardButton1, boardButton2, boardButton3, 
                    boardButton4, boardButton5, boardButton6, 
                    boardButton7, boardButton8, boardButton9,
                    startGameWithPlayerOButton,  startGameWithPlayerXButton,
                    computerPlayerOCheckBox,  computerPlayerXCheckBox, 
                    statusTextView
                    )
        {
        }
                
        public override string GetBoardButtonText (UIButton boardButton)
        {
            return boardButton.Title(UIControlState.Normal);
        }
        
        public override void SetBoardButtonText (UIButton boardButton, string text)
        {
            boardButton.SetTitle(text, UIControlState.Normal);
        }
        
        public override bool ComputerOnOffIsOn (UISwitch computerOnOff)
        {
            return computerOnOff.On;
        }
        
        public override void SetStatusText (string text)
        {
            StatusTextLabel.Text = text;
        }
        
        public override void ShowMessage (string message)
        {
            MessageBox.Show(message);
        }
        
    }
}


