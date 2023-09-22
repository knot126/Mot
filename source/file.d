import std.stdio;
import std.file;
import std.process;

enum MTFileMode {
	Read = 1,
	Write = 2,
	ReadWrite = 3,
}

string[MTFileMode] gFileModes = null;

struct MTFile {
	File f;
	
	this(string path, MTFileMode mode) {
		// I'm not sure why this can't be initalised at runtime if its in global
		// scope ...
		if (!gFileModes) {
			gFileModes = [
				MTFileMode.Read: "rb",
				MTFileMode.Write: "wb",
				MTFileMode.ReadWrite: "a+",
			];
		}
		
		this.f = File();
		this.f.open(path, gFileModes[mode]);
	}
	
	void read(ref byte[] buf) {
		this.f.rawRead(buf);
	}
	
	byte readByte() {
		auto data = this.f.rawRead(new byte[1]);
		return data[0];
	}
	
	int readInt() {
		auto data = this.f.rawRead(new int[1]);
		return data[0];
	}
	
	uint readUInt() {
		auto data = this.f.rawRead(new uint[1]);
		return data[0];
	}
	
	long readLong() {
		auto data = this.f.rawRead(new long[1]);
		return data[0];
	}
	
	ulong readULong() {
		auto data = this.f.rawRead(new ulong[1]);
		return data[0];
	}
	
	void seek(int mode, long offset) {
		this.f.seek(offset, mode);
	}
	
	size_t tell() {
		return this.f.tell();
	}
	
	size_t length() {
		size_t old = this.tell();
		this.seek(SEEK_END, 0);
		size_t len = this.tell();
		this.seek(SEEK_SET, old);
		return len;
	}
}

byte[] MTLoadFile(string path) {
	if (!isFile(path)) {
		return null;
	}
	
	MTFile file = MTFile(path, MTFileMode.Read);
	
	byte[] data = new byte[file.length()];
	
	file.read(data);
	
	return data;
}

bool MTIsFolder(string path) {
	try {
		return isDir(path);
	}
	catch (FileException) {
		return false;
	}
}

string MTGetHomeFolder() {
	string homedir = environment.get("HOME", "/home/user");
	return homedir;
}

string gConfigName = "Decent Games/Knock";

string MTGetConfigFolder() {
	string confdir = environment.get("APPDATA", MTGetHomeFolder() ~ "/.config") ~ "/" ~ gConfigName ~ "/";
	
	try {
		isDir(confdir);
	}
	catch (FileException) {
		mkdirRecurse(confdir);
	}
	
	return confdir;
}
