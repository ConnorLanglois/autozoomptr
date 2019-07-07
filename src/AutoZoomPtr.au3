#pragma compile(Icon, 'C:\Program Files (x86)\AutoIt3\Icons\au3.ico')
#pragma compile(ExecLevel, requireAdministrator)
#RequireAdmin

Local $hMainWnd
Local $progressPos

_Init()

While True
	Sleep(5000)
WEnd

Func _Init()
	AutoItSetOption('PixelCoordMode', 2)
	AutoItSetOption('SendKeyDelay', 15)
	HotKeySet('{PAUSE}', '_Exit')
	HotKeySet('`', '_Run')
EndFunc

Func _Run()
	Local Static $state = False

	If Not WinExists('Cheat Engine') Then
		Run('C:\Program Files (x86)\Cheat Engine 6.4\cheatengine-i386.exe')
	EndIf

	$hMainWnd = _WinDisplay('Cheat Engine')

	If Not $state Then
		$progressPos = ControlGetPos($hMainWnd, '', '[CLASS:msctls_progress32; INSTANCE:1]')

		ControlClick($hMainWnd, '', '[CLASS:Window; INSTANCE:3]', 'primary')
		_WinDisplay('Process List')
		Send('^f')
		_WinDisplay('Filter')
		ControlSetText('Filter', '', '[CLASS:Edit; INSTANCE:1]', 'league')
		ControlClick('Filter', '', '[CLASS:Button; INSTANCE:2]', 'primary')
		ControlClick('Process List', '', '[CLASS:Button; INSTANCE:3]', 'primary')
		Sleep(500)
		ControlClick($hMainWnd, '', '[CLASS:Button; INSTANCE:4]', 'primary')
		_WinDisplay('Add address')
		ControlCommand('Add address', '', '[CLASS:LCLComboBox; INSTANCE:1]', 'SetCurrentSelection', '5')
		ControlClick('Add address', '', '[CLASS:Button; INSTANCE:1]', 'primary')
		Sleep(300)
		ControlClick('Add address', '', '[CLASS:Button; INSTANCE:2]', 'primary')
		ControlSetText('Add address', '', '[CLASS:Edit; INSTANCE:1]', '224')
		ControlSetText('Add address', '', '[CLASS:Edit; INSTANCE:3]', '"League of Legends.exe"+0114B7D0')
		ControlClick('Add address', '', '[CLASS:Button; INSTANCE:5]', 'primary')
		ControlClick($hMainWnd, '', '[CLASS:Window; INSTANCE:11]', 'primary')
		Send('{DOWN}{F6}{ENTER}')
		_OpReplace()
		Send('{ENTER}3000{ENTER}{F6}')
		_OpReplace()
		Send('{ENTER}3000{ENTER}')
		_WinDisplay('League of Legends (TM) Client')
	Else
		_WinDisplay('Cheat Engine')
		Send('{ENTER}2250{ENTER}')
		_WinDisplay('League of Legends (TM) Client')
	EndIf

	$state = Not $state
EndFunc

Func _OpReplace()
	Local Static $state = False;

	_WinDisplay('Cheat Engine Pointer')
	ControlClick('Cheat Engine Pointer', '', '[CLASS:Button; INSTANCE:1]', 'primary')
	_WinDisplay('The following opcodes write to')
	ControlClick('The following opcodes write to', '', '[CLASS:SysListView32; INSTANCE:1]', 'primary', 1, 10, 10)
	Send('^a')
	ControlClick('The following opcodes write to', '', '[CLASS:Button; INSTANCE:1]', 'primary')

	If $state Then
		Send('{ENTER}')
	EndIf

	WinClose('The following opcodes write to')

	$state = Not $state
EndFunc

Func _ProgressWait()
	While PixelGetColor($progressPos[0] + 5, $progressPos[1] + 5, $hMainWnd) <> 0xE6E6E6
		Sleep(250)
	WEnd
EndFunc

Func _WinDisplay($title)
	Local $hWnd

	$hWnd = WinWait($title, '', 5)

	If Not $hWnd Then
		MsgBox(0, 'ERROR', 'Could not locate window "' & $title & '"')
		_Exit()
	EndIf

	WinActivate($title)

	$hWnd = WinWaitActive($title, '', 5)

	If Not $hWnd Then
		MsgBox(0, 'ERROR', 'Could not activate window "' & $title & '"')
		_Exit()
	EndIf

	Return $hWnd
EndFunc

Func _Exit()
	Exit
EndFunc