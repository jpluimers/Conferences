using System;

namespace TicTacToeLogic
{
    public static class Players
    {
#if WINDOWS_PHONE
        public static System.Collections.Generic.IEnumerable<Player> All
        {
            get
            {
                return EnumHelpers.GetValues(new Player());
            }
        }
#else
        public static Array All
        {
            get
            {
                return Enum.GetValues(typeof(Player));
            }
        }
#endif
    }
}
