VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "SHDOCVW.DLL"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SMSer :Christopher Redfearn:"
   ClientHeight    =   6090
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6090
   ScaleWidth      =   3615
   StartUpPosition =   3  'Windows Default
   Begin ComctlLib.StatusBar StatusBar 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   14
      Top             =   5835
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   450
      SimpleText      =   ""
      _Version        =   327682
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   2
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            AutoSize        =   1
            Bevel           =   0
            Object.Width           =   3757
            Object.Tag             =   ""
         EndProperty
         BeginProperty Panel2 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Alignment       =   2
            AutoSize        =   2
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame fraMessage 
      Caption         =   "Message"
      Height          =   3975
      Left            =   0
      TabIndex        =   6
      Top             =   1680
      Width           =   3615
      Begin VB.CommandButton cmdCancel 
         Caption         =   "&Cancel"
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   3600
         Width           =   3375
      End
      Begin VB.CommandButton cmdSend 
         Caption         =   "&Send"
         Default         =   -1  'True
         Enabled         =   0   'False
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   3240
         Width           =   3375
      End
      Begin SHDocVwCtl.WebBrowser WebBrowser 
         Height          =   375
         Left            =   2280
         TabIndex        =   11
         Top             =   480
         Visible         =   0   'False
         Width           =   495
         ExtentX         =   873
         ExtentY         =   661
         ViewMode        =   0
         Offline         =   0
         Silent          =   0
         RegisterAsBrowser=   0
         RegisterAsDropTarget=   1
         AutoArrange     =   0   'False
         NoClientEdge    =   0   'False
         AlignLeft       =   0   'False
         ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
         Location        =   ""
      End
      Begin VB.TextBox txtMessage 
         Height          =   1935
         Left            =   120
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   10
         Top             =   1200
         Width           =   3375
      End
      Begin VB.TextBox txtPhonenumber 
         Height          =   285
         Left            =   120
         TabIndex        =   8
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label lblMessage 
         AutoSize        =   -1  'True
         Caption         =   "Message:"
         Height          =   195
         Left            =   120
         TabIndex        =   9
         Top             =   960
         Width           =   690
      End
      Begin VB.Label lblPhonenumber 
         AutoSize        =   -1  'True
         Caption         =   "Phone Number:"
         Height          =   195
         Left            =   120
         TabIndex        =   7
         Top             =   360
         Width           =   1110
      End
   End
   Begin VB.Frame fraLogin 
      Caption         =   "Login"
      Height          =   1455
      Left            =   0
      TabIndex        =   0
      Top             =   120
      Width           =   3615
      Begin VB.CommandButton cmdLogin 
         Caption         =   "&Login"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   1080
         Width           =   3375
      End
      Begin VB.TextBox txtPassword 
         Height          =   285
         Left            =   1920
         TabIndex        =   4
         Top             =   600
         Width           =   1575
      End
      Begin VB.TextBox txtUsername 
         Height          =   285
         Left            =   120
         TabIndex        =   2
         Top             =   600
         Width           =   1575
      End
      Begin VB.Label lblPassword 
         AutoSize        =   -1  'True
         Caption         =   "Password:"
         Height          =   195
         Left            =   1920
         TabIndex        =   3
         Top             =   360
         Width           =   735
      End
      Begin VB.Label lblUsername 
         AutoSize        =   -1  'True
         Caption         =   "Username:"
         Height          =   195
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   765
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    WebBrowser.Stop
End Sub

Private Sub cmdLogin_Click()
    If ((txtUsername.Text <> "") And (txtPassword.Text <> "")) Then
        cmdSend.Enabled = True
        cmdLogin.Enabled = False
        cmdCancel.Enabled = True
        StatusBar.Panels(2).Text = "Logged In"
        WebBrowser.Navigate2 "http://www.breathe.com/cgi-bin/login.cgi?&extension-attribute-11=" & txtUsername.Text & "&extension-attribute-12=" & txtPassword.Text & "&SUBMIT"
    Else:
        If (txtUsername.Text = "") Then
            MsgBox "Invalid Username!", , "SMSer Error!"
            txtUsername.SetFocus
        End If
        If (txtPassword.Text = "") Then
            MsgBox "Invalid Password!", , "SMSer Error!"
            txtPassword.SetFocus
        End If
    End If
End Sub

Private Sub cmdSend_Click()
    If ((txtMessage.Text <> "") And (txtPhonenumber.Text <> "")) Then
        StatusBar.Panels(2).Text = "Sending..."
        cmdCancel.Enabled = True
        WebBrowser.Navigate2 "http://www.breathe.com/services/textmessaging.html?number=" & txtPhonenumber.Text & "&message=" & txtMessage.Text & "&charleft=113%2F146&submit.x=19&submit.y=7"
    Else:
        If (txtMessage.Text = "") Then
            MsgBox "Invalid Message!", , "SMSer Error!"
            txtMessage.SetFocus
        End If
        If (txtPhonenumber.Text = "") Then
            MsgBox "Invalid Number!", , "SMSer Error!"
            txtNumber.SetFocus
        End If
    End If
End Sub

Private Sub Form_Load()
    StatusBar.Panels(1).Text = "Characters Remaining: 146"
End Sub

Private Sub txtMessage_Change()
    StatusBar.Panels(1).Text = "Characters Remaining: " & (146 - Len(txtMessage.Text))
End Sub

Private Sub WebBrowser_NavigateComplete2(ByVal pDisp As Object, URL As Variant)
    If (URL = "http://www.breathe.com/?loggedin") Then
        StatusBar.Panels(2).Text = "Ready."
    Else:
        StatusBar.Panels(2).Text = "Sent!"
    End If
    cmdCancel.Enabled = False
End Sub

