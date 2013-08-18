using MonoTouch.UIKit;
using System.Drawing;
using System;
using MonoTouch.Foundation;

using TicTacToeLogic;

namespace TicTacToeMonoTouchSingleViewUniversal
{
	public partial class TicTacToeMonoTouchSingleViewUniversalViewController : UIViewController
	{
		public TicTacToeMonoTouchSingleViewUniversalViewController (string nibName, NSBundle bundle) : base (nibName, bundle)
		{
		}
		
		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}
		
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			
			//any additional setup after loading the view, typically from a nib.			
			
			timer = NSTimer.CreateRepeatingScheduledTimer (TimeSpan.FromSeconds (1), oneSecondTimerShot);
		}
		
		public override void ViewDidUnload ()
		{
			base.ViewDidUnload ();
			
			// Release any retained subviews of the main view.
			// e.g. this.myOutlet = null;
			timer.Invalidate();
			timer = null;
		}
		
		public override bool ShouldAutorotateToInterfaceOrientation (UIInterfaceOrientation toInterfaceOrientation)
		{
			// Return true for supported orientations
			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
				return (toInterfaceOrientation != UIInterfaceOrientation.PortraitUpsideDown);
			} else {
				return true;
			}
		}
		
		/* Controller and View ****************************************************************************************/
		
        private UIButton this[Square square]
        {
            get
            {
                UIButton[] boardButtons = 
				{
					button1, button2, button3,
					button4, button5, button6, 
					button7, button8, button9
				};
                return boardButtons[(int)square];
            }
        }

        private Square buttonSquare(UIButton button)
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
                this[square].SetTitle(text, UIControlState.Normal);				
            }
        }

        private void viewToBoard()
        {
            foreach (Square square in Squares.All)
            {
				string text = this[square].Title(UIControlState.Normal);
                board[square] = SquareContentMapper.ToContent(text);
            }
        }

        private void clearBoard()
        {
            foreach (Square square in Squares.All)
            {
                board[square] = SquareContent.None;
            }
            viewToBoard();
        }
		
        private void playBoardButton(UIButton playButton)
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
            string text = (game.CurrentPlayer == Player.Cross) ? "X plays" : "O plays";
			currentPlayerLabel.Text = text;
        }

        private void playGameButton(UIButton playButton)
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
                    (game.CurrentPlayer == Player.Cross) && (computerXSwitch.On) // computer plays X
                ||
                    (game.CurrentPlayer == Player.Nought) && (computerOSwitch.On) // computer plays O
                    )
                {
                    BasePlayer player = new SimplePlayer(); // RandomPlayer();
                    player.PlayBestMove(game);
                    gameToView();
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
		
		/* Event handing **********************************************************************************************/
		
		NSTimer timer;
				
		private void oneSecondTimerShot()
		{
            computerPlay();
		}
  
		partial void boardButtonClick (MonoTouch.Foundation.NSObject sender)
		{
			try
            {
                playGameButton(sender as UIButton);
            }
            catch (GameException ex)
            {
                MessageBox.Show(ex.Message);
            }
		}
		
		partial void startOButtonClick (MonoTouch.Foundation.NSObject sender)
		{
            startGame(Player.Nought);
		}
		
		partial void startXButtonClick (MonoTouch.Foundation.NSObject sender)
		{
            startGame(Player.Cross);
		}
	}
}