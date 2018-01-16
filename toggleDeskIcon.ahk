;说明
;  双击桌面空白处，隐藏\显示桌面图标
;参考
;  https://autohotkey.com/board/topic/82196-solved-double-click-on-the-desktop/
#SingleInstance,Force


~LButton::
   if (A_PriorHotKey = A_ThisHotKey) and (A_TimeSincePriorHotkey < 300)
   {
      if desktopBlankSpot()
        hideShowDesktopIcon()  
   }
return

desktopBlankSpot()
{
  LVM_GETSELECTEDCOUNT := 0x1000 + 50
  WinGetClass, Class, A
  if (Class != "WorkerW") and (Class != "Progman")
    return false
  handle := WinExist("A")
  handle := DllCall("GetWindow","Ptr",handle,"Uint",5,"Ptr")
  if (! handle)
    return false
  handle := DllCall("GetWindow","Ptr",handle,"Uint",5,"Ptr")
  if (! handle)
    return false
  SendMessage,%LVM_GETSELECTEDCOUNT%,0,0,,ahk_id %handle%
  return (! ErrorLevel) ; nothing selected = clicked on blank spot
}


hideShowDesktopIcon()
{
	ControlGet, HWND, Hwnd,, SysListView321, ahk_class Progman
	If HWND =
		ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW
	If DllCall("IsWindowVisible", UInt, HWND)
		WinHide, ahk_id %HWND%
	Else
		WinShow, ahk_id %HWND%
}