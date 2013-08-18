using System;

namespace TicTacToeLogic
{
    public static class WinnerMapper
    {
        public static string WinnerText(Winner winner)
        {
            // switch is faster than calling board.Winner multiple times with a ?! operator
            switch (winner)
            {
                default:
                    return string.Empty; // single statement - so no {} compound statement needed
                case Winner.Draw:
                    {
                        return string.Format("{0} - nobody wins", winner);
                    }; // semi-colon needed
                case Winner.Cross:
                case Winner.Nought:
                    {
                        return string.Format("{0} wins, congrats {1}!", winner, ToText(winner));
                    }; // semi-colon needed
            } // semi-colon not needed
        }

        public static string ToText(Winner winner)
        {
            switch (winner)
            {
                case Winner.Nought:
                    return PlayerMapper.Nought;
                case Winner.Cross:
                    return PlayerMapper.Cross;
                default:
                    return string.Empty;
            }
        }
    }
}
