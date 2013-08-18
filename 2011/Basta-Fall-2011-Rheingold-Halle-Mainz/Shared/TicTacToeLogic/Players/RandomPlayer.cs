using System;

namespace TicTacToeLogic
{

    public class RandomPlayer : BasePlayer
    {
        public override bool PlayBestMove(Game game)
        {
            if (game.Finished())
                return false;

            Square[] emptySquares = game.EmptySquares();
            int length = emptySquares.Length;
            if (length == 0) // no empty squares left; should not occur, but test anyway
                return false;

            Random random = new Random();
            while (true)
            {
                int value = random.Next() % length;
                Square square = emptySquares[value];
                game.Play(square);
                return true;
            };
        }
    };

}
