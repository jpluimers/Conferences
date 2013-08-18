namespace TicTacToeWindowsFormsApplication
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.button6 = new System.Windows.Forms.Button();
            this.button7 = new System.Windows.Forms.Button();
            this.button8 = new System.Windows.Forms.Button();
            this.button9 = new System.Windows.Forms.Button();
            this.buttonClearBoard = new System.Windows.Forms.Button();
            this.buttonViewToBoard = new System.Windows.Forms.Button();
            this.buttonBoardToView = new System.Windows.Forms.Button();
            this.buttonTestButtonSquare = new System.Windows.Forms.Button();
            this.buttonStartX = new System.Windows.Forms.Button();
            this.buttonStartO = new System.Windows.Forms.Button();
            this.currentPlayerLabel = new System.Windows.Forms.Label();
            this.ComputerXCheckBox = new System.Windows.Forms.CheckBox();
            this.ComputerOCheckBox = new System.Windows.Forms.CheckBox();
            this.ComputerPlaysTimer = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(16, 16);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(32, 32);
            this.button1.TabIndex = 0;
            this.button1.Text = "1";
            this.button1.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(64, 16);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(32, 32);
            this.button2.TabIndex = 1;
            this.button2.Text = "2";
            this.button2.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(112, 16);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(32, 32);
            this.button3.TabIndex = 2;
            this.button3.Text = "3";
            this.button3.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(16, 64);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(32, 32);
            this.button4.TabIndex = 3;
            this.button4.Text = "4";
            this.button4.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(64, 64);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(32, 32);
            this.button5.TabIndex = 4;
            this.button5.Text = "5";
            this.button5.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button6
            // 
            this.button6.Location = new System.Drawing.Point(112, 64);
            this.button6.Name = "button6";
            this.button6.Size = new System.Drawing.Size(32, 32);
            this.button6.TabIndex = 5;
            this.button6.Text = "6";
            this.button6.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button7
            // 
            this.button7.Location = new System.Drawing.Point(16, 112);
            this.button7.Name = "button7";
            this.button7.Size = new System.Drawing.Size(32, 32);
            this.button7.TabIndex = 6;
            this.button7.Text = "7";
            this.button7.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button8
            // 
            this.button8.Location = new System.Drawing.Point(64, 112);
            this.button8.Name = "button8";
            this.button8.Size = new System.Drawing.Size(32, 32);
            this.button8.TabIndex = 7;
            this.button8.Text = "8";
            this.button8.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // button9
            // 
            this.button9.Location = new System.Drawing.Point(112, 112);
            this.button9.Name = "button9";
            this.button9.Size = new System.Drawing.Size(32, 32);
            this.button9.TabIndex = 8;
            this.button9.Text = "9";
            this.button9.Click += new System.EventHandler(this.boardButton_Click);
            // 
            // buttonClearBoard
            // 
            this.buttonClearBoard.Location = new System.Drawing.Point(160, 16);
            this.buttonClearBoard.Name = "buttonClearBoard";
            this.buttonClearBoard.Size = new System.Drawing.Size(128, 23);
            this.buttonClearBoard.TabIndex = 9;
            this.buttonClearBoard.Text = "ClearBoard";
            this.buttonClearBoard.Click += new System.EventHandler(this.buttonClearBoard_Click);
            // 
            // buttonViewToBoard
            // 
            this.buttonViewToBoard.Location = new System.Drawing.Point(160, 48);
            this.buttonViewToBoard.Name = "buttonViewToBoard";
            this.buttonViewToBoard.Size = new System.Drawing.Size(128, 23);
            this.buttonViewToBoard.TabIndex = 10;
            this.buttonViewToBoard.Text = "viewToBoard";
            this.buttonViewToBoard.Click += new System.EventHandler(this.buttonBoardToStorage_Click);
            // 
            // buttonBoardToView
            // 
            this.buttonBoardToView.Location = new System.Drawing.Point(160, 80);
            this.buttonBoardToView.Name = "buttonBoardToView";
            this.buttonBoardToView.Size = new System.Drawing.Size(128, 23);
            this.buttonBoardToView.TabIndex = 11;
            this.buttonBoardToView.Text = "boardToView";
            this.buttonBoardToView.Click += new System.EventHandler(this.buttonStorageToBoard_Click);
            // 
            // buttonTestButtonSquare
            // 
            this.buttonTestButtonSquare.Location = new System.Drawing.Point(160, 112);
            this.buttonTestButtonSquare.Name = "buttonTestButtonSquare";
            this.buttonTestButtonSquare.Size = new System.Drawing.Size(128, 23);
            this.buttonTestButtonSquare.TabIndex = 12;
            this.buttonTestButtonSquare.Text = "TestButtonSquare";
            this.buttonTestButtonSquare.Click += new System.EventHandler(this.buttonTestButtonSquare_Click);
            // 
            // buttonStartX
            // 
            this.buttonStartX.Location = new System.Drawing.Point(16, 184);
            this.buttonStartX.Name = "buttonStartX";
            this.buttonStartX.Size = new System.Drawing.Size(128, 23);
            this.buttonStartX.TabIndex = 13;
            this.buttonStartX.Text = "New Game - X starts";
            this.buttonStartX.Click += new System.EventHandler(this.buttonStartX_Click);
            // 
            // buttonStartO
            // 
            this.buttonStartO.Location = new System.Drawing.Point(16, 216);
            this.buttonStartO.Name = "buttonStartO";
            this.buttonStartO.Size = new System.Drawing.Size(128, 23);
            this.buttonStartO.TabIndex = 14;
            this.buttonStartO.Text = "New Game - O starts";
            this.buttonStartO.Click += new System.EventHandler(this.buttonStartO_Click);
            // 
            // currentPlayerLabel
            // 
            this.currentPlayerLabel.Location = new System.Drawing.Point(16, 152);
            this.currentPlayerLabel.Name = "currentPlayerLabel";
            this.currentPlayerLabel.TabIndex = 0;
            this.currentPlayerLabel.Text = "Current player: ";
            // 
            // ComputerXCheckBox
            // 
            this.ComputerXCheckBox.Location = new System.Drawing.Point(168, 184);
            this.ComputerXCheckBox.Name = "ComputerXCheckBox";
            this.ComputerXCheckBox.Size = new System.Drawing.Size(120, 24);
            this.ComputerXCheckBox.TabIndex = 15;
            this.ComputerXCheckBox.Text = "Computer plays X";
            // 
            // ComputerOCheckBox
            // 
            this.ComputerOCheckBox.Location = new System.Drawing.Point(168, 216);
            this.ComputerOCheckBox.Name = "ComputerOCheckBox";
            this.ComputerOCheckBox.Size = new System.Drawing.Size(120, 24);
            this.ComputerOCheckBox.TabIndex = 16;
            this.ComputerOCheckBox.Text = "Computer plays O";
            // 
            // ComputerPlaysTimer
            // 
            this.ComputerPlaysTimer.Enabled = true;
            this.ComputerPlaysTimer.Interval = 2000;
            this.ComputerPlaysTimer.Tick += new System.EventHandler(this.ComputerPlaysTimer_Tick);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(292, 273);
            this.Controls.Add(this.ComputerOCheckBox);
            this.Controls.Add(this.ComputerXCheckBox);
            this.Controls.Add(this.currentPlayerLabel);
            this.Controls.Add(this.buttonStartO);
            this.Controls.Add(this.buttonStartX);
            this.Controls.Add(this.buttonTestButtonSquare);
            this.Controls.Add(this.buttonBoardToView);
            this.Controls.Add(this.buttonViewToBoard);
            this.Controls.Add(this.buttonClearBoard);
            this.Controls.Add(this.button9);
            this.Controls.Add(this.button8);
            this.Controls.Add(this.button7);
            this.Controls.Add(this.button6);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Name = "MainForm";
            this.Text = "Main Form: play tic tac toe (noughts and crosses)";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.Button button6;
        private System.Windows.Forms.Button button7;
        private System.Windows.Forms.Button button8;
        private System.Windows.Forms.Button button9;
        private System.Windows.Forms.Button buttonClearBoard;
        private System.Windows.Forms.Button buttonTestButtonSquare;
        private System.Windows.Forms.Button buttonViewToBoard;
        private System.Windows.Forms.Button buttonBoardToView;
        private System.Windows.Forms.Button buttonStartX;
        private System.Windows.Forms.Button buttonStartO;
        private System.Windows.Forms.Label currentPlayerLabel;
        private System.Windows.Forms.CheckBox ComputerXCheckBox;
        private System.Windows.Forms.CheckBox ComputerOCheckBox;
        private System.Windows.Forms.Timer ComputerPlaysTimer;
    }
}

