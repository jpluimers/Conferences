using System;

namespace TicTacToeLogic
{
    public class SimplePlayer : BasePlayer
    {
        private bool TryPlayThreeInARowFor(SquareContent content, Game game)
        {
            Square[] emptySquares = game.EmptySquares();

            int length = emptySquares.Length;

            if (length == 0) // no empty squares left; should not occur, but test anyway
                return false;

            foreach (Square square in emptySquares)
            {
                Board tryBoard = game.BoardCopy; // gets a copy of the game board
                tryBoard[square] = content;
                Line[] linesForSquare = Board.LinesForSquare(square); // get a copy
                foreach (Line line in linesForSquare)
                {
                    if (tryBoard.LineSum(line, content) == Game.WinningLineSum)
                    {
                        game.Play(square);
                        return true;
                    };
                };
            };
            return false;
        }

        public override bool PlayBestMove(Game game)
        {
            // strategy 0: no possible moves
            if (game.Finished())
                return false;

            // strategy 1: play a winning move
            // find a line that is winning for the player

            // optimization: 
            // only needed when you have played 2 times (and the opponent 1 or 2 times)
            // so only if there are 6 or less empty Squares, you need to check for this.
            if (TryPlayThreeInARowFor(Game.PlayerToContent(game.CurrentPlayer), game))
            {
                return true;
            }

            // strategy 2: play a blocking move
            // find a line that is winning for the opponent
            if (TryPlayThreeInARowFor(Game.PlayerToContent(game.CurrentOpponent), game))
            {
                return true;
            }

            // strategy 3: try to move on a priority square
            // we base the priority on the number of lines that each square contains
            Square[] emptySquares = game.EmptySquares();
            int length = emptySquares.Length;
            if (length == 0) // no empty squares left; should not occur, but test anyway
                return false;

            Square prioritySquare = emptySquares[0];
            int linesForPrioritySquareLength = Board.LinesForSquare(prioritySquare).Length;
            foreach (Square square in emptySquares)
            {
                int linesForSquareLength = Board.LinesForSquare(square).Length;
                if (linesForSquareLength > linesForPrioritySquareLength)
                {
                    prioritySquare = square;
                    linesForPrioritySquareLength = linesForSquareLength;
                }
            }
            game.Play(prioritySquare);
            return true;

            // strategy 4: random move
            // not needed any more because we can always find a priority square
            //TicTacToePlayer randomPlayer = new RandomTicTacToePlayer();
            //randomPlayer.PlayBestMove(game);
        }
    };

}
