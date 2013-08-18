using System;

namespace TicTacToeLogic
{
    /*
     * All exception classes should override the basic constructors.
     * This way, you can initialize exception objects the same way, no matter what kind of exception class
     * you are instantiating from.
     * This works around the C# limitation of not having virtual constructors.
     *
            public class XxxException : ApplicationException 
            {
                public XxxException() : base() {... }
                public XxxException(string message): base(message) {... }
                public XxxException(string message, Exception inner) : base(message, inner) {... }
                public XxxException(SerializationInfo info, StreamingContext context) : base(info, context) {...}
            }
     */
    public class GameException : ApplicationException
    {
        public GameException() : base() { }
        public GameException(string message) : base(message) { }
        public GameException(string message, Exception inner) : base(message, inner) { }
        // No SerializationInfo in the .NET CF:
#if !WINDOWS_PHONE
        public GameException(System.Runtime.Serialization.SerializationInfo info,
            System.Runtime.Serialization.StreamingContext context)
            : base(info, context) { }
#endif
    }
}
