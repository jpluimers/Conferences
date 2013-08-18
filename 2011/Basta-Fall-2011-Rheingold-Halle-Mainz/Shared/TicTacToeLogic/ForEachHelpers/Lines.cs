using System;

namespace TicTacToeLogic
{
    public static class Lines
    {
#if WINDOWS_PHONE
        public static System.Collections.Generic.IEnumerable<Line> All
        {
            get
            {
                return EnumHelpers.GetValues(new Line());
            }
        }
#else
        public static Array All
        {
            get
            {
                return Enum.GetValues(typeof(Line));
            }
        }
#endif
    }
}
