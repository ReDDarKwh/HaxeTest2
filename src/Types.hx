/**	This abstract enum is used by the Controller class to bind general game actions to actual keyboard keys or gamepad buttons. **/
enum abstract GameAction(Int) to Int {
	var MoveLeft;
	var MoveRight;
	var MoveUp;
	var MoveDown;

	var Jump;
	var Restart;

	var MenuUp;
	var MenuDown;
	var MenuOk;
	var MenuCancel;
	var Pause;

	var OpenConsoleFlags;
	var ToggleDebugDrone;
	var DebugDroneZoomIn;
	var DebugDroneZoomOut;
	var DebugTurbo;
	var DebugSlowMo;                
	var ScreenshotMode;
}