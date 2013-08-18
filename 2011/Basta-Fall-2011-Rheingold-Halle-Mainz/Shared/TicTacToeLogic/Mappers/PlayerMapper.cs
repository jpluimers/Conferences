using System;

namespace TicTacToeLogic
{
    public static class PlayerMapper
    {
        public const string Cross = "X";
        public const string Nought = "O";

        public static string ToText(Player player)
        {
            return (player == Player.Cross) ? Cross : Nought;
        }
        public static Player ToPlayer(string text)
        {
            switch (text)
            {
                default:
                    throw new GameException(string.Format("Invalid player text {0}, can only be {1} or {2}", text, Cross, Nought));
                case Nought:
                    return Player.Nought;
                case Cross:
                    return Player.Cross;
            }
        }
    }
}
