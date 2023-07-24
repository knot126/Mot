/*
 * WA WAHWH AWHWHAHW WHAWAHWHW AW HWAWEW HAWHWAE HWWA WHAWH AWHHW AWHWAH HWAWAWH
 */

import std.stdio;

enum MTLogLevel {
	Info,
	Warning,
	Error,
	Fatal,
}

void MTLog(MTLogLevel type, string message) {
	switch (type) {
		case MTLogLevel.Info:
			write("\033[1;34mInfo: \033[0m");
			break;
		case MTLogLevel.Warning:
			write("\033[1;33mWarning: \033[0m");
			break;
		case MTLogLevel.Error:
			write("\033[1;31mError: \033[0m");
			break;
		case MTLogLevel.Fatal:
			write("\033[1;35mFatal: \033[0m");
			break;
		default:
			break;
	}
	
	writeln(message);
}
