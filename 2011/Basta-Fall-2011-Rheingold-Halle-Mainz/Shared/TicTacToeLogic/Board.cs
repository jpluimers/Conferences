using System;

namespace TicTacToeLogic
{
    // cannot be a struct, which is a value type (lives locally, copy-on-assignment, etc),
    // because structs cannot have instance field initializers (like content is initialized)
    // so you might want to initialize all struct fields in the constructor, which you can't
    // (because the compiler creates an implicit default constructor behind the scenes).
    // So we use a class, which is a reference type (lives globally, garbage collected, copy reference)

    // TicTacToeBoard knows about Content, Square and Line
    // TicTacToeGame knows about Player and Winner

    public class Board
    {
        // if you introduce any other constructor, 
        // and you want your users to access the empty constructor,
        // then you need to introduce the empty constructor as well.
        public Board()
        {
        }
        // copy constructor
        public Board(Board board)
        {
            // does not work: since array is a reference type, an assignment just copies the reference
            // this.content = board.content; 
            // need to copy; easiest is to use the Array.Copy static method for this
#if DotNetCF
            // This works in .NET CF, the simpler construction does not:
            Array.Copy(board.content, 0, this.content, 0, board.content.Length);
#else
            Array.Copy(board.content, this.content, board.content.Length);
#endif
        }

        // indexed property, which is called an 'indexer' in C# speak
        // and requires the both 'this' and the array as part of the syntax
        public SquareContent this[Square square]
        {
            get
            {
                return content[(int)square];
            }
            set
            {
                content[(int)square] = value; // value is implcit parameter because of indexer
            }
        } // note: a semicolon here is not allowed - we are at the end of an accessor block.

        public int LineSum(Line line, SquareContent content)
        {
            int sum = 0;
            Square[] currentLineSquares = lineSquares[(int)line];
            foreach (Square square in currentLineSquares)
            {
                if (this[square] == content)
                {
                    sum = sum + magicSquare3by3[(int)square];
                };
            };
            return sum;
        }

        // nodig voor de Player die iets slimmer is
        public static Line[] LinesForSquare(Square square)
        {
            Line[] result;
            Line[] currentSquareLines = squareLines[(int)square];
            result = new Line[currentSquareLines.Length];
#if DotNetCF
            // Complex version for .NET CF:
            Array.Copy(currentSquareLines, 0, result, 0, currentSquareLines.Length);
#else
            // Simple version does not work in .NET CF:
            Array.Copy(currentSquareLines, result, currentSquareLines.Length);
#endif
            return result;
        }

        public Square[] EmptySquares()
        {
            int length = 0;
            foreach (Square square in Squares.All)
            {
                if (this[square] == SquareContent.None)
                {
                    length = length + 1;
                }
            }
            Square[] result = new Square[length];

            int index = 0;
            foreach (Square square in Squares.All)
            {
                if (this[square] == SquareContent.None)
                {
                    result[index] = square;
                    index = index + 1;
                }
            }

            return result;
        }

        /* Square numers for board
         * 
         *	0	1	2
         *	3	4	5
         *	6	7	8
         * 
         * Line codes for board
         *				0					0
         *	.	.	.	1		0.	1.	2.	1
         *	.	.	.	2		3.	4.	5.	2
         *	.	.	.	3		6.	7.	8.	3
         *	4	5	6	7		4	5	6	7
         * 
         * Powers of 2
         * 0	1		diagonal
         * 1	2		horizontal
         * 2	4		horizontal
         * 3	8		horizontal
         * 4	16		vertical
         * 5	32		vertical
         * 6	64		vertical
         * 7	128		diagonal
         * 
         * This way, you can have an array of masks indicating which Line 
         * (or Lines)a square of the board is a member of.
         * The centre square 4 is member of 4 different lines.
         * The corner squares 0, 2, 6 and 8 each are member of 3 different lines.
         * The side squares 1, 3, 5 and 7 each are member of 2 different lines.
         * 
         * Square	Lines
         * 0			1	4	7
         * 1			1	5
         * 2		0	1	6
         * 3			2	4
         * 4		0	2	5	7
         * 5			2	6
         * 6		0	3	4
         * 7			3	5	
         * 8			3	6	7
         *
                private int[,] rowMask = 
                {
                    {	2 | 128	| 16,	2 | 32			,	1 | 2 | 64	},
                    {	4 | 16		,	1 | 4 | 32 | 128,	4 | 64		},
                    {	1 | 8 | 16	,	8 | 32			,	8 | 64 | 128}
                };
         */


        /* Content of the board. We store it in a one-dimensional array
         * because a two-dimensional array makes the foreach constructions
         * much more difficult to program.
         * For clarity though, we formulate the constant so it looks like
         * a two-dimensional grid.
         */
        public SquareContent[] content = 
			// easy way to initialize; don't need a constructor now.
		{
			SquareContent.None, SquareContent.None, SquareContent.None, 
			SquareContent.None, SquareContent.None, SquareContent.None, 
			SquareContent.None, SquareContent.None, SquareContent.None
		};

        /* Magic Square
         * 
         * This square has a sum of 15 for all its diagonals and orthogonals.
         * It aids in calculating who has a 3-in-a-row since for each such
         * row, the total will be 15.
         * 
         * It has the same structure as the Content array, so it is easier
         * to use in the LineSum method.
         */
        static private int[] magicSquare3by3 = 
		{
			4, 9, 2,
			3, 5, 7,
			8, 1, 6,
		};
        /* For the determining a winner by getting the first 3-in-a-row,
         * you will need an array of Lines indicating which 
         * squares are part of which Line.
         * 
         * We use a 'jagged' (or 'ragged') array here, 
         * because it is easier to use in the LineSum method
         */
        static private Square[][] lineSquares = 
		{ 
			//            Square1       Square2       Square3           Line
			new Square[] {Square.Two  , Square.Four , Square.Six  }, // Zero
			new Square[] {Square.Zero , Square.One  , Square.Two  }, // One
			new Square[] {Square.Three, Square.Four , Square.Five }, // Two
			new Square[] {Square.Six  , Square.Seven, Square.Eight}, // Three
			new Square[] {Square.Zero , Square.Three, Square.Six  }, // Four
			new Square[] {Square.One  , Square.Four , Square.Seven}, // Five
			new Square[] {Square.Two  , Square.Five , Square.Eight}, // Six
			new Square[] {Square.Zero , Square.Four , Square.Eight}, // Seven
		};

        /* For determining the possible wins for a square,
         * we have a table that links the square to all the lines
         * that it is part of
         * 
         * Square	Lines
         * 0			1	4	7
         * 1			1	5
         * 2		0	1	6
         * 3			2	4
         * 4		0	2	5	7
         * 5			2	6
         * 6		0	3	4
         * 7			3	5	
         * 8			3	6	7
         * 
         */

        static private Line[][] squareLines = 
		{ 
			//          Line0      Line1       Line2       Line3           Square
			new Line[] {           Line.One  , Line.Four , Line.Seven}, // Zero
			new Line[] {           Line.One  , Line.Five             }, // One
			new Line[] {Line.Zero, Line.One  , Line.Six              }, // Two
			new Line[] {           Line.Two  , Line.Four             }, // Three
			new Line[] {Line.Zero, Line.Two  , Line.Five , Line.Seven}, // Four
			new Line[] {           Line.Two  , Line.Six              }, // Five
			new Line[] {Line.Zero, Line.Three, Line.Four             }, // Six
			new Line[] {           Line.Three, Line.Five             }, // Seven
			new Line[] {           Line.Three, Line.Six  , Line.Seven}, // Eight
		};

    }

}