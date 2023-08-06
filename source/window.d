import error;
import maths;
import raylib;

struct MTWindow {
	MTVector2 size;
	string title;
	
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
	
	void close() {
		CloseWindow();
	}
}
