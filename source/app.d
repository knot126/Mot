import std.stdio;
import lexer;
import maths;
import log;
import window;

void main() {
	MTLog(MTLogLevel.Info, "OwO !");
	
	MTWindow window = MTWindow();
	window.setTitle("Knock");
	window.setSize(MTVector2(1280, 720));
	window.init();
	
	MTLexerResult lr = MTGenericLexerProcessString("a != b, !item, \t @ f3 && f4 || f5 // 0.6; \n 5 + 0.6");
	lr.print();
	
	while (!window.shouldClose()) {
		window.beginFrame();
		
		window.drawBackground(MTColour(0.4, 0.2, 0.8));
		
		MTVector2[] shapeData = [
			MTVector2(0, 0), MTVector2(100, 0),
			MTVector2(200, 200), MTVector2(0, 100)
		];
		window.drawQuad(shapeData, MTColour(0.9, 0.6, 0.3));
		
		window.endFrame();
	}
	
	window.close();
}
