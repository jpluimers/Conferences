using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

using TicTacToeLogic;

namespace TicTacToeWindowsFormsApplication
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }

        private Button this[Square square]
        {
            get
            {
                Button[] boardButtons = 
				{
					button1, button2, button3,
					button4, button5, button6, 
					button7, button8, button9
				};
                return boardButtons[(int)square];
            }
        }

        private Square buttonSquare(Button button)
        {
            foreach (Square square in Squares.All)
            {
                if (button == this[square])
                    return square;
            } // semi-colon not needed
            throw new ApplicationException("invalid button " + button.ToString());
            //MessageBox.Show(String.Format("invalid button {0}", button));
        }

        Game game = new Game();

        #region step1board
        private Board gameBoardCopy
        {
            get
            {
                return game.BoardCopy;
            }
        }

        private void boardToView()
        {
            Board theBoard = gameBoardCopy; // in the loop, don't get the board each time from the game
            foreach (Square square in Squares.All)
            {
                string text = SquareContentMapper.ToText(theBoard[square]);
#if DotNet11
                // .NET 1.1 trick to get around this error message:
                // Property or indexer 'property' cannot be assigned to — it is read only
                Button button = this[square];
                button.Text = Text;
#else
                this[square].Text = text;
#endif
            };
        }

        private void viewToBoard()
        {
            foreach (Square square in Squares.All)
            {
                gameBoardCopy[square] = SquareContentMapper.ToContent(this[square].Text);
            };
        }

        private void clearBoard()
        {
            foreach (Square square in Squares.All)
            {
                gameBoardCopy[square] = SquareContent.None;
            };
            viewToBoard();
        }
        #endregion step1board

        #region step2game
        private void gameToView()
        {
            boardToView();
            currentPlayerLabel.Text = (game.CurrentPlayer == Player.Cross) ? "X plays" : "O plays";
        }

        private void playGameButton(Button playButton)
        {
            Square square = buttonSquare(playButton);
            game.Play(square);
            gameToView();
            showWinner(game.Winner());
        }

        private void startGame(Player newPlayer)
        {
            game.Start(newPlayer);
            gameToView();
        }
        #endregion step2game

        #region step3computer
        private void computerPlay()
        {
            if (!game.Finished())
            {
                if (
                    (game.CurrentPlayer == Player.Cross) && (ComputerXCheckBox.Checked) // computer plays X
                ||
                    (game.CurrentPlayer == Player.Nought) && (ComputerOCheckBox.Checked) // computer plays O
                    )
                {
                    BasePlayer player = new SimplePlayer(); // RandomPlayer();
                    player.PlayBestMove(game);
                    gameToView();
                    showWinner(game.Winner());
                };
            }
        }
        #endregion

        private void showWinner(Winner winner)
        {
            string winnerText = WinnerMapper.WinnerText(winner);
            if (!string.IsNullOrEmpty(winnerText))
                MessageBox.Show(winnerText);
        }

    }
}
