using System;

namespace TicTacToeLogic
{

    // Make sure that all types that are used outside the Board class are public!
    // otherwise you get this compile-time error: 
    // Inconsistent accessibility: return type 'type' is less accessible than method 'method'
    public enum Player { Nought, Cross, }; // comma after last enum value is allowed
    public enum SquareContent { None, Nought, Cross } // semi-colon after an enum type is optional
    public enum Winner { None, Nought, Cross, Draw };
    public enum Line { Zero, One, Two, Three, Four, Five, Six, Seven };
    public enum Square { Zero, One, Two, Three, Four, Five, Six, Seven, Eight };

    // some enumeration examples:
    enum Row { A, B, C };
    enum Column { One = 1, Two, Three }; // can specify the ordinal value

}

