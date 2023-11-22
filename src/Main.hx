class Main extends hxd.App {

	/** Used to create "ControllerAccess" instances that will grant controller usage (keyboard or gamepad) **/
	public var controller : Controller<GameAction>;
	/** Controller Access created for Main & Boot **/
	public var ca : ControllerAccess<GameAction>;

    var light : h3d.scene.fwd.DirLight;

    var tf : h2d.Text;

    override function init() {
        tf = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        tf.text = "Hello World !";

        light = new h3d.scene.fwd.DirLight(new h3d.Vector( 0.3, -0.4, -0.9), s3d);
		light.enableSpecular = true;
		light.color.set(0.28, 0.28, 0.28);

        var c = new h3d.prim.Cube();
        c.addNormals();
		c.addUVs();
		var m = new h3d.scene.Mesh(c, s3d);

        m.material.mainPass.enableLights = true;    
        m.material.shadows = true;
        var c = 0.4;
        var color = new h3d.Vector4(c, c * 0.2, c * 0.6, 0);
        m.material.color.load(color);

        s3d.camera.zNear = 1;
        s3d.camera.zFar = 100;
        var camController = new h3d.scene.CameraController(s3d);
        camController.loadFromCamera();

        initController();
    }

    override function update(dt:Float) {
        super.update(dt);

        if(ca.isDown(Jump)){
            tf.text = "Jump!";
        } else {
            tf.text = "NO Jump";
        }
    }

    	/** Init game controller and default key bindings **/
	function initController() {
		controller = dn.heaps.input.Controller.createFromAbstractEnum(GameAction);
		ca = controller.createAccess();
		
		initControllerBindings();
	}

	function initControllerBindings() {
		controller.removeBindings();

		// Gamepad bindings
		controller.bindPadLStick4(MoveLeft, MoveRight, MoveUp, MoveDown);
		controller.bindPad(Jump, A);
		controller.bindPad(Restart, SELECT);
		controller.bindPad(Pause, START);
		controller.bindPad(MoveLeft, DPAD_LEFT);
		controller.bindPad(MoveRight, DPAD_RIGHT);
		controller.bindPad(MoveUp, DPAD_UP);
		controller.bindPad(MoveDown, DPAD_DOWN);

		// Keyboard bindings
		controller.bindKeyboard(MoveLeft, [K.LEFT, K.Q, K.A]);
		controller.bindKeyboard(MoveRight, [K.RIGHT, K.D]);
		controller.bindKeyboard(MoveUp, [K.UP, K.Z, K.W]);
		controller.bindKeyboard(MoveDown, [K.DOWN, K.S]);
		controller.bindKeyboard(Jump, K.SPACE);
		controller.bindKeyboard(Restart, K.R);
		controller.bindKeyboard(ScreenshotMode, K.F9);
		controller.bindKeyboard(Pause, K.P);
		controller.bindKeyboard(Pause, K.PAUSE_BREAK);

		controller.bindKeyboard(MenuUp, [K.UP, K.Z, K.W]);
		controller.bindKeyboard(MenuDown, [K.DOWN, K.S]);
		controller.bindKeyboard(MenuOk, [K.SPACE, K.ENTER, K.F]);
		controller.bindKeyboard(MenuCancel, K.ESCAPE);

		// Debug controls
		#if debug
		controller.bindPad(DebugTurbo, LT);
		controller.bindPad(DebugSlowMo, LB);
		controller.bindPad(DebugDroneZoomIn, RSTICK_UP);
		controller.bindPad(DebugDroneZoomOut, RSTICK_DOWN);

		controller.bindKeyboard(DebugDroneZoomIn, K.PGUP);
		controller.bindKeyboard(DebugDroneZoomOut, K.PGDOWN);
		controller.bindKeyboard(DebugTurbo, [K.END, K.NUMPAD_ADD]);
		controller.bindKeyboard(DebugSlowMo, [K.HOME, K.NUMPAD_SUB]);
		controller.bindPadCombo(ToggleDebugDrone, [LSTICK_PUSH, RSTICK_PUSH]);
		controller.bindKeyboardCombo(ToggleDebugDrone, [K.D, K.CTRL, K.SHIFT]);
		controller.bindKeyboardCombo(OpenConsoleFlags, [K.F, K.CTRL, K.SHIFT]);
		#end
	}

    static function main() {
        new Main();
    }
}