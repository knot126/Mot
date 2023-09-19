import std.stdio;
import log;
import game;

void main() {
	MTLog(MTLogLevel.Info, "You are the UwU   - knot");
	
	gGame.init();
	gGame.run();
	gGame.end();
}
