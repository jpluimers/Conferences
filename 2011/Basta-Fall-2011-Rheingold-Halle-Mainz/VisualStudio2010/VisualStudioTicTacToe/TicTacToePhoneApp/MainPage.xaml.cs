using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;

using TicTacToeLogic;

namespace TicTacToePhoneApp
{
    public partial class MainPage : PhoneApplicationPage
    {
        // Constructor
        public MainPage()
        {
            InitializeComponent();
            InitializeTimer();
        }

        /* Controller logic and view mapping ********************************************/

        System.Windows.Threading.DispatcherTimer dispatchTimer = new System.Windows.Threading.DispatcherTimer();

        private void InitializeTimer()
        {
            dispatchTimer.Interval = new TimeSpan(0, 0, 1);
            dispatchTimer.Tick += new EventHandler(dispatchTimer_Tick);
            dispatchTimer.Start();
        }

        Game game = new Game();

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
            //System.Windows.Forms.MessageBox.Show(String.Format("invalid button {0}", button));
        }

        #region step1board
        private Board board
        {
            get
            {
                return game.Board;
            }
        }

        private void boardToView()
        {
            Board theBoard = board; // in the loop, don't get the board each time from the game
            foreach (Square square in Squares.All)
            {
                string text = SquareContentMapper.ToText(theBoard[square]);
#if DotNet11
                // .NET 1.1 trick to get around this error message:
                // Property or indexer 'property' cannot be assigned to — it is read only
                Button button = this[square];
                button.Text = Text;
#else
                this[square].Content = text;
#endif
            };
        }

        private void viewToBoard()
        {
            foreach (Square square in Squares.All)
            {
                board[square] = SquareContentMapper.ToContent(this[square].Content.ToString());
            };
        }

        private void clearBoard()
        {
            foreach (Square square in Squares.All)
            {
                board[square] = SquareContent.None;
            };
            viewToBoard();
        }

        private void playBoardButton(Button playButton)
        {
            Square square = buttonSquare(playButton);
            if (board[square] == SquareContent.None)
            {
                board[square] = (currentPlayer == Player.Cross) ? SquareContent.Cross : SquareContent.Nought;
                currentPlayer = (currentPlayer == Player.Cross) ? Player.Nought : Player.Cross;
                boardToView();
                //showWinner(board.Winner()); // board does not know about winner
            } // semi-colon not allowed before else
            else
                MessageBox.Show("you can only play on empty squares!");
            return;
        } // semi-colon not allowed

        Player currentPlayer = Player.Cross;
        #endregion step1board

        #region step2game
        private void gameToView()
        {
            boardToView();
            this.PageTitle.Text = (game.CurrentPlayer == Player.Cross) ? "X plays" : "O plays";
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
            haveShownWinner = false;
            game.Start(newPlayer);
            gameToView();
        }
        #endregion step2game

        #region step3computer

        private bool checkBoxIsChecked(CheckBox checkBox)
        {
            return (checkBox.IsChecked.HasValue) && (checkBox.IsChecked.Value);
        }

        private void computerPlay()
        {
            if (game.Finished())
            {
                showWinner(game.Winner()); // there is no DoEvents in Windows Phone, and no workaround, so do this properly :_
            }
            else
            {
                if (
                    (game.CurrentPlayer == Player.Cross) && (checkBoxIsChecked(computerXCheckBox))// computer plays X
                ||
                    (game.CurrentPlayer == Player.Nought) && (checkBoxIsChecked(computerOCheckBox))  // computer plays O
                    )
                {
                    BasePlayer player = new SimplePlayer(); // RandomPlayer();
                    player.PlayBestMove(game);
                    gameToView();
                };
            }
        }
        #endregion

        private bool haveShownWinner = false;

        private void showWinner(Winner winner)
        {
            if (haveShownWinner)
                return;
            string winnerText = WinnerMapper.WinnerText(winner);
            if (!string.IsNullOrEmpty(winnerText))
            {
                MessageBox.Show(winnerText);
                haveShownWinner = true;
            }
        }

        /* Events ***********************************************************************/

        private void boardButton_Click(object sender, RoutedEventArgs e)
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

        private void startXButton_Click(object sender, RoutedEventArgs e)
        {
            startGame(Player.Cross);
        }

        private void startOButton_Click(object sender, RoutedEventArgs e)
        {
            startGame(Player.Nought);
        }

        void dispatchTimer_Tick(object sender, EventArgs e)
        {
            computerPlay();
        }

    }
}