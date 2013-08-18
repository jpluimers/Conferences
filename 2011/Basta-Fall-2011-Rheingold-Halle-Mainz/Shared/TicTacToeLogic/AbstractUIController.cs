using System;

namespace TicTacToeLogic
{
    /// <summary>
    /// TBoardButton types the buttons 1..9
    /// TStartButton types the start buttons for X or O
    /// TComputerOnOff types the CheckBox/OnOff switches that determines when the computer plays X or O
    /// TStatusText shows the game status (which player is about to play)
    /// </summary>
    /// <typeparam name="TBoardButton"></typeparam>
    /// <typeparam name="TStartGameWithPlayerButton"></typeparam>
    /// <typeparam name="TComputerPlayerOnOff"></typeparam>
    /// <typeparam name="TStatusText"></typeparam>
    public abstract class GenericAbstractUIController<TBoardButton, TStartGameWithPlayerButton, TComputerPlayerOnOff, TStatusTextLabel>
        where TBoardButton : class
        where TStartGameWithPlayerButton : class
        where TComputerPlayerOnOff : class
    {
        /// <summary>
        /// Initializes a new instance of the AbstractUIController class.
        /// </summary>
        public GenericAbstractUIController(
            TBoardButton boardButton1, TBoardButton boardButton2, TBoardButton boardButton3,
            TBoardButton boardButton4, TBoardButton boardButton5, TBoardButton boardButton6,
            TBoardButton boardButton7, TBoardButton boardButton8, TBoardButton boardButton9,
            TStartGameWithPlayerButton startGameWithPlayerOButton, TStartGameWithPlayerButton startGameWithPlayerXButton,
            TComputerPlayerOnOff computerPlayerOOnOff, TComputerPlayerOnOff computerPlayerXOnOff,
            TStatusTextLabel statusTextLabel)
        {
            BoardButton1 = boardButton1;
            BoardButton2 = boardButton2;
            BoardButton3 = boardButton3;
            BoardButton4 = boardButton4;
            BoardButton5 = boardButton5;
            BoardButton6 = boardButton6;
            BoardButton7 = boardButton7;
            BoardButton8 = boardButton8;
            BoardButton9 = boardButton9;
            StartGameWithPlayerOButton = startGameWithPlayerOButton;
            StartGameWithPlayerXButton = startGameWithPlayerXButton;
            ComputerPlayerOOnOff = computerPlayerOOnOff;
            ComputerPlayerXOnOff = computerPlayerXOnOff;
            StatusTextLabel = statusTextLabel;
        }

        readonly Game game = new Game();

        #region abstract methods that clients should override

        public abstract string GetBoardButtonText(TBoardButton boardButton);

        public abstract void SetBoardButtonText(TBoardButton boardButton, string text);

        public abstract void SetStatusText(string text);

        public abstract void ShowMessage(string message);

        public abstract bool ComputerOnOffIsOn(TComputerPlayerOnOff computerOnOff);

        #endregion

        #region properties

        public TComputerPlayerOnOff ComputerPlayerXOnOff { get; private set; }
        public TComputerPlayerOnOff ComputerPlayerOOnOff { get; private set; }
        public TStartGameWithPlayerButton StartGameWithPlayerXButton { get; private set; }
        public TStartGameWithPlayerButton StartGameWithPlayerOButton { get; private set; }
        public TBoardButton BoardButton9 { get; private set; }
        public TBoardButton BoardButton8 { get; private set; }
        public TBoardButton BoardButton7 { get; private set; }
        public TBoardButton BoardButton6 { get; private set; }
        public TBoardButton BoardButton5 { get; private set; }
        public TBoardButton BoardButton4 { get; private set; }
        public TBoardButton BoardButton3 { get; private set; }
        public TBoardButton BoardButton2 { get; private set; }
        public TBoardButton BoardButton1 { get; private set; }
        public TStatusTextLabel StatusTextLabel { get; private set; }

        #endregion

        public virtual BasePlayer CreatePlayer()
        {
            return new SimplePlayer(); // RandomPlayer();
        }

        public virtual void GameLoopTimerTick()
        {
            computerPlay();
        }

        public virtual void PlayGameButton(TBoardButton boardButton)
        {
            try
            {
                playGameButton(boardButton);
            }
            catch (GameException ex)
            {
                ShowMessage(ex.Message);
            }
        }

        public Square ButtonSquare(TBoardButton button)
        {
            foreach (Square square in Squares.All)
            {
                if (button == this[square])
                    return square;
            } // semi-colon not needed
            throw new UIControlerException(string.Format("invalid button {0}", button));
        }

        private TBoardButton this[Square square]
        {
            get
            {
                TBoardButton[] boardButtons = 
				{
					BoardButton1, BoardButton2, BoardButton3,
					BoardButton4, BoardButton5, BoardButton6, 
					BoardButton7, BoardButton8, BoardButton9
				};
                return boardButtons[(int)square];
            }
        }

        #region step1board

        private Board gameBoardCopy
        {
            get
            {
                return game.BoardCopy;
            }
        }
			
        public void BoardToView()
        {
            Board theBoard = gameBoardCopy; // in the loop, don't get the board each time from the game
            foreach (Square square in Squares.All)
            {
                string text = SquareContentMapper.ToText(theBoard[square]);
                TBoardButton boardButton = this[square];
                SetBoardButtonText(boardButton, text);
            };
        }

        public void ViewToBoard()
        {
            Board theBoard = gameBoardCopy; // in the loop, don't get the board each time from the game
            foreach (Square square in Squares.All)
            {
                TBoardButton boardButton = this[square];
                string text = GetBoardButtonText(boardButton);
                theBoard[square] = SquareContentMapper.ToContent(text);
            };
        }

        public void ClearBoard()
        {
            game.ClearBoard();
            ViewToBoard();
        }
        #endregion step1board

        #region step2game
        private void gameToView()
        {
            BoardToView();
            string text = string.Format("{0} plays", PlayerMapper.ToText(game.CurrentPlayer));
            SetStatusText(text);
        }

        private void playGameButton(TBoardButton playButton)
        {
            Square square = ButtonSquare(playButton);
            game.Play(square);
            gameToView();
            showWinner(game.Winner());
        }

        public void StartGame(Player newPlayer)
        {
            game.Start(newPlayer);
            gameToView();
        }
        #endregion step2game

        #region step3computer

        private bool isComputerPlaying(Player player, TComputerPlayerOnOff computerPlayerOnOff)
        {
            bool result = game.CurrentPlayer == player;
            result = result && ComputerOnOffIsOn(computerPlayerOnOff);
            return result;
        }

        private void computerPlay()
        {
            if (!game.Finished())
            {
                bool computerIsPlayingForAnyPlayer =
                    isComputerPlaying(Player.Cross, ComputerPlayerXOnOff) // computer plays X
                    ||
                    isComputerPlaying(Player.Nought, ComputerPlayerOOnOff); // computer plays O
                if (computerIsPlayingForAnyPlayer)
                {
                    BasePlayer player = CreatePlayer();
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
                ShowMessage(winnerText);
        }

    }
}
