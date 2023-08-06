import std.stdio;
import lexer;
import maths;
import log;
import window;

void main() {
	MTLog(MTLogLevel.Info, "OwO !");
	
	MTWindow window = MTWindow();
	window.setTitle("Knock");
	window.setSize(MTVector2(800, 600));
	window.init();
	
	while (!window.shouldClose()) {
		
	}
	
	window.close();
}
