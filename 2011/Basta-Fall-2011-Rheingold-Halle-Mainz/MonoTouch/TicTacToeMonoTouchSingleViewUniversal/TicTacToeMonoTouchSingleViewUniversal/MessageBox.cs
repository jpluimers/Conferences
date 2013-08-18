using System;
using MonoTouch.UIKit;

namespace TicTacToeMonoTouchSingleViewUniversal
{
    public static class MessageBox
    {
        public static void Show(string text)
        {
            UIAlertView alertView = new UIAlertView("TicTacToe", text, null, "OK");
            alertView.Show ();
        }
    }
}

