/*
 * Main game manager
 */

import window;
import lexer;
import maths;
import log;

MTGame gGame;

struct MTGame {
	string name;
	string id;
	
	MTWindow window;
	
	void init() {
		this.name = "Knock";
		this.id = "org.knot126.knock";
		
		this.window = MTWindow();
		this.window.setTitle(this.name);
		this.window.setSize(MTVector2(1280, 720));
		this.window.init();
	}
	
	void run() {
		while (!this.window.shouldClose()) {
			this.window.beginFrame();
			
			this.window.drawBackground(MTColour(0.118, 0.294, 0.388));
			
			MTVector2[] shapeData = [
				MTVector2(0, 0), MTVector2(100, 0),
				MTVector2(200, 200), MTVector2(0, 100)
			];
			this.window.drawQuad(shapeData, MTColour(0.969, 0.663, 0.0));
			
			this.window.endFrame();
		}
	}
	
	void end() {
		this.window.close();
	}
}
