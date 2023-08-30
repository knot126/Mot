import error;
import maths;
import raylib;

Color MTColourForColour(MTColour colour) {
	return GetColor(colour.toHex());
}

Vector2 MTVectorForVector(MTVector2 v) {
	Vector2 n;
	n.x = v.x;
	n.y = v.y;
	return n;
}

struct MTWindow {
	MTVector2 size;
	string title;
	int frame;
	
	MTError init() {
		InitWindow(cast(int) this.size.x, cast(int) this.size.y, cast(const char *) this.title);
		SetTargetFPS(60);
		
		return MTError.Success;
	}
	
	void setSize(MTVector2 size) {
		this.size = size;
	}
	
	void setTitle(string title) {
		this.title = title;
	}
	
	bool shouldClose() {
		return !!WindowShouldClose();
	}
	
	void incFrame() {
		this.frame += 1;
	}
	
	int getFrame() {
		return this.frame;
	}
	
	void testUpdate() {
		BeginDrawing();
		
		ClearBackground(GetColor(0xffffffff - this.getFrame() * 1000));
		
		EndDrawing();
		
		this.incFrame();
	}
	
	void beginFrame() {
		BeginDrawing();
	}
	
	void endFrame() {
		EndDrawing();
	}
	
	void drawBackground(MTColour colour) {
		ClearBackground(MTColourForColour(colour));
	}
	
	void drawConvexShape(MTVector2[] points, MTColour colour) {
		/*
		 * Draw some convex shape
		 * 
		 * TODO Fix it :3
		 */
		
		MTVector2 extra = MTVector2(0.0, 0.0);
		
		// averege points for tri fan
		for (int i = 0; i < points.length; i++) {
			extra += (1.0 / (cast(float) points.length)) * points[i];
		}
		
		Vector2 f;
		f.x = extra.x;
		f.y = extra.y;
		
		Vector2[] rlpoints = [f];
		
		// convert points
		for (int i = 0; i <= points.length; i++) {
			Vector2 v;
			v.x = points[i % points.length].x;
			v.y = points[i % points.length].y;
			rlpoints ~= v;
		}
		
		DrawTriangleFan(cast(Vector2 *) rlpoints, cast(int) points.length + 2, MTColourForColour(colour));
	}
	
	void drawQuad(MTVector2[] points, MTColour colour) {
		/*
		 * Draw a quad
		 * 
		 * Raylib requires CCW points :|
		 */
		
		Color c = MTColourForColour(colour);
		Vector2
			p1 = MTVectorForVector(points[0]),
			p2 = MTVectorForVector(points[1]),
			p3 = MTVectorForVector(points[2]),
			p4 = MTVectorForVector(points[3]);
		
		DrawTriangle(p1, p4, p2, c);
		DrawTriangle(p2, p4, p3, c);
	}
	
	void close() {
		CloseWindow();
	}
}

struct MTCanvas {
	
}
