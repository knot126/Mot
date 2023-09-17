import std.stdio;
import log;
import game;

void main() {
	MTLog(MTLogLevel.Info, "You are the UwU   - knot");
	
	gGame.init();
	
	// MTLexerResult lr = MTGenericLexerProcessString("a != b, !item, \t @ f3 && f4 || f5 // 0.6; \n 5 + 0.6");
	// lr.print();
	
	gGame.run();
	
	gGame.end();
}
