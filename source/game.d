/*
 * Main game manager
 */

import window;
import lexer;
import maths;
import log;
import resman;
import mtobject;
import file;

MTGame gGame;

struct MTGame {
	string name;
	string id;
	string configPath;
	
	MTWindow window;
	MTObject[] objects;
	
	void init() {
		this.name = "Knock";
		this.id = "org.knot126.knock.main";
		this.configPath = MTGetConfigFolder();
		
		this.window = MTWindow();
		this.window.setTitle(this.name);
		this.window.setSize(MTVector2(1280, 720));
		this.window.init();
	}
	
	void run() {
		while (!this.window.shouldClose()) {
			MTDrawObjects(this.window, this.objects);
		}
	}
	
	void end() {
		this.window.close();
	}
}

void MTDrawObjects(ref MTWindow window, MTObject[] objects) {
	MTLog(MTLogLevel.Info, "Readying to draw " ~ objects.length.toString() ~ " objects");
	
	window.beginFrame();
	
	window.drawBackground(MTColour(0.118, 0.294, 0.388));
	
	// Draw every object
	for (size_t i = 0; i < objects.length; i++) {
		string renderType = objects[i].get!string("renderType");
		
		switch (renderType) {
			case "OBB":
				MTVector2 pos = objects[i].get!(MTVector2)("pos");
				MTVector2 size = objects[i].get!(MTVector2)("size");
				MTVector2 rot = objects[i].get!(MTVector2)("rot");
				MTColour colour = objects[i].get!(MTColour)("colour");
				
				MTVector2[] shapeData = [
					pos + MTVector2(-1, -1) * size, pos + MTVector2(1, -1) * size,
					pos + size, pos + MTVector2(-1, 1) * size
				];
				
				window.drawQuad(shapeData, MTColour(0.969, 0.663, 0.0));
				break;
			default:
				MTLog(MTLogLevel.Warning, "Unknown render type for object");
		}
	}
	
	window.endFrame();
}

void MTPrepareResMan(string id) {
	if (MTIsFolder("./bundles/org.knot126.knock.main")) {
		gResMan.initWithFolder("./bundles/org.knot126.knock.main");
	}
	else {
		// Need to look up bundle id
		gResMan.initWithBundle(MTGetConfigFolder() ~ "");
	}
}
