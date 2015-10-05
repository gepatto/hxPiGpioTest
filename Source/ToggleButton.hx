package;

import openfl.display.Sprite;

class ToggleButton extends Sprite {

	private var circle:Sprite;
	private var _width:Int;
	private var _height:Int;

	public var selected(default, set):Bool = false;

	public function new( w:Int, h:Int){
		super ();

		_width = w;_height = h;		
		circle = new Sprite();
		addChild(circle);
		draw();
	}

	public function set_selected( bVal:Bool):Bool
	{
		selected = bVal;
		draw();
		return selected;
	}

	private function draw():Void{
		var color:Int = selected?0xF53333:0xF5F5F5;
		circle.graphics.clear();
		circle.graphics.beginFill (color);
		circle.graphics.lineStyle (1, 0xCCCCCC);
		circle.graphics.drawRect (0, 0, _width,_height);
	}
}
