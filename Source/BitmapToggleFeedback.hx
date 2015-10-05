package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;

class BitmapToggleFeedback extends Sprite {

	private var normalStateBitmap:Bitmap;
	private var selectStateBitmap:Bitmap;

	public var selected(default, set):Bool = false;

	public function new( normalName:String, selectName:String){	
		super ();

		normalStateBitmap = new Bitmap (Assets.getBitmapData ("assets/" + normalName + ".png"));
		selectStateBitmap = new Bitmap (Assets.getBitmapData ("assets/" + selectName + ".png"));

		addChild(normalStateBitmap);
	}

	public function set_selected( bVal:Bool):Bool
	{
		selected = bVal;
		draw();
		return selected;
	}

	private function draw():Void{
		if(selected){
			removeChild(normalStateBitmap);
			addChild(selectStateBitmap);
		}else{
			addChild(normalStateBitmap);
			removeChild(selectStateBitmap);
		}
	}
}