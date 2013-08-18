using System;

namespace TicTacToeLogic
{
    // contains board and rules on where to play (i.e. on a Square filled with None)
    public class Game
    {
        // public
        public Game()
            : base()
        {
            Start(Player.Cross);
        } // no semi-colon after method

        public void Start(Player newPlayer)
        {
            clear();
            currentPlayer = newPlayer;
        }

        // needed for smarter Player algorithms that want to expiriment with boards
        public Board BoardCopy
        {
            get
            {
                return new Board(board);
            }
        }

        public void ClearBoard()
        {
            clear();
        }
        
        // readonly indexer - write is done through the interface methods
        public SquareContent this[Square square]
        {
            get
            {
                return board[square];
            }
        }

        public Square[] EmptySquares()
        {
            return board.EmptySquares();
        }

        public void Play(Square square)
        {
            if (Finished())
            {
                throw new GameException("You can only play if a game is not finished!");
            }
            else
                if (board[square] == SquareContent.None)
                {
                    board[square] = PlayerToContent(currentPlayer);
                    currentPlayer = CurrentOpponent;
                } // semi-colon not allowed before else
                else
                {
                    throw new GameException("you can only play on empty squares!");
                };
        }

        public Player CurrentOpponent
        {
            get
            {
                return (currentPlayer == Player.Cross) ? Player.Nought : Player.Cross;
            }
        }

        public Player CurrentPlayer
        {
            get
            {
                return currentPlayer;
            }
        }

        public const int WinningLineSum = 15;

        public Winner Winner()
        {
            // cannont use "Winner.None" here, as this causes a name-clash
            // because the TicTacToeBoard.Winner method is closer in scope than
            // the Winner enumeration type.
            // Two solutions: either rename the Winner method into something else
            // or provide scope-resolution by specifying the full scope.
            // In this case the full scope is the TicTacToeLogic namespace.

            // step1: check if there is a real winner
            foreach (Player player in Players.All)
            {
                foreach (Line line in Lines.All)
                {
                    if (board.LineSum(line, PlayerToContent(player)) == Game.WinningLineSum)
                    {
                        return (player == Player.Cross) ?
                            TicTacToeLogic.Winner.Cross
                            :
                            TicTacToeLogic.Winner.Nought;
                    };
                };
            };
            // step2: check if there are squares to play
            foreach (Square square in Squares.All)
            {
                if (this[square] == SquareContent.None)
                {
                    return TicTacToeLogic.Winner.None;
                }
            };
            // step3: no real winner, and no squares to play: draw
            return TicTacToeLogic.Winner.Draw;
        }

        public bool Finished()
        {
            return Winner() != TicTacToeLogic.Winner.None;
        }

        public static SquareContent PlayerToContent(Player player)
        {
            return (player == Player.Cross) ? SquareContent.Cross : SquareContent.Nought;
        }

        // private
        private Player currentPlayer;
        private readonly Board board = new Board();
        private void clear()
        {
            foreach (Square square in Squares.All)
            {
                board[square] = SquareContent.None;
            }
        }
    }

}
