using System;

namespace TicTacToeLogic
{
    public static class SquareContentMapper
    {
        public const string Cross = "X";
        public const string Nought = "O";
        public const string None = "-";

        public static string ToText(SquareContent content)
        {
            // the ?: conditional operator is much more readable here
            // than a cascading if-statement...

            //return
            //    content == Content.Cross ? Cross :
            //    (content == Content.Nought ? Nought : None);

            // but a switch statement is even better:
            switch (content)
            {
                default:
                    return None;
                case SquareContent.Nought:
                    return Nought;
                case SquareContent.Cross:
                    return Cross;
            }
        }
        public static SquareContent ToContent(string text)
        {
            // the ?: conditional operator is much more readable here
            // than a cascading if-statement...

            //return
            //    text == Cross ? Content.Cross :
            //    (text == Nought ? Content.Nought : Content.None);

            // but a switch statement is even better:
            switch (text)
            {
                default:
                    return SquareContent.None;
                case Nought:
                    return SquareContent.Nought;
                case Cross:
                    return SquareContent.Cross;
            }
        }
    }
}

