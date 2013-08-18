using System;
using System.Collections.Generic;
using System.Reflection;

namespace TicTacToeLogic
{
    public static class EnumHelpers
    {
        // since Windows Phone is still based on Compact Framework, and CF is a bit crippled:
        // based on http://ideas.dalezak.ca/2008/11/enumgetvalues-in-compact-framework.html
        // note the bizarre "where", as "where T: System.Enum" is not allowed
        public static IEnumerable<T> GetValues<T>(T enumeration) where T : struct, IComparable, IFormattable, IConvertible
        {
            List<T> enumerations = new List<T>();
            foreach (FieldInfo fieldInfo in enumeration.GetType().GetFields(BindingFlags.Static | BindingFlags.Public))
            {
                enumerations.Add((T)fieldInfo.GetValue(enumeration));
            }
            return enumerations;
        }
    }
}
