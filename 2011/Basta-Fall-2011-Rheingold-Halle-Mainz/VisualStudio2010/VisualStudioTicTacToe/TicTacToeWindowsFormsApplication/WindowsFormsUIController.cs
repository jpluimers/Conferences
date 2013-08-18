using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

using TicTacToeLogic;

namespace TicTacToeWindowsFormsApplication
{
    class WindowsFormsUIController : GenericAbstractUIController<Button, Button, CheckBox, Label>
    {
        public WindowsFormsUIController(
            Button boardbutton1, Button boardButton2, Button boardButton3, 
            Button boardButton4, Button boardButton5, Button boardButton6, 
            Button boardButton7, Button boardButton8, Button boardButton9, 
            Button startGameWithPlayerOButton, Button startGameWithPlayerXButton, 
            CheckBox computerPlayerOOnOff, CheckBox computerPlayerXOnOff,
            Label statusTextLabel)
            : base(
            boardbutton1, boardButton2, boardButton3, 
            boardButton4, boardButton5, boardButton6, 
            boardButton7, boardButton8, boardButton9, 
            startGameWithPlayerOButton, startGameWithPlayerXButton, 
            computerPlayerOOnOff, computerPlayerXOnOff,
            statusTextLabel)
        {
        }

        public override string GetBoardButtonText(Button boardButton)
        {
            return boardButton.Text;
        }

        public override void SetBoardButtonText(Button boardButton, string text)
        {
            boardButton.Text = text;
        }

        public override void SetStatusText(string text)
        {
            StatusTextLabel.Text = text;
        }

        public override void ShowMessage(string message)
        {
            MessageBox.Show(message);
        }

        public override bool ComputerOnOffIsOn(CheckBox computerOnOff)
        {
            return computerOnOff.Checked;
        }
 
    }
}
