package;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

import openfl.Assets;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;

import openfl.media.Sound;

import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFormat;

import openfl.display.FPS;

class Main extends Sprite {
	
	private static inline var BTN_PIN = 22;
	private static inline var LED_PIN = 23;
	private static inline var PWM_PIN = 18;

	private var btnToggle:BitmapToggleFeedback;
	private var btnFeedback:BitmapToggleFeedback;
	private var bitmap:Bitmap;
	private var schema:Bitmap;

    private var format:TextFormat;
    private var tfStatus:TextField;
  	private var pwmValue:Int = 0;

  	private var SoundFeedback:Sound;
	private var Fps:FPS;

	public function new () {
		
		super ();
		PiScreenCapture.setPath("/home/pi/Desktop/");

		PiGpio.wiringPiSetupGpio();
		PiGpio.pinMode(PWM_PIN, PiGpio.PWM_OUTPUT );
		PiGpio.pinMode(LED_PIN, PiGpio.OUTPUT );
		PiGpio.pinMode(BTN_PIN, PiGpio.INPUT );
		PiGpio.pullUpDnControl(BTN_PIN, PiGpio.PUD_UP );

		bitmap = new Bitmap (Assets.getBitmapData ("assets/openfl.png"));
		bitmap.x = (stage.stageWidth - bitmap.width) -8 ;
		bitmap.y = 8;
		addChild (bitmap);

		schema = new Bitmap (Assets.getBitmapData ("assets/schema.png"));
		schema.x = (stage.stageWidth - schema.width) / 2;
		schema.y = (stage.stageHeight - schema.height) / 2;
		addChild (schema);

		btnFeedback = new BitmapToggleFeedback("piLogo_grey","piLogo");
		btnFeedback.x = 120;
		btnFeedback.y = (stage.stageHeight - btnFeedback.height) / 2;
		stage.addChild(btnFeedback);

		btnToggle 	= new BitmapToggleFeedback("led_green_off","led_green_on");
		btnToggle.x = 910;
		btnToggle.y = (stage.stageHeight - btnToggle.height) / 2;
		btnToggle.addEventListener (MouseEvent.MOUSE_DOWN, toggleLed);
		stage.addChild(btnToggle);
		

 		format   = new TextFormat ("Anonymous Pro", 30, 0x7A0026);
        tfStatus = new TextField ();
    
        tfStatus.defaultTextFormat = format;
        tfStatus.embedFonts = true;
        tfStatus.selectable = false;
        
        tfStatus.x = 50;
        tfStatus.y = 50;
        tfStatus.width = 640;
        
        tfStatus.text = "Click on LED to toggle";
        
        addChild (tfStatus);

		SoundFeedback = Assets.getSound ("plonk");

		Fps = new FPS(4,4,0x000000);
		addChild(Fps);

		stage.addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	private function this_onEnterFrame (event:Event):Void {
		var btnValue = PiGpio.digitalRead(BTN_PIN);
		btnFeedback.selected = btnValue==0; //active low!
		/*
		pwmValue+=4;
		pwmValue = pwmValue%1024;
		PiGpio.pwmWrite(PWM_PIN, pwmValue);
		tfStatus.text ="PWM " + pwmValue;
		*/
	}
	
	private function toggleLed(event:MouseEvent):Void
	{
		btnToggle.selected = !btnToggle.selected;
		PiGpio.digitalWrite(LED_PIN, btnToggle.selected?1:0);
		SoundFeedback.play ();
	}

	private function stage_onKeyDown (event:KeyboardEvent):Void
	{	
		switch (event.keyCode) {
			
			case Keyboard.ESCAPE:
				openfl.system.System.exit(0); 
			
			case Keyboard.F4:
				openfl.system.System.exit(0);

			case Keyboard.F6:
				PiScreenCapture.capture();
		}
	}
}