using System;

namespace TicTacToeLogic
{
    public delegate void SquareDelegate(Square square);

    public static class Squares
    {
        public static void ForAll(SquareDelegate squareDelegate)
        {
            foreach (Square square in All)
            {
                squareDelegate(square);
            };
        }

#if WINDOWS_PHONE
        public static System.Collections.Generic.IEnumerable<Square> All
        {
            get
            {
                return EnumHelpers.GetValues(new Square());
            }
        }
#else
        public static Array All
        {
            get
            {
                return Enum.GetValues(typeof(Square));
            }
        }
#endif
    }
}
