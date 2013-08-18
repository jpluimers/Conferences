using System;

using Android.App;
using Android.Content;
using Android.Runtime;
using Android.Views;
using Android.Widget;
using Android.OS;

using TicTacToeLogic;

namespace TicTacToeMonoDroid
{
    [Activity (Label = "TicTacToeMonoDroid", MainLauncher = true)]
    public class Activity1 : Activity
    {
        int count = 1;

        protected override void OnCreate (Bundle bundle)
        {
            base.OnCreate (bundle);

            // Set our view from the "main" layout resource
            SetContentView (Resource.Layout.Main);
   
            currentPlayerTextView = FindViewById<TextView>(Resource.Id.currentPlayerTextView);
            
            button1 = FindViewById<Button>(Resource.Id.button1);
            button2 = FindViewById<Button>(Resource.Id.button2);
            button3 = FindViewById<Button>(Resource.Id.button3);
            button4 = FindViewById<Button>(Resource.Id.button4);
            button5 = FindViewById<Button>(Resource.Id.button5);
            button6 = FindViewById<Button>(Resource.Id.button6);
            button7 = FindViewById<Button>(Resource.Id.button7);
            button8 = FindViewById<Button>(Resource.Id.button8);
            button9 = FindViewById<Button>(Resource.Id.button9);

            startXButton = FindViewById<Button>(Resource.Id.startXButton);
            startOButton = FindViewById<Button>(Resource.Id.startOButton);
            computerXCheckBox = FindViewById<CheckBox>(Resource.Id.computerXCheckBox);
            computerOCheckBox = FindViewById<CheckBox>(Resource.Id.computerOCheckBox);
            
            setupEvents();
        }

        TextView currentPlayerTextView;
        Button button1;
        Button button2;
        Button button3;
        Button button4;
        Button button5;
        Button button6;
        Button button7;
        Button button8;
        Button button9;
        Button startXButton;
        Button startOButton;
        CheckBox computerXCheckBox;
        CheckBox computerOCheckBox;
        
        System.Timers.Timer oneSecondTimer;
            
        private void setupEvents()
        {
            foreach (Square square in Squares.All)
            {
                Button boardButton = this[square];
                boardButton.Click += HandleBoardButtonClick;
            }            
            startXButton.Click += HandleStartXButtonClick;
            startOButton.Click += HandleStartOButtonClick;
            
            oneSecondTimer = new System.Timers.Timer(1000);
            oneSecondTimer.Elapsed += HandleOneSecondTimerElapsed;
            oneSecondTimer.Enabled = true;
        }

        /* Event handlers *************************************************************************************************/

        void HandleOneSecondTimerElapsed (object sender, System.Timers.ElapsedEventArgs e)
        {
            RunOnUiThread(delegate
            {
                computerPlay();
            }
            );
        }
        
        void HandleStartOButtonClick (object sender, EventArgs e)
        {
            startGame(Player.Nought);
        }

        void HandleStartXButtonClick (object sender, EventArgs e)
        {
            startGame(Player.Cross);
        }
     
        void HandleBoardButtonClick (object sender, EventArgs e)
        {
            try
            {
                playGameButton(sender as Button);
            }
            catch (GameException ex)
            {
                MessageBox_Show(ex.Message);
            }
        }
        
        /* Platform specific helpers ***************************************************************************************/
        
        private void MessageBox_Show(string text)
        {
            Toast.MakeText(this, text, ToastLength.Short).Show();
        }
        
        /* Model and View *************************************************************************************************/
		
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
                this[square].Text = text;
#endif
            };
        }

        private void viewToBoard()
        {
            foreach (Square square in Squares.All)
            {
                board[square] = SquareContentMapper.ToContent(this[square].Text);
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
            {
                MessageBox_Show("you can only play on empty squares!");
            }
            return;
        } // semi-colon not allowed

        Player currentPlayer = Player.Cross;
        #endregion step1board

        #region step2game
        private void gameToView()
        {
            boardToView();
            currentPlayerTextView.Text = (game.CurrentPlayer == Player.Cross) ? "X plays" : "O plays";
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
                    (game.CurrentPlayer == Player.Cross) && (computerXCheckBox.Checked) // computer plays X
                ||
                    (game.CurrentPlayer == Player.Nought) && (computerOCheckBox.Checked) // computer plays O
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
                MessageBox_Show(winnerText);
        }


        /*
        protected override void OnCreate (Bundle bundle)
        {
            base.OnCreate (bundle);

            // Set our view from the "main" layout resource
            SetContentView (Resource.Layout.Main);

            // Get our button from the layout resource,
            // and attach an event to it
            Button button = FindViewById<Button> (Resource.Id.myButton);
            
            button.Click += delegate {
                button.Text = string.Format ("{0} clicks!", count++); };
        }
		
		 */
		/* Old Main.axml:
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:orientation="vertical"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    >
<Button  
    android:id="@+id/myButton"
    android:layout_width="fill_parent" 
    android:layout_height="wrap_content" 
    android:text="@string/hello"
    />
</LinearLayout>
		 */
    }
}


