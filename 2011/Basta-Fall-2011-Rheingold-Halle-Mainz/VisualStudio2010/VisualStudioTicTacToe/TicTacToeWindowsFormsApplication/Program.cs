using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace TicTacToeWindowsFormsApplication
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            //##jp: show how to handle unhandled exceptions
            //Application.Run(new TicTacToePlayForm());
#if showHowToCatchGlobalExceptions
            try
            {
                run();
            }
            catch (System.Exception E)
            {
                System.Windows.Forms.MessageBox.Show(E.ToString());
            }
#else
            run();
#endif
        }

        private static void run()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new MainForm());
        }
    }
}
