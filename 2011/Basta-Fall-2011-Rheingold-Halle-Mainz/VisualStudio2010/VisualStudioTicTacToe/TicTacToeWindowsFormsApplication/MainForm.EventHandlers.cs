using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

using TicTacToeLogic;

namespace TicTacToeWindowsFormsApplication
{
    public partial class MainForm
    {
        private void ComputerPlaysTimer_Tick(object sender, EventArgs e)
        {
            computerPlay();
        }

        private void boardButton_Click(object sender, EventArgs e)
        {
            try
            {
                playGameButton(sender as Button);
            }
            catch (GameException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void buttonStartO_Click(object sender, EventArgs e)
        {
            startGame(Player.Nought);
        }

        private void buttonStartX_Click(object sender, EventArgs e)
        {
            startGame(Player.Cross);
        }

        private void buttonBoardToStorage_Click(object sender, EventArgs e)
        {
            viewToBoard();
        }

        private void buttonStorageToBoard_Click(object sender, EventArgs e)
        {
            boardToView();
        }

        private void buttonClearBoard_Click(object sender, EventArgs e)
        {
            clearBoard();
        }

        private void buttonTestButtonSquare_Click(object sender, EventArgs e)
        {
            buttonSquare(sender as Button);
        }
    }
}
