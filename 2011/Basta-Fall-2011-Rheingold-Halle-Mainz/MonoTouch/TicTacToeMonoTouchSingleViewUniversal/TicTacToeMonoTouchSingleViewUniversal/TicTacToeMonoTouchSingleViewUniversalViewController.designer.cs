// WARNING
//
// This file has been generated automatically by MonoDevelop to store outlets and
// actions made in the Xcode designer. If it is removed, they will be lost.
// Manual changes to this file may not be handled correctly.
//
using MonoTouch.Foundation;

namespace TicTacToeMonoTouchSingleViewUniversal
{
	[Register ("TicTacToeMonoTouchSingleViewUniversalViewController")]
	partial class TicTacToeMonoTouchSingleViewUniversalViewController
	{
		[Outlet]
		MonoTouch.UIKit.UILabel currentPlayerLabel { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button1 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button2 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button3 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button4 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button5 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button6 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button7 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button8 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton button9 { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton startXButton { get; set; }

		[Outlet]
		MonoTouch.UIKit.UIButton startOButton { get; set; }

		[Outlet]
		MonoTouch.UIKit.UISwitch computerXSwitch { get; set; }

		[Outlet]
		MonoTouch.UIKit.UISwitch computerOSwitch { get; set; }

		[Action ("boardButtonClick:")]
		partial void boardButtonClick (MonoTouch.Foundation.NSObject sender);

		[Action ("startXButtonClick:")]
		partial void startXButtonClick (MonoTouch.Foundation.NSObject sender);

		[Action ("startOButtonClick:")]
		partial void startOButtonClick (MonoTouch.Foundation.NSObject sender);
	}
}
